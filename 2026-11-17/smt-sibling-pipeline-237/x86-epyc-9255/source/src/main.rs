//! BLAKE3 #237 on the Pipeline: one caller, pinned to a CPU, copies 1 MiB messages into rooms, 8 in
//! flight, for a fixed time. Prints the messages a second and, for every thread, the CPU it last ran
//! on and its CPU time, so a run shows whether a worker shared the caller's core.
//!
//!     smt-probe-237 CALLER_CPU SECONDS
use blake3_servil::Mode;
use blake3_servil::throughput::{Event, Limits, Pipeline, ROOM_LEN, Room, block_on};
use std::time::{Duration, Instant};

const MESSAGE: usize = 1 << 20;
const IN_FLIGHT: usize = 8;

fn pin(cpu: usize) {
    // Sound: a zeroed set, one bit set, passed with its size, for this thread.
    unsafe {
        let mut set: libc::cpu_set_t = std::mem::zeroed();
        libc::CPU_SET(cpu, &mut set);
        assert_eq!(libc::sched_setaffinity(0, std::mem::size_of::<libc::cpu_set_t>(), &set), 0, "pin to CPU {cpu}");
    }
}

fn consume(pipe: &mut Pipeline<()>) -> u8 {
    if pipe.next_event().is_none_or(|e| !matches!(e, Event::Hashed { .. })) {
        block_on(pipe.ready());
        let Some(Event::Hashed { hash, .. }) = pipe.next_event() else { panic!("ready supplies a hash") };
        return hash.as_bytes()[0];
    }
    0
}

/// Messages hashed in `time`.
fn run(pipe: &mut Pipeline<()>, input: &[u8], time: Duration) -> (u64, f64) {
    let start = Instant::now();
    let (mut sent, mut pending, mut sink) = (0u64, 0usize, 0u8);
    let mut room: Option<Room> = None;
    while start.elapsed() < time {
        if pending == IN_FLIGHT {
            sink ^= consume(pipe);
            pending -= 1;
        }
        let mut message = block_on(pipe.message((), Some(MESSAGE as u64)));
        for piece in std::hint::black_box(input).chunks(ROOM_LEN) {
            if room.as_ref().is_none_or(|r| r.len() < piece.len()) {
                drop(room.take());
                room = Some(block_on(pipe.room()));
            }
            let r = room.as_mut().unwrap();
            r.bytes_mut()[..piece.len()].copy_from_slice(piece);
            pipe.commit(&mut message, r, piece.len());
        }
        pipe.end(message);
        pending += 1;
        sent += 1;
    }
    drop(room);
    for _ in 0..pending {
        sink ^= consume(pipe);
    }
    std::hint::black_box(sink);
    (sent, start.elapsed().as_secs_f64())
}

/// (thread id, name, CPU last run on, CPU time in ns) of every thread.
fn threads() -> Vec<(u64, String, usize, u64)> {
    let mut all = Vec::new();
    for entry in std::fs::read_dir("/proc/self/task").unwrap() {
        let dir = entry.unwrap().path();
        let tid = dir.file_name().unwrap().to_str().unwrap().parse().unwrap();
        let stat = std::fs::read_to_string(dir.join("stat")).unwrap();
        // The fields after the name's closing parenthesis; `processor` is the 39th field of the line.
        let rest: Vec<&str> = stat[stat.rfind(')').unwrap() + 2..].split(' ').collect();
        let cpu = rest[36].parse().unwrap();
        let ran = std::fs::read_to_string(dir.join("schedstat")).unwrap().split(' ').next().unwrap().parse().unwrap();
        let name = std::fs::read_to_string(dir.join("comm")).unwrap().trim().to_owned();
        all.push((tid, name, cpu, ran));
    }
    all.sort();
    all
}

fn main() {
    let args: Vec<String> = std::env::args().collect();
    let cpu: usize = args[1].parse().expect("CALLER_CPU");
    let seconds: f64 = args[2].parse().expect("SECONDS");
    blake3_servil::initialize_multithreaded(None);
    let input: Vec<u8> = (0..MESSAGE).map(|i| (i % 251) as u8).collect();
    let mut pipe: Pipeline<()> = Pipeline::new(Mode::Plain, Limits { messages: IN_FLIGHT, rooms: IN_FLIGHT * MESSAGE / ROOM_LEN });
    // The workers exist and settle to their places on the process's CPUs; then the caller alone is pinned.
    run(&mut pipe, &input, Duration::from_millis(300));
    pin(cpu);
    run(&mut pipe, &input, Duration::from_millis(200));
    let before = threads();
    let (sent, took) = run(&mut pipe, &input, Duration::from_secs_f64(seconds));
    let after = threads();
    print!("messages_per_second {:.0}", sent as f64 / took);
    for (tid, name, at, ran) in &after {
        let was = before.iter().find(|t| t.0 == *tid).map_or(0, |t| t.3);
        print!(" {name}@{at}:{:.0}ms", (ran - was) as f64 / 1e6);
    }
    println!();
}
