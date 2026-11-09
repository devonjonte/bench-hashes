//! BLAKE3-Servil's incremental background pipeline as a contender
//! (`Algorithm::Blake3ServilPipeline`): how a program hashes messages whose
//! bytes arrive over time, writing each arrival straight into the room the
//! pipeline gives it, while BLAKE3-Servil's workers hash the rooms already
//! committed. The digest arrives by value on this thread, from the
//! pipeline's handler, when the program collects.
//!
//! One pipeline per thread and limits, made on first use and kept for the
//! process (a pipeline persists; a benchmark never finishes one). Its
//! waits are futures: this program has no executor, so it polls them on
//! its own thread and parks between polls, as the crate's example does.

use blake3_servil::throughput::pipeline::{Event, Limits, Message, Stream};
use blake3_servil::throughput::Batch;
use std::cell::RefCell;
use std::future::Future;
use std::task::{Context, Poll, Wake, Waker};

/// A pipeline's handler is a plain function, so the pipeline's type is
/// nameable and kept in a thread local.
type Pipeline = Stream<'static, usize, fn(Event<'static, usize>)>;
pub(crate) type Open = Message<'static, 'static, usize, fn(Event<'static, usize>)>;

/// The pipeline's budget: 64 rooms of 16 KiB, 1 MiB in flight, and two
/// message slots. A message received alone takes the one being received
/// and the last, until its digest is collected; batches go round two at a
/// time, a slot each.
pub(crate) const LIMITS: (usize, usize) = (64, 2);

thread_local! {
    static PIPELINES: RefCell<Vec<((usize, usize), &'static Pipeline)>> = const { RefCell::new(Vec::new()) };
    /// Digests delivered and not yet taken, with their tags.
    static INBOX: RefCell<Vec<(usize, [u8; 32])>> = const { RefCell::new(Vec::new()) };
    /// Batches handed back with their places, not yet taken.
    static RETURNED: RefCell<Vec<(usize, Batch<'static>, Places)>> = const { RefCell::new(Vec::new()) };
    /// Batches and places kept for the process, by messages per batch.
    static KEPT: RefCell<Vec<(usize, Vec<(Batch<'static>, Places)>)>> = const { RefCell::new(Vec::new()) };
}

/// A batch's digest places, one a message: borrowed for the pipeline's
/// life (BLAKE3-Servil before #309 takes `&'a mut` places for a
/// `Stream<'a, ..>`). The pipeline is kept for the process, so the places
/// are kept too (leaked): the program reaches them again only through the
/// event that hands them back, and can free them never.
type Places = &'static mut [[u8; 32]];

fn deliver(event: Event<'static, usize>) {
    match event {
        Event::Hashed { tag, hash } => {
            INBOX.with(|inbox| inbox.borrow_mut().push((tag, *hash.as_bytes())))
        }
        Event::Aborted { .. } => unreachable!("the benchmark aborts no message"),
        Event::Batch { tag, batch, places } => {
            RETURNED.with(|returned| returned.borrow_mut().push((tag, batch, places)))
        }
    }
}

/// This thread's pipeline with these limits (buffers, messages), made once.
pub(crate) fn pipeline(limits: (usize, usize)) -> &'static Pipeline {
    PIPELINES.with(|all| {
        let mut all = all.borrow_mut();
        if let Some((_, p)) = all.iter().find(|(l, _)| *l == limits) {
            return *p;
        }
        let (buffers, messages) = limits;
        let p: &'static Pipeline = &*Box::leak(Box::new(Stream::new(
            blake3_servil::Mode::Plain,
            Limits { buffers, messages },
            deliver as fn(Event<'static, usize>),
        )));
        all.push((limits, p));
        p
    })
}

struct Unpark(std::thread::Thread);
impl Wake for Unpark {
    fn wake(self: std::sync::Arc<Self>) {
        self.0.unpark();
    }
    fn wake_by_ref(self: &std::sync::Arc<Self>) {
        self.0.unpark();
    }
}

/// Poll on this thread, parking between polls.
pub(crate) fn block_on<F: Future>(future: F) -> F::Output {
    let waker = Waker::from(std::sync::Arc::new(Unpark(std::thread::current())));
    let mut cx = Context::from_waker(&waker);
    let mut future = std::pin::pin!(future);
    loop {
        match future.as_mut().poll(&mut cx) {
            Poll::Ready(value) => return value,
            Poll::Pending => std::thread::park(),
        }
    }
}

/// Write `bytes` into the message, room by room: the program's one copy of
/// an arrival, into the pipeline's storage.
pub(crate) fn write(message: &mut Open, mut bytes: &[u8]) {
    while !bytes.is_empty() {
        let mut room = block_on(message.input());
        let n = room.bytes_mut().len().min(bytes.len());
        room.bytes_mut()[..n].copy_from_slice(&bytes[..n]);
        room.commit(n);
        bytes = &bytes[n..];
    }
}

/// Write the message's last `bytes` and end it: the bytes that fit the
/// final room go with the end, so the worker that takes them knows they
/// are the last.
pub(crate) fn write_last(mut message: Open, mut bytes: &[u8]) {
    loop {
        let mut room = block_on(message.input());
        let free = room.bytes_mut().len();
        if bytes.len() <= free {
            room.bytes_mut()[..bytes.len()].copy_from_slice(bytes);
            drop(room);
            return message.end(bytes.len());
        }
        room.bytes_mut().copy_from_slice(&bytes[..free]);
        room.commit(free);
        bytes = &bytes[free..];
    }
}

/// Take the digests delivered so far, in delivery order.
pub(crate) fn take_delivered(into: &mut Vec<(usize, [u8; 32])>) {
    INBOX.with(|inbox| into.append(&mut inbox.borrow_mut()));
}

/// Collect until at least one digest has been delivered, waiting for the
/// workers when none is ready.
pub(crate) fn wait_for_one(p: &'static Pipeline, into: &mut Vec<(usize, [u8; 32])>) {
    loop {
        p.collect();
        take_delivered(into);
        if !into.is_empty() {
            return;
        }
        block_on(p.ready());
    }
}

/// One message at a time, received in `arrivals`' fragments, each written
/// into the pipeline as it comes; the digest waited for after the last.
pub(crate) fn receive(
    input: &[u8],
    iterations: usize,
    arrivals: &impl Fn(&[u8], &mut dyn FnMut(&[u8])),
    mut consume: impl FnMut(&[u8]),
) {
    let p = pipeline(LIMITS);
    let mut delivered = Vec::with_capacity(1);
    for _ in 0..iterations {
        let mut message = Some(block_on(p.message(0, Some(input.len() as u64))));
        let mut at = 0;
        arrivals(std::hint::black_box(input), &mut |fragment| {
            at += fragment.len();
            if at == input.len() {
                write_last(
                    message.take().expect("the last fragment ends the message"),
                    fragment,
                );
            } else {
                write(
                    message.as_mut().expect("fragments before the last"),
                    fragment,
                );
            }
        });
        if let Some(message) = message.take() {
            message.end(0); // An empty message has no fragments.
        }
        delivered.clear();
        wait_for_one(p, &mut delivered);
        assert_eq!(delivered.len(), 1, "one message, one digest");
        consume(&delivered[0].1);
    }
}

/// `iterations` batches of `messages` 64-byte messages through the
/// pipeline, a complete cycle each: the batch refilled from `input` (each
/// message's 64 bytes copied in, as a program reads its messages into its
/// own batch), submitted, handed back with its places by its completion,
/// its digests consumed whole, and the batch and places used again. As
/// many batches in flight as the pipeline's message slots (LIMITS); at the
/// end, every one still out is waited for, so a sample counts the work it
/// started. `consume` reads digests and does not use the pipeline (the
/// returned batches stay borrowed while it runs).
pub(crate) fn batches(
    input: &[u8],
    messages: usize,
    iterations: usize,
    mut consume: impl FnMut(&[u8]),
) {
    const LEN: usize = 64;
    assert!(
        input.len() >= messages * LEN,
        "the batch's messages come from the input"
    );
    let p = pipeline(LIMITS);
    let mut free = KEPT.with(|kept| {
        let mut kept = kept.borrow_mut();
        match kept.iter().position(|(m, _)| *m == messages) {
            Some(i) => kept.swap_remove(i).1,
            None => (0..LIMITS.1)
                .map(|_| {
                    (
                        Batch::new(LEN, messages),
                        &mut *Box::leak(vec![[0u8; 32]; messages].into_boxed_slice()),
                    )
                })
                .collect(),
        }
    });
    let mut out = 0;
    // The batches handed back, each into the free pairs as its digests
    // are consumed.
    let mut take_back = |free: &mut Vec<(Batch<'static>, Places)>, out: &mut usize| {
        RETURNED.with(|returned| {
            for (_, batch, places) in returned.borrow_mut().drain(..) {
                // The batch's digests whole, as the stream's batch cell
                // hands each place back.
                consume(places.as_flattened());
                free.push((batch, places));
                *out -= 1;
            }
        })
    };
    for i in 0..iterations {
        while free.is_empty() {
            p.collect();
            take_back(&mut free, &mut out);
            if free.is_empty() {
                block_on(p.ready());
            }
        }
        let (mut batch, places) = free.pop().unwrap();
        let input = std::hint::black_box(input);
        for m in 0..messages {
            batch.set(m, &input[m * LEN..][..LEN]);
        }
        block_on(p.submit_batch(batch, places, i));
        out += 1;
        take_back(&mut free, &mut out);
    }
    while out > 0 {
        p.collect();
        take_back(&mut free, &mut out);
        if out > 0 {
            block_on(p.ready());
        }
    }
    KEPT.with(|kept| kept.borrow_mut().push((messages, free)));
}

#[cfg(test)]
mod tests {
    use super::*;

    /// Each batch's digests, handed back through its completion and
    /// consumed, are BLAKE3's digests of its messages, through refills and
    /// on the kept pipeline, at every batch size of the continuous axis.
    #[test]
    fn a_batch_cycle_hashes_every_message_to_blake3() {
        blake3_servil::initialize_multithreaded(None);
        for messages in [1, 16, 64, 1024] {
            // Fresh input each call: the kept pairs come back holding the
            // last call's messages, and a refill that skipped one would
            // pass on the same data.
            for iterations in [1, 2, 5] {
                let input = crate::make_input_seeded(messages * 64, 29 + iterations as u64);
                let want: Vec<[u8; 32]> = input
                    .chunks(64)
                    .map(|m| *blake3::hash(m).as_bytes())
                    .collect();
                let mut got = Vec::new();
                batches(&input, messages, iterations, |d| {
                    got.extend(d.chunks(32).map(|c| <[u8; 32]>::try_from(c).unwrap()))
                });
                assert_eq!(
                    got.len(),
                    iterations * messages,
                    "{messages} messages, {iterations} batches"
                );
                for (k, digest) in got.iter().enumerate() {
                    assert_eq!(
                        *digest,
                        want[k % messages],
                        "{messages} messages, {iterations} batches, digest {k}"
                    );
                }
            }
        }
    }

    /// The pipeline's digest of a message received in fragments is BLAKE3's
    /// digest of the message, at every length around a block, a fragment
    /// and a room, and again on the kept pipeline.
    #[test]
    fn a_received_message_hashes_to_blake3() {
        blake3_servil::initialize_multithreaded(None);
        for len in [
            0,
            1,
            63,
            64,
            65,
            1447,
            1448,
            1449,
            16 * 1024,
            16 * 1024 + 1,
            100_000,
            1 << 20,
        ] {
            let input = crate::make_input_seeded(len, 23);
            let want = *blake3::hash(&input).as_bytes();
            let mut got = Vec::new();
            receive(
                &input,
                2,
                &|input, each| crate::receive::arrivals(input, each, || {}),
                |d| got.push(d.to_vec()),
            );
            assert_eq!(got, vec![want.to_vec(); 2], "{len} bytes");
        }
    }
}

// It reads each thread's CPU time from /proc, which macOS lacks.
#[cfg(all(test, target_os = "linux"))]
mod diagnostic {
    use super::*;

    /// Each thread's CPU time (utime + stime, in clock ticks) from /proc.
    fn thread_times() -> Vec<(String, u64)> {
        let mut out = Vec::new();
        for entry in std::fs::read_dir("/proc/self/task").unwrap() {
            let tid = entry.unwrap().file_name().into_string().unwrap();
            let stat =
                std::fs::read_to_string(format!("/proc/self/task/{tid}/stat")).unwrap_or_default();
            let fields: Vec<&str> = stat
                .rsplit(')')
                .next()
                .unwrap_or("")
                .split_whitespace()
                .collect();
            if fields.len() > 13 {
                let u: u64 = fields[11].parse().unwrap_or(0);
                let s: u64 = fields[12].parse().unwrap_or(0);
                out.push((tid, u + s));
            }
        }
        out
    }

    /// The receive rate in this process, printed (`--no-capture`): the
    /// pipeline against the Hasher, with the threads that were busy and
    /// their CPU time; the pool's size from DIAG_THREADS (the default: one a
    /// CPU). November 7, 2026, VM: the pipeline 0.11 ns/B at 4 threads,
    /// 0.32 at 8 and 16 with 3 CPUs busy for half a CPU of hashing; the
    /// Hasher 0.31 throughout (BLAKE3 #272).
    #[test]
    fn receive_rate_in_this_process() {
        let threads: Option<usize> = std::env::var("DIAG_THREADS")
            .ok()
            .map(|s| s.parse().unwrap());
        blake3_servil::initialize_multithreaded(threads.and_then(std::num::NonZeroUsize::new));
        let input = crate::make_input_seeded(16 << 20, 1);
        let saturated = |input: &[u8], each: &mut dyn FnMut(&[u8])| {
            crate::receive::arrivals(input, each, || {})
        };
        let per_byte =
            |took: std::time::Duration| took.as_nanos() as f64 / (40.0 * 16.0 * 1048576.0);
        for round in 0..3 {
            let before = thread_times();
            let t = std::time::Instant::now();
            let mut n = 0;
            receive(&input, 40, &saturated, |_| n += 1);
            let took = t.elapsed();
            let after = thread_times();
            let (mut busy, mut ticks) = (0, 0);
            for (tid, t1) in &after {
                let t0 = before.iter().find(|(t, _)| t == tid).map_or(0, |(_, t)| *t);
                if *t1 > t0 {
                    busy += 1;
                    ticks += t1 - t0;
                }
            }
            assert_eq!(n, 40);
            eprintln!("threads {threads:?}, round {round}: pipeline {:.3} ns/B over 40 x 16 MiB; {busy} threads busy, {ticks} ticks of CPU (10 ms each) in {} ms", per_byte(took), took.as_millis());
            let t = std::time::Instant::now();
            crate::hash_stream_from::<true>(
                crate::Algorithm::Blake3ServilSt,
                &input,
                40,
                |_| {},
                |input, each| crate::receive::paced(input, each, 0),
            );
            eprintln!(
                "threads {threads:?}, round {round}: Hasher   {:.3} ns/B",
                per_byte(t.elapsed())
            );
        }
    }
}
