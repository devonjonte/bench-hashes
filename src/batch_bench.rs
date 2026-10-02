//! Supplementary equal-length batches, through the benchmark's own adapters.
//! Each point names both message length and count; the original axes stay fixed.
use super::*;

const LENGTHS: &[usize] = &[64, 128, 256, 512, 1024, 2048, 4096];
const COUNTS: &[usize] = &[3, 6, 8, 16, 64, 129];
const HELP: &str = "bench-hashes batches [--lengths 64,128,256,512,1024,2048,4096] [--counts 3,6,8,16,64,129] [--rounds 24] [--contenders sha256,blake3-servil-st,blake3-servil-mt]\nWrites benchmark-results/batches/{bench-hashes.samples.tsv,clocks.csv,bench-hashes.txt}. Measures lent synchronous and owned queue batches, solo and two copies. Original 64-byte axes remain available through the normal command.";

struct Row {
    algorithm: Algorithm,
    point: Point,
    scenario: Scenario,
    label: String,
    samples: Vec<Measured>,
    starts: Vec<u64>,
}

fn list(value: &str) -> Vec<usize> {
    let values: Vec<_> = value.split(',').map(|v| v.parse().expect("positive whole numbers")).collect();
    assert!(!values.is_empty() && values.iter().all(|&n| n > 0));
    for (i, n) in values.iter().enumerate() { assert!(!values[..i].contains(n), "each value appears once"); }
    values
}

fn write_rows(rows: &[Row], header: &str) -> String {
    let mut text = format!("{SAMPLES_VERSION}\n{header}{SAMPLES_COLUMNS}\n");
    for row in rows {
        assert_eq!(row.samples.len(), row.starts.len());
        let samples = row.samples.iter().map(|m| format!("{}/{}", m.ns, m.units)).collect::<Vec<_>>().join(",");
        let starts = row.starts.iter().map(|n| (n / 1_000_000).to_string()).collect::<Vec<_>>().join(",");
        writeln!(text, "{}\t{}\t{:?}\t{}\tmsg\t{samples}\t{starts}", row.algorithm.key(), row.scenario.key(), row.point.use_case, row.label).unwrap();
    }
    text
}

pub(super) fn command(arguments: &[String]) {
    if arguments == ["--help"] { println!("{HELP}"); return; }
    let (mut lengths, mut counts, mut rounds) = (LENGTHS.to_vec(), COUNTS.to_vec(), 24);
    let mut algorithms = vec![Algorithm::Sha256, Algorithm::Blake3ServilSt, Algorithm::Blake3ServilMt];
    assert_eq!(arguments.len() % 2, 0, "{HELP}");
    let mut flags = Vec::new();
    for pair in arguments.chunks_exact(2) {
        assert!(!flags.contains(&pair[0]), "each option appears once"); flags.push(pair[0].clone());
        match pair[0].as_str() {
            "--lengths" => lengths = list(&pair[1]),
            "--counts" => counts = list(&pair[1]),
            "--rounds" => rounds = pair[1].parse().expect("rounds is a positive whole number"),
            "--contenders" => algorithms = parse_selection(&[pair[0].clone(), pair[1].clone()]).1,
            _ => panic!("{HELP}"),
        }
    }
    assert!(lengths.iter().all(|n| LENGTHS.contains(n)), "supported whole-block lengths: {LENGTHS:?}");
    assert!(counts.iter().all(|&n| n <= 262_144), "at most 262144 messages per batch");
    assert!((2..=Algorithm::ALL.len()).contains(&algorithms.len()));
    for (i, algorithm) in algorithms.iter().enumerate() {
        assert!(!algorithms[..i].contains(algorithm));
        assert!(algorithm.availability().is_ok());
        assert!(algorithm.takes_part(UseCase::LentBatches), "each contender supports batches");
    }
    assert!(rounds > 0);
    let mut rows = Vec::new();
    let mut trace = String::from("contender,use_case,point,scenario,round,copy,calls,units,wall_ns,p_cycles,p_instructions,p_ns,e_cycles,e_instructions,e_ns,start_ns\n");
    let mut machine = machine_metadata();
    let duo = Duo::new();
    clocks::load::tick();
    for use_case in [UseCase::LentBatches, UseCase::ContinuousBatches] {
        let orders = participating_orders(&algorithms, use_case);
        assert_eq!(rounds % orders.len(), 0, "rounds completes the contender-order design ({})", orders.len());
        let points: Vec<_> = lengths.iter().flat_map(|&len| counts.iter().map(move |&count| (len, count))).collect();
        let mut cells = Vec::new();
        for &(len, count) in &points {
            let point = Point { label: "", bytes: len.checked_mul(count).unwrap(), messages: count, use_case };
            let input = make_input_seeded(point.bytes, 0);
            let other = make_input_seeded(point.bytes, 1);
            let mut calls = Vec::new();
            for &algorithm in &algorithms {
                if !algorithm.takes_part(use_case) { calls.push(0); continue; }
                let iterations = calibrate_batch(algorithm, &input, point).0;
                // Both copy threads warm their own producers/queues outside sampling.
                duo.run(algorithm, &input, &other, point, iterations);
                calls.push(iterations);
                for scenario in Scenario::ALL {
                    rows.push(Row { algorithm, point, scenario, label: format!("{count} x {len} B"), samples: Vec::new(), starts: Vec::new() });
                }
            }
            cells.push((point, input, other, calls));
        }
        for round in 0..rounds {
            for offset in 0..cells.len() {
                let p = (offset + round) % cells.len();
                let (point, input, other, calls) = &cells[p];
                for &a in &orders[round % orders.len()] {
                    clocks::load::tick();
                    let algorithm = algorithms[a];
                    let iterations = calls[a];
                    let units = point.use_case.units(*point, iterations);
                    let solo = take_sample(algorithm, input, *point, iterations);
                    let shared = duo.run(algorithm, input, other, *point, iterations);
                    let label = format!("{} x {} B", point.messages, point.message_len());
                    for (scenario, copies) in [(Scenario::Solo, vec![solo]), (Scenario::Shared, shared.to_vec())] {
                        let row = rows.iter_mut().find(|r| r.algorithm == algorithm && r.point.use_case == use_case && r.label == label && r.scenario == scenario).unwrap();
                        for (copy, measured) in copies.into_iter().enumerate() {
                            row.samples.push(Measured::new(measured.elapsed_ns, units));
                            row.starts.push(measured.started_ns);
                            writeln!(trace, "{},{use_case:?},{label},{},{round},{copy},{iterations},{units},{},{},{}", algorithm.key(), scenario.key(), measured.elapsed_ns, counts_csv(measured.counts), measured.started_ns).unwrap();
                        }
                    }
                }
            }
            eprintln!("batches: {use_case:?} round {}/{}", round + 1, rounds);
        }
    }
    machine.load = clocks::load::windows();
    machine.power[1] = Power::read();
    let cycles = if clocks::Counts::read().is_some() { "per-thread cycles and instructions in clocks.csv; Linux user-only counts, approximate rate" } else { "unavailable on this platform" };
    let mut header = format!("# timestamp: {}\n# bench-hashes version: {BENCH_VERSION}\n# git commit: {GIT_COMMIT}\n# git clean status: {GIT_CLEAN_STATUS}\n# blake3-servil source: {BLAKE3_SERVIL_SOURCE_INFO}\n# blake3 source: {BLAKE3_SOURCE_INFO}\n# sha256 source: {SHA2_SOURCE_INFO}\n# build target: {BUILD_TARGET}\n# target features: {TARGET_FEATURES}\n# rust compiler: {RUSTC_VERSION}\n# cpu type: {}\n# os type: {}\n# rounds: {rounds}\n# sample clock: {}\n# cycles: {cycles}\n# power: {}\n# load: {}\n", machine.timestamp, machine.cpu_type, machine.os_type, clocks::WALL_CLOCK, machine.describe_power(), clocks::load::describe(&machine.load));
    let windows = machine.load.iter().map(|w| format!("{}-{}:{}:{}", w.start_ns / 1_000_000, w.end_ns / 1_000_000, w.other_milli_cpus, w.steal_milli_cpus)).collect::<Vec<_>>().join(",");
    writeln!(header, "# load windows (start ms-end ms:other milli-CPUs:steal milli-CPUs): {windows}").unwrap();
    writeln!(header, "# official BLAKE3: native batch kernel through 1024 B; plain hash loop for longer messages").unwrap();
    let directory = std::path::Path::new("benchmark-results/batches");
    fs::create_dir_all(directory).unwrap();
    fs::write(directory.join("bench-hashes.samples.tsv"), write_rows(&rows, &header)).unwrap();
    fs::write(directory.join("clocks.csv"), trace).unwrap();
    let mut report = format!("Equal-length batches; mean caller time = total timed ns/completed messages.\n{header}");
    if !load_supplies_speed_evidence(&clocks::load::describe(&machine.load)) {
        report.push_str("Descriptive only: load is busy or unobserved; no speed evidence.\n");
    }
    for row in rows {
        let stats = summarize_measured(&row.samples);
        let total = stats.count;
        let speeds = format!("{} ns/msg ({} measurements)", stats.format_mean(1), total);
        writeln!(report, "{}|{}|{:?}|{}: {speeds}", row.algorithm.key(), row.scenario.key(), row.point.use_case, row.label).unwrap();
    }
    fs::write(directory.join("bench-hashes.txt"), &report).unwrap();
    print!("{report}");
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn lengths_and_queue_shapes_keep_independent_digest_boundaries() {
        // Same total bytes, unlike message lengths: reuse would hash or return
        // the wrong number of digests. Repeat each to exercise kept queues.
        for &(len, count) in &[(64, 16), (128, 8), (256, 4), (512, 2), (1024, 1), (2048, 3), (4096, 3), (64, 16)] {
            let input = make_input(len * count);
            let want: Vec<_> = input.chunks_exact(len).map(|m| *blake3::hash(m).as_bytes()).collect();
            for use_case in [UseCase::ManyMessages, UseCase::LentBatches, UseCase::ContinuousBatches] {
                let point = Point { label: "", bytes: input.len(), messages: count, use_case };
                assert_eq!(point.message_len(), len);
                assert_eq!(use_case.units(point, 2), (2 * count) as u64);
                for algorithm in [Algorithm::Blake3, Algorithm::Blake3ServilSt, Algorithm::Blake3ServilMt] {
                    if !algorithm.takes_part(use_case) { continue; }
                    let mut got = Vec::new();
                    hash_batch(algorithm, &input, point, 2, |digest| got.extend_from_slice(digest));
                    assert_eq!(got, want.repeat(2).as_flattened(), "{algorithm:?}, {use_case:?}, {count} x {len}");
                }
            }
        }
    }

    #[test]
    fn rows_preserve_raw_ns_work_and_distinguish_lengths() {
        let rows: Vec<_> = [64, 256].into_iter().map(|len| Row { algorithm: Algorithm::Blake3ServilSt, point: Point { label: "", bytes: len * 6, messages: 6, use_case: UseCase::LentBatches }, scenario: Scenario::Solo, label: format!("6 x {len} B"), samples: vec![Measured::new(120, 6), Measured::new(180, 12)], starts: vec![1_000_000, 2_000_000] }).collect();
        let text = write_rows(&rows, "# load: quiet: fixture\n# power: fixture\n");
        let path = std::env::temp_dir().join(format!("batch-reader-{}.tsv", std::process::id()));
        fs::write(&path, text).unwrap();
        let read = read_samples(path.to_str().unwrap());
        fs::remove_file(path).unwrap();
        assert_eq!(read.cells.len(), 2);
        assert_ne!(read.cells[0].0, read.cells[1].0);
        for (_, samples) in read.cells { assert_eq!(samples.iter().map(|m| (m.ns, m.units)).collect::<Vec<_>>(), vec![(120, 6), (180, 12)]); }
    }
}
