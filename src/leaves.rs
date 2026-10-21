/*
 * `bench-hashes leaves`: the leaves of a Merkle tree that a program
 * computes, as a zero-knowledge prover's encoder computes its code words
 * and hashes each as a leaf. N 64-byte messages come from the simplest
 * producer there is, a counter (the buffer's 64-bit words count up from
 * 0, so message i holds 8i .. 8i + 7), the same in every variant; the
 * variants differ in how the program hands them to BLAKE3 servil:
 *
 *   lend-oneshot   produced into the program's buffer, then lent to
 *                  hash_many_multithreaded
 *   lend-stream    produced into the program's buffer, then lent to a
 *                  stream (Stream::submit_batch)
 *   copy-ring      produced into the program's buffer, then copied into
 *                  the stream's ring (Stream::submit_batch_with)
 *   write-ring     produced straight into the stream's ring
 *                  (Stream::submit_batch_with), overlapping the hashing
 *
 * A job is the whole of it, timed as one (the user's decision, October 16,
 * 2026): from producing the first message to having read every digest (each
 * folded into a checksum), nothing subtracted. Each sample records its
 * wall time and, solo, the process's CPU time across it (all its threads,
 * the pool's included), as the main run's samples do; `solo` runs one
 * program, `shared` two at once, each on its own thread and buffers, each
 * program's samples its own (their CPU time is the two programs', so none
 * is recorded). The cells rotate in each round; the samples file is the
 * main run's format, so `bench-hashes compare` reads it.
 */

use super::{machine_metadata, output_directory, SAMPLES_COLUMNS};
use std::fs;

const MESSAGE_LEN: usize = 64;
const COUNTS: [usize; 2] = [16 * 1024, 1 << 20];
const VARIANTS: [&str; 4] = ["lend-oneshot", "lend-stream", "copy-ring", "write-ring"];
const SCENARIOS: [&str; 2] = ["solo", "shared"];
/// A sample's length: jobs back to back for at least this long.
const SAMPLE_NS: u64 = 5_000_000;
const SAMPLES_PER_ROUND: usize = 3;

/// Message `first` on, in `out` (whole messages): the counter.
fn produce(first: usize, out: &mut [u8]) {
    let mut word = (first * MESSAGE_LEN / 8) as u64;
    for w in out.chunks_exact_mut(8) {
        w.copy_from_slice(&word.to_le_bytes());
        word += 1;
    }
}

/// One program's buffers, kept from job to job as a prover keeps its own.
struct Program {
    buffer: Vec<u8>,
    digests: Vec<[u8; 32]>,
    /// The stream variants' places for the digests (kept, as `digests`).
    places: Vec<blake3_servil::Hash>,
}

impl Program {
    fn new(count: usize) -> Program {
        Program { buffer: vec![0u8; count * MESSAGE_LEN], digests: vec![[0u8; 32]; count], places: vec![blake3_servil::Hash::from_bytes([0; 32]); count] }
    }

    /// One job of `variant` over `count` messages: the digests' checksum.
    fn job(&mut self, variant: &str, count: usize) -> [u8; 32] {
        let mut sum = [0u8; 32];
        let mut fold = |hashes: &[blake3_servil::Hash]| {
            for h in hashes {
                for (s, b) in sum.iter_mut().zip(h.as_bytes()) {
                    *s ^= b;
                }
            }
        };
        let buffer = &mut self.buffer[..count * MESSAGE_LEN];
        match variant {
            "lend-oneshot" => {
                produce(0, buffer);
                let digests = &mut self.digests[..count];
                blake3_servil::hash_many_multithreaded(buffer, MESSAGE_LEN, digests);
                // Sound: a Hash is its 32 bytes.
                fold(unsafe { core::slice::from_raw_parts(digests.as_ptr() as *const blake3_servil::Hash, count) });
            }
            // The stream's variants write the digests into the same kept
            // space as lend-oneshot, then fold them as it does.
            "lend-stream" => {
                produce(0, buffer);
                let buffer = &*buffer;
                let places = &mut self.places[..count];
                blake3_servil::stream(
                    blake3_servil::Mode::Hash,
                    |_| {},
                    |s| {
                        s.submit_batch(buffer, MESSAGE_LEN, places);
                        s.finish();
                    },
                );
                fold(&self.places[..count]);
            }
            "copy-ring" => {
                produce(0, buffer);
                let buffer = &*buffer;
                let places = &mut self.places[..count];
                blake3_servil::stream(
                    blake3_servil::Mode::Hash,
                    |_| {},
                    |s| {
                        s.submit_batch_with(MESSAGE_LEN, |at, room| room.copy_from_slice(&buffer[at..][..room.len()]), places);
                        s.finish();
                    },
                );
                fold(&self.places[..count]);
            }
            "write-ring" => {
                let places = &mut self.places[..count];
                blake3_servil::stream(
                    blake3_servil::Mode::Hash,
                    |_| {},
                    |s| {
                        s.submit_batch_with(MESSAGE_LEN, |at, room| produce(at / MESSAGE_LEN, room), places);
                        s.finish();
                    },
                );
                fold(&self.places[..count]);
            }
            _ => unreachable!("a variant of VARIANTS"),
        }
        sum
    }
}

/// The checksum every variant must give: each message hashed alone.
fn expected(count: usize) -> [u8; 32] {
    let mut buffer = vec![0u8; count * MESSAGE_LEN];
    produce(0, &mut buffer);
    let mut sum = [0u8; 32];
    for m in buffer.chunks_exact(MESSAGE_LEN) {
        for (s, b) in sum.iter_mut().zip(blake3_servil::hash(m).as_bytes()) {
            *s ^= b;
        }
    }
    sum
}

/// A sample: wall ns, messages, start ms, and (solo) the process's CPU ns.
type Sample = (u64, u64, u64, Option<u64>);

/// One program's samples of a cell this round, as clocks::measure takes
/// them (jobs enough for SAMPLE_NS, counted once, then that many a
/// sample), each bracketed by the process's CPU time when `solo`.
fn measure_program(program: &mut Program, variant: &str, count: usize, want: [u8; 32], solo: bool) -> Vec<Sample> {
    let mut job = || assert_eq!(program.job(variant, count), want, "{variant}: every leaf's digest");
    let sizing = clocks::now();
    let mut jobs = 0u64;
    while clocks::since_ns(sizing) < SAMPLE_NS {
        job();
        jobs += 1;
    }
    (0..SAMPLES_PER_ROUND)
        .map(|_| {
            clocks::load::tick();
            let started_ns = clocks::load::now_ns();
            let cpu = if solo { clocks::process_cpu_ns() } else { None };
            let t = clocks::now();
            for _ in 0..jobs {
                job();
            }
            let wall_ns = clocks::since_ns(t);
            let cpu_ns = cpu.zip(clocks::process_cpu_ns()).map(|(before, after)| after - before);
            (wall_ns, jobs * count as u64, started_ns / 1_000_000, cpu_ns)
        })
        .collect()
}

fn measure_cell(programs: &mut [Program], variant: &str, count: usize, want: [u8; 32]) -> Vec<Sample> {
    let solo = programs.len() == 1;
    std::thread::scope(|scope| {
        let handles: Vec<_> = programs.iter_mut().map(|p| scope.spawn(move || measure_program(p, variant, count, want, solo))).collect();
        handles.into_iter().flat_map(|h| h.join().expect("a program's thread")).collect()
    })
}

pub fn command(arguments: &[String]) {
    let usage = "bench-hashes leaves [--rounds N] [--variants V,...] [--counts N,...] [--scenarios solo,two]";
    let mut rounds = 12usize;
    let (mut variants, mut counts, mut scenarios) = (VARIANTS.to_vec(), COUNTS.to_vec(), SCENARIOS.to_vec());
    let mut it = arguments.iter();
    let list = |v: Option<&String>| -> Vec<String> { v.expect(usage).split(',').map(str::to_owned).collect() };
    while let Some(a) = it.next() {
        match a.as_str() {
            "--rounds" => rounds = it.next().expect(usage).parse().expect("--rounds takes a whole number"),
            "--variants" => {
                variants =
                    list(it.next()).iter().map(|v| *VARIANTS.iter().find(|&&k| k == v).unwrap_or_else(|| panic!("no variant {v}: {VARIANTS:?}"))).collect()
            }
            "--counts" => counts = list(it.next()).iter().map(|c| c.parse().expect("a count")).collect(),
            "--scenarios" => {
                scenarios = list(it.next()).iter().map(|v| *SCENARIOS.iter().find(|&&k| k == v).unwrap_or_else(|| panic!("no scenario {v}"))).collect()
            }
            other => panic!("{usage}: unknown argument {other}"),
        }
    }
    assert!(rounds >= 2, "two rounds at least");
    blake3_servil::initialize_multithreaded(None);
    let mut machine = machine_metadata();
    let mut cells: Vec<(&str, usize, &str)> = Vec::new();
    for &sc in &scenarios {
        for &n in &counts {
            for &v in &variants {
                cells.push((sc, n, v));
            }
        }
    }
    let wants: Vec<[u8; 32]> = counts.iter().map(|&n| expected(n)).collect();
    let mut programs: Vec<Program> = (0..2).map(|_| Program::new(*counts.iter().max().unwrap())).collect();
    // Each cell's rounds; first one untimed round of every cell (one-time
    // costs: the pool, the stream's storage, the buffers' pages).
    let mut results: Vec<Vec<Sample>> = cells.iter().map(|_| Vec::new()).collect();
    for round in 0..=rounds {
        for k in 0..cells.len() {
            let c = (k + round) % cells.len();
            let (scenario, count, variant) = cells[c];
            let n = if scenario == "solo" { 1 } else { 2 };
            let want = wants[counts.iter().position(|&x| x == count).unwrap()];
            let r = measure_cell(&mut programs[..n], variant, count, want);
            if round > 0 {
                results[c].extend(r);
            }
        }
        eprintln!("bench-hashes leaves: round {round} of {rounds} done");
    }
    machine.load = clocks::load::windows();
    machine.power[1] = super::Power::read();

    let mut tsv = super::samples_header(
        &machine,
        &[
            ("source blake3-servil-mt".to_owned(), super::BLAKE3_SERVIL_SOURCE_INFO.to_owned()),
            ("rounds".to_owned(), rounds.to_string()),
            ("leaves".to_owned(), format!("{MESSAGE_LEN}-byte messages from a counter; wall from producing the first to reading the last digest")),
        ],
    );
    tsv += SAMPLES_COLUMNS;
    tsv += "\n";
    let mut report = String::new();
    for (c, &(scenario, count, variant)) in cells.iter().enumerate() {
        let samples = &results[c];
        let field = |f: &dyn Fn(&Sample) -> String| samples.iter().map(f).collect::<Vec<_>>().join(",");
        let cpu = if samples.iter().all(|x| x.3.is_some()) { field(&|x| x.3.unwrap().to_string()) } else { "-".into() };
        tsv += &format!(
            "{variant}\t{scenario}\tLeaves\t{count} messages\tmsg\t{}\t{}\t{cpu}\t-\t-\n",
            field(&|x| format!("{}/{}", x.0, x.1)),
            field(&|x| x.2.to_string())
        );
        // The report: means over the cell (ns and CPU ns a message, exact
        // totals over totals, shown by the benchmark's one rule for them).
        let per = |num: u64, den: u64| super::format_ns(u128::from(num), u128::from(den));
        let (w, n) = samples.iter().fold((0, 0), |(a, b), x| (a + x.0, b + x.1));
        let cpu = samples.iter().map(|x| x.3).sum::<Option<u64>>().map_or("-".into(), |c| per(c, n));
        report += &format!("{scenario:6} {count:>8} {variant:13} {:>8} ns {:>8} CPU ns  per message\n", per(w, n), cpu);
    }
    let directory = output_directory(&machine);
    fs::create_dir_all(&directory).unwrap();
    let path = directory.join("leaves.samples.tsv");
    fs::write(&path, tsv).unwrap();
    println!(
        "bench-hashes leaves: {}\nload: {}\n\n{report}\n# Samples (TSV) are in {:?} .",
        super::BLAKE3_SERVIL_SOURCE_INFO,
        clocks::load::describe(&machine.load),
        path
    );
}

#[cfg(test)]
mod tests {
    use super::*;

    /// Every variant gives each leaf's own digest (their checksum against
    /// each message hashed alone), at counts that end mid-group and that
    /// fill the stream's ring more than once.
    #[test]
    fn every_variant_hashes_every_leaf() {
        blake3_servil::initialize_multithreaded(None);
        for count in [1, 7, 1000, 1 << 16] {
            let want = expected(count);
            let mut program = Program::new(count);
            for variant in VARIANTS {
                assert_eq!(program.job(variant, count), want, "{variant}, {count} leaves");
            }
        }
    }
}
