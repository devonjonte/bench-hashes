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
    /// The messages, in blocks: the batch calls' input (64 bytes on a
    /// 64-byte boundary; MESSAGE_LEN messages leave no padding).
    buffer: Vec<blake3_servil::performance::Block>,
    digests: Vec<[u8; 32]>,
    /// The stream variants' places for the digests (kept, as `digests`).
    places: Vec<blake3_servil::Hash>,
}

impl Program {
    fn new(count: usize) -> Program {
        Program {
            buffer: vec![blake3_servil::performance::Block::ZERO; count * MESSAGE_LEN / 64],
            digests: vec![[0u8; 32]; count],
            places: vec![blake3_servil::Hash::from_bytes([0; 32]); count],
        }
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
        let blocks = &mut self.buffer[..count * MESSAGE_LEN / 64];
        match variant {
            "lend-oneshot" => {
                produce(0, blake3_servil::performance::Block::bytes_mut(blocks));
                let digests = &mut self.digests[..count];
                blake3_servil::performance::hash_many_multithreaded(
                    blake3_servil::Mode::Plain,
                    &blake3_servil::performance::Batch::from_blocks(blocks, MESSAGE_LEN),
                    digests,
                );
                // Sound: a Hash is its 32 bytes.
                fold(unsafe {
                    core::slice::from_raw_parts(
                        digests.as_ptr() as *const blake3_servil::Hash,
                        count,
                    )
                });
            }
            // The stream's variants write the digests into the same kept
            // space as lend-oneshot, then fold them as it does.
            "lend-stream" => {
                produce(0, blake3_servil::performance::Block::bytes_mut(blocks));
                let buffer = blake3_servil::performance::Batch::from_blocks(blocks, MESSAGE_LEN);
                let places = &mut self.places[..count];
                blake3_servil::performance::stream(
                    blake3_servil::Mode::Plain,
                    |_| {},
                    |s| {
                        s.submit_batch(&buffer, places);
                        s.finish();
                    },
                );
                fold(&self.places[..count]);
            }
            "copy-ring" => {
                produce(0, blake3_servil::performance::Block::bytes_mut(blocks));
                let buffer = blake3_servil::performance::Block::bytes(blocks);
                let places = &mut self.places[..count];
                blake3_servil::performance::stream(
                    blake3_servil::Mode::Plain,
                    |_| {},
                    |s| {
                        s.submit_batch_with(
                            MESSAGE_LEN,
                            |at, room| {
                                room.copy_from_slice(&buffer[at..][..room.len()]);
                                room.len()
                            },
                            places,
                        );
                        s.finish();
                    },
                );
                fold(&self.places[..count]);
            }
            "write-ring" => {
                let places = &mut self.places[..count];
                blake3_servil::performance::stream(
                    blake3_servil::Mode::Plain,
                    |_| {},
                    |s| {
                        s.submit_batch_with(
                            MESSAGE_LEN,
                            |at, room| {
                                produce(at / MESSAGE_LEN, room);
                                room.len()
                            },
                            places,
                        );
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
        for (s, b) in sum
            .iter_mut()
            .zip(blake3_servil::convenience::hash(m).as_bytes())
        {
            *s ^= b;
        }
    }
    sum
}

/// One program's whole-job samples, sized and timed by the shared sampler.
/// Shared-process CPU figures are suppressed when the cell is written.
fn measure_program(
    program: &mut Program,
    variant: &str,
    count: usize,
    want: [u8; 32],
) -> Vec<clocks::Batch> {
    let job = || {
        assert_eq!(
            program.job(variant, count),
            want,
            "{variant}: every leaf's digest"
        )
    };
    clocks::measure(SAMPLES_PER_ROUND, SAMPLE_NS, job)
}

fn measure_cell(
    programs: &mut [Program],
    variant: &str,
    count: usize,
    want: [u8; 32],
) -> Vec<clocks::Batch> {
    std::thread::scope(|scope| {
        let handles: Vec<_> = programs
            .iter_mut()
            .map(|p| scope.spawn(move || measure_program(p, variant, count, want)))
            .collect();
        handles
            .into_iter()
            .flat_map(|h| h.join().expect("a program's thread"))
            .collect()
    })
}

/// The existing samples format and report, from the same recorded batches.
fn cell_lines(
    scenario: &str,
    count: usize,
    variant: &str,
    samples: &[clocks::Batch],
) -> (String, String) {
    let units = |b: &clocks::Batch| b.calls * count as u64;
    let field =
        |f: &dyn Fn(&clocks::Batch) -> String| samples.iter().map(f).collect::<Vec<_>>().join(",");
    let cpu_values = if scenario == "solo" {
        samples.iter().map(|b| b.cpu_ns).collect::<Option<Vec<_>>>()
    } else {
        None
    };
    let cpu_field = cpu_values.as_ref().map_or_else(
        || "-".into(),
        |ns| ns.iter().map(u64::to_string).collect::<Vec<_>>().join(","),
    );
    let counts = super::counts_field(&samples.iter().map(|b| b.counts).collect::<Vec<_>>());
    let row = format!(
        "{variant}\t{scenario}\tLeaves\t{count} messages\tmsg\t{}\t{}\t{cpu_field}\t-\t{counts}\n",
        field(&|b| format!("{}/{}", b.wall_ns, units(b))),
        field(&|b| (b.started_ns / 1_000_000).to_string()),
    );
    let measured: Vec<_> = samples
        .iter()
        .map(|b| super::Measured::new(b.wall_ns, units(b)))
        .collect();
    let wall = super::Mean::of(&measured).format_ns(1);
    // CPU time, as in compare: all raw CPU time over all raw work.
    let cpu = cpu_values.map_or_else(
        || "-".into(),
        |ns| {
            super::format_ns(
                ns.iter().map(|&n| u128::from(n)).sum(),
                samples.iter().map(|b| u128::from(units(b))).sum(),
            )
        },
    );
    let report =
        format!("{scenario:6} {count:>8} {variant:13} {wall:>8} ns {cpu:>8} CPU ns  per message\n");
    (row, report)
}

pub fn command(arguments: &[String]) {
    let usage = "bench-hashes leaves [--rounds N] [--variants V,...] [--counts N,...] [--scenarios solo,shared]";
    let mut rounds = 12usize;
    let (mut variants, mut counts, mut scenarios) =
        (VARIANTS.to_vec(), COUNTS.to_vec(), SCENARIOS.to_vec());
    let mut it = arguments.iter();
    let list = |v: Option<&String>| -> Vec<String> {
        v.expect(usage).split(',').map(str::to_owned).collect()
    };
    while let Some(a) = it.next() {
        match a.as_str() {
            "--rounds" => {
                rounds = it
                    .next()
                    .expect(usage)
                    .parse()
                    .expect("--rounds takes a whole number")
            }
            "--variants" => {
                variants = list(it.next())
                    .iter()
                    .map(|v| {
                        *VARIANTS
                            .iter()
                            .find(|&&k| k == v)
                            .unwrap_or_else(|| panic!("no variant {v}: {VARIANTS:?}"))
                    })
                    .collect()
            }
            "--counts" => {
                counts = list(it.next())
                    .iter()
                    .map(|c| c.parse().expect("a count"))
                    .collect()
            }
            "--scenarios" => {
                scenarios = list(it.next())
                    .iter()
                    .map(|v| {
                        *SCENARIOS
                            .iter()
                            .find(|&&k| k == v)
                            .unwrap_or_else(|| panic!("no scenario {v}"))
                    })
                    .collect()
            }
            other => panic!("{usage}: unknown argument {other}"),
        }
    }
    assert!(rounds >= 2, "two rounds at least");
    assert!(
        counts.iter().all(|&n| n > 0),
        "a leaf count must be positive"
    );
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
    let mut programs: Vec<Program> = (0..2)
        .map(|_| Program::new(*counts.iter().max().unwrap()))
        .collect();
    // Each cell's rounds; first one untimed round of every cell (one-time
    // costs: the pool, the stream's storage, the buffers' pages).
    let mut results: Vec<Vec<clocks::Batch>> = cells.iter().map(|_| Vec::new()).collect();
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

    let mut tsv = super::samples_header(&machine, &[
        ("source blake3-servil-mt".to_owned(), super::BLAKE3_SERVIL_SOURCE_INFO.to_owned()),
        ("rounds".to_owned(), rounds.to_string()),
        ("leaves".to_owned(), format!("{MESSAGE_LEN}-byte messages from a counter; wall from producing the first to reading the last digest")),
    ]);
    tsv += SAMPLES_COLUMNS;
    tsv += "\n";
    let mut report = String::new();
    for (c, &(scenario, count, variant)) in cells.iter().enumerate() {
        let (row, text) = cell_lines(scenario, count, variant, &results[c]);
        tsv += &row;
        report += &text;
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

    fn fixed_batches() -> Vec<clocks::Batch> {
        let counts = clocks::Counts {
            p: clocks::Level {
                time_ns: 10,
                cycles: 20,
                instructions: 0,
            },
            e: clocks::Level {
                time_ns: 30,
                cycles: 40,
                instructions: 0,
            },
        };
        let mut batches = vec![
            clocks::Batch {
                calls: 2,
                wall_ns: 4000,
                cpu_ns: Some(6000),
                counts: Some(counts),
                started_ns: 3_000_000,
            };
            6
        ];
        batches[5].wall_ns = 4_000_000;
        batches
    }

    #[test]
    fn recorded_batches_keep_jobs_cpu_counts_and_shared_mean() {
        let (row, report) = cell_lines("solo", 2, "write-ring", &fixed_batches());
        let fields: Vec<_> = row.trim().split('\t').collect();
        assert_eq!(fields.len(), 10);
        assert_eq!(fields[5], "4000/4,4000/4,4000/4,4000/4,4000/4,4000000/4");
        assert_eq!(fields[6], "3,3,3,3,3,3");
        assert_eq!(fields[7], "6000,6000,6000,6000,6000,6000");
        assert_eq!(fields[8], "-");
        assert_eq!(fields[9], ["10:20:30:40"; 6].join(","));
        // All six samples count ((5 * 4000 + 4_000_000) ns / 24 messages = 167500ns/message).
        // All raw CPU time gives 36000ns/24 messages = 1500ns/message.
        assert!(report.contains("167500.000 ns 1500.000 CPU ns"), "{report}");
    }

    #[test]
    fn shared_and_unavailable_cpu_figures_stay_absent() {
        let mut batches = fixed_batches();
        let (row, report) = cell_lines("shared", 2, "write-ring", &batches);
        assert_eq!(row.trim().split('\t').nth(7), Some("-"));
        assert!(report.contains("CPU ns"));
        assert!(!report.contains("1500.000"));
        batches[0].cpu_ns = None;
        batches[0].counts = None;
        let (row, report) = cell_lines("solo", 2, "write-ring", &batches);
        let fields: Vec<_> = row.trim().split('\t').collect();
        assert_eq!((fields[7], fields[9]), ("-", "-"));
        assert!(!report.contains("1500.000"));
    }

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
                assert_eq!(
                    program.job(variant, count),
                    want,
                    "{variant}, {count} leaves"
                );
            }
        }
    }
}
