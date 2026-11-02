/*
 * `bench-hashes crowd`: N programs at once, one a CPU unless told
 * otherwise, each a process of its own with its own pool (a servil mt
 * process sizes its pool to the CPUs it may use, so one program a CPU is
 * the classic oversubscription of thread pools: 20 programs on a 20-CPU
 * machine run 400 threads), each hashing one of the main run's cells the
 * main run's way (take_sample), released together and running for the
 * same time. Each program's time per unit over its run is a sample, as
 * the shared scenario's copies' are; the report adds what the machine
 * did in all (the programs' rates summed) and how unevenly it served
 * them (the luckiest program's rate over the unluckiest's), which is the
 * operating system's scheduling of equal programs. bench-hashes #116:
 * whether the pools degrade gracefully or collapse under N programs is
 * the question; the main grid's two copies cannot ask it.
 *
 * The programs are this executable, run as `crowd --program CONTENDER
 * POINT SECONDS`: each calibrates its sample, makes its own input, says
 * `ready`, waits for a byte on stdin (the release), hashes until its
 * SECONDS are up, and prints `SAMPLES ELAPSED_NS UNITS`. The samples file
 * is the main run's format (`crowd.samples.tsv`), so `bench-hashes
 * compare` reads it; the scenario column is `crowd-N`.
 */

use super::{
    block_copy, calibrate_batch, input_len, machine_metadata, make_input_seeded, output_directory,
    take_sample, Algorithm, Point, UseCase, POINTS, SAMPLES_COLUMNS,
};
use std::fs;
use std::io::{BufRead, BufReader, Read, Write};

/// The default cells: the two multithreaded contenders at the stream
/// points the many-programs probe measured (bench-hashes #116).
const CONTENDERS: [Algorithm; 2] = [Algorithm::Blake3ServilMt, Algorithm::Blake3Rayon];
const POINT_LABELS: [&str; 2] = ["1 KiB", "64 KiB"];
/// How long each program hashes after the release, a round.
const SECONDS: u64 = 2;

/// One program's result for a round: its samples taken, their time, and
/// the units each sample hashed.
#[derive(Clone, Copy)]
struct Program {
    samples: u64,
    elapsed_ns: u64,
    units_per_sample: u64,
}

impl Program {
    /// Units per second, rounded once.
    fn rate(self) -> u128 {
        let units = u128::from(self.samples * self.units_per_sample);
        let ns = u128::from(self.elapsed_ns);
        (units * 1_000_000_000 + ns / 2) / ns
    }
}

/// The rows and report for a cell's rounds (each round: every program's
/// result): the samples row in the main run's format (each program's
/// time over its units, a sample), and the report's line with the mean
/// time per unit, the machine's total, and the luckiest-to-unluckiest
/// ratio (each the mean over rounds, in integers, rounded once).
fn cell_lines(
    algorithm: Algorithm,
    point: Point,
    programs: usize,
    rounds: &[Vec<Program>],
    started_ms: &[u64],
) -> (String, String) {
    let all: Vec<Program> = rounds.iter().flatten().copied().collect();
    let row = format!(
        "{}\tcrowd-{programs}\t{:?}\t{}\t{}\t{}\t{}\t-\t-\t-\t-\n",
        algorithm.key(),
        point.use_case,
        point.label,
        point.use_case.unit_key(),
        all.iter()
            .map(|p| format!("{}/{}", p.elapsed_ns, p.samples * p.units_per_sample))
            .collect::<Vec<_>>()
            .join(","),
        started_ms
            .iter()
            .flat_map(|&ms| std::iter::repeat_n(ms.to_string(), programs))
            .collect::<Vec<_>>()
            .join(","),
    );
    let measured: Vec<super::Measured> = all
        .iter()
        .map(|p| super::Measured::new(p.elapsed_ns, p.samples * p.units_per_sample))
        .collect();
    let mean_ns = super::Mean::of(&measured).format_ns(1);
    // Each round's total (the programs' rates summed) and spread (the
    // luckiest program's rate over the unluckiest's, in permille); each
    // the mean over rounds.
    let n = rounds.len() as u128;
    let mean = |sum: u128| (sum + n / 2) / n;
    let total = mean(
        rounds
            .iter()
            .map(|round| round.iter().map(|p| p.rate()).sum::<u128>())
            .sum(),
    );
    let spread = mean(
        rounds
            .iter()
            .map(|round| {
                let (max, min) = (
                    round.iter().map(|p| p.rate()).max().expect("a program"),
                    round.iter().map(|p| p.rate()).min().expect("a program"),
                );
                (max * 1000 + min / 2) / min
            })
            .sum(),
    );
    let hundredths = |value: u128, per_unit: u128| {
        let h = (value * 100 + per_unit / 2) / per_unit;
        format!("{}.{:02}", h / 100, h % 100)
    };
    let unit = point.use_case.unit_key();
    let total = if unit == "B" {
        format!("{} GB/s", hundredths(total, 1_000_000_000))
    } else {
        format!("{} M msg/s", hundredths(total, 1_000_000))
    };
    let report = format!(
        "{:20} {:>7} {:?}: {mean_ns:>9} ns per {unit} a program; the machine {total}; luckiest/unluckiest x{}\n",
        algorithm.key(),
        point.label,
        point.use_case,
        hundredths(spread, 1000),
    );
    (row, report)
}

/// One program: `crowd --program CONTENDER POINT SECONDS`.
fn program(arguments: &[String]) {
    let [contender, label, seconds] = arguments else {
        panic!("crowd --program CONTENDER POINT SECONDS");
    };
    let algorithm = *Algorithm::ALL
        .iter()
        .find(|a| a.key() == contender)
        .unwrap_or_else(|| panic!("no contender {contender}"));
    let point = POINTS
        .iter()
        .copied()
        .find(|p| p.use_case == UseCase::ContinuousMessages && p.label == label)
        .unwrap_or_else(|| panic!("no continuous point {label}"));
    let seconds: u64 = seconds.parse().expect("whole seconds");
    blake3_servil::initialize_multithreaded(None);
    // Its own input, as a program's is (the seed from its PID).
    let input = make_input_seeded(input_len(point), u64::from(std::process::id()));
    let (copy, at) = block_copy(&input);
    let input = &copy[at..at + input.len()];
    let (iterations, _) = calibrate_batch(algorithm, input, point);
    take_sample(algorithm, input, point, iterations);
    let units_per_sample = point.use_case.units(point, iterations);
    println!("ready");
    std::io::stdout().flush().unwrap();
    let mut release = [0u8; 1];
    std::io::stdin()
        .read_exact(&mut release)
        .expect("the release");
    let deadline = std::time::Instant::now() + std::time::Duration::from_secs(seconds);
    let (mut samples, mut elapsed_ns) = (0u64, 0u64);
    while std::time::Instant::now() < deadline {
        elapsed_ns += take_sample(algorithm, input, point, iterations).elapsed_ns;
        samples += 1;
    }
    println!("{samples} {elapsed_ns} {units_per_sample}");
}

/// A round of one cell: N programs released together; each one's result.
fn measure_cell(algorithm: Algorithm, point: Point, programs: usize) -> (Vec<Program>, u64) {
    let exe = std::env::current_exe().unwrap();
    let mut children: Vec<std::process::Child> = (0..programs)
        .map(|_| {
            std::process::Command::new(&exe)
                .args([
                    "crowd",
                    "--program",
                    algorithm.key(),
                    point.label,
                    &SECONDS.to_string(),
                ])
                .stdin(std::process::Stdio::piped())
                .stdout(std::process::Stdio::piped())
                .spawn()
                .expect("a program of the crowd")
        })
        .collect();
    let mut outputs: Vec<BufReader<std::process::ChildStdout>> = children
        .iter_mut()
        .map(|c| BufReader::new(c.stdout.take().unwrap()))
        .collect();
    for out in &mut outputs {
        let mut line = String::new();
        out.read_line(&mut line).unwrap();
        assert_eq!(
            line.trim(),
            "ready",
            "a program of the crowd failed before its release"
        );
    }
    let started_ms = clocks::load::now_ns() / 1_000_000;
    for child in &mut children {
        child.stdin.as_mut().unwrap().write_all(b"\n").unwrap();
    }
    let results = outputs
        .iter_mut()
        .map(|out| {
            let mut line = String::new();
            out.read_line(&mut line).unwrap();
            let fields: Vec<u64> = line
                .split_whitespace()
                .map(|f| f.parse().unwrap())
                .collect();
            let [samples, elapsed_ns, units_per_sample] = fields[..] else {
                panic!("a program's result: {line}");
            };
            Program {
                samples,
                elapsed_ns,
                units_per_sample,
            }
        })
        .collect();
    for mut child in children {
        assert!(
            child.wait().unwrap().success(),
            "a program of the crowd failed"
        );
    }
    (results, started_ms)
}

pub fn command(arguments: &[String]) {
    if arguments.first().map(String::as_str) == Some("--program") {
        return program(&arguments[1..]);
    }
    let usage =
        "bench-hashes crowd [--rounds N] [--programs N] [--contenders K,...] [--points L,...]";
    let mut rounds = 3usize;
    let mut programs = std::thread::available_parallelism().map_or(2, |n| n.get());
    let mut contenders = CONTENDERS.to_vec();
    let mut labels: Vec<String> = POINT_LABELS.iter().map(|&l| l.to_owned()).collect();
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
            "--programs" => {
                programs = it
                    .next()
                    .expect(usage)
                    .parse()
                    .expect("--programs takes a whole number")
            }
            "--contenders" => {
                contenders = list(it.next())
                    .iter()
                    .map(|k| {
                        *Algorithm::ALL
                            .iter()
                            .find(|a| a.key() == k)
                            .unwrap_or_else(|| panic!("no contender {k}"))
                    })
                    .collect()
            }
            "--points" => labels = list(it.next()),
            other => panic!("{usage}: unknown argument {other}"),
        }
    }
    assert!(
        rounds >= 1 && programs >= 1,
        "a round and a program at least"
    );
    let points: Vec<Point> = labels
        .iter()
        .map(|label| {
            POINTS
                .iter()
                .copied()
                .find(|p| p.use_case == UseCase::ContinuousMessages && p.label == label.as_str())
                .unwrap_or_else(|| panic!("no continuous point {label}"))
        })
        .collect();
    let mut machine = machine_metadata();
    let cells: Vec<(Algorithm, Point)> = contenders
        .iter()
        .flat_map(|&a| points.iter().map(move |&p| (a, p)))
        .collect();
    let mut results: Vec<Vec<Vec<Program>>> = cells.iter().map(|_| Vec::new()).collect();
    let mut starts: Vec<Vec<u64>> = cells.iter().map(|_| Vec::new()).collect();
    for round in 0..rounds {
        for k in 0..cells.len() {
            let c = (k + round) % cells.len();
            let (programs_result, started_ms) = measure_cell(cells[c].0, cells[c].1, programs);
            results[c].push(programs_result);
            starts[c].push(started_ms);
        }
        eprintln!("bench-hashes crowd: round {} of {rounds} done", round + 1);
    }
    // Other programs' load goes unmeasured here: the detector reads the
    // machine's CPU time beyond this process's, and the crowd's programs
    // are other processes, meant to fill the machine.
    machine.power[1] = super::Power::read();
    let mut tsv = super::samples_header(
        &machine,
        &[
            ("source blake3-servil-mt".to_owned(), super::BLAKE3_SERVIL_SOURCE_INFO.to_owned()),
            ("rounds".to_owned(), rounds.to_string()),
            (
                "crowd".to_owned(),
                format!("{programs} programs at once, each its own process and pool, released together, {SECONDS} s a round"),
            ),
        ],
    );
    tsv += SAMPLES_COLUMNS;
    tsv += "\n";
    let mut report = String::new();
    for (c, &(algorithm, point)) in cells.iter().enumerate() {
        let (row, text) = cell_lines(algorithm, point, programs, &results[c], &starts[c]);
        tsv += &row;
        report += &text;
    }
    let directory = output_directory(&machine);
    fs::create_dir_all(&directory).unwrap();
    let path = directory.join("crowd.samples.tsv");
    fs::write(&path, tsv).unwrap();
    println!(
        "bench-hashes crowd: {programs} programs at once, {}\nload: the programs themselves; other programs' load is not measured here\n\n{report}\n# Samples (TSV) are in {:?} .",
        super::BLAKE3_SERVIL_SOURCE_INFO,
        path
    );
}

#[cfg(test)]
mod tests {
    use super::*;

    /// Two rounds of three programs: the row holds every program's time
    /// over its units in the main run's format, and the report the mean,
    /// the machine's total (the programs' rates summed, the mean round)
    /// and the luckiest-to-unluckiest ratio.
    #[test]
    fn rows_and_report_from_fixed_programs() {
        let p = |samples, elapsed_ns| Program {
            samples,
            elapsed_ns,
            units_per_sample: 1024,
        };
        // Round 1: each program 1.024 GB in 1 s. Round 2: one program twice as lucky.
        let rounds = vec![
            vec![p(1_000_000, 1_000_000_000); 3],
            vec![
                p(2_000_000, 1_000_000_000),
                p(1_000_000, 1_000_000_000),
                p(1_000_000, 1_000_000_000),
            ],
        ];
        let point = POINTS
            .iter()
            .copied()
            .find(|p| p.use_case == UseCase::ContinuousMessages && p.label == "1 KiB")
            .unwrap();
        let (row, report) = cell_lines(
            Algorithm::Blake3ServilMt,
            point,
            3,
            &rounds,
            &[5_000, 9_000],
        );
        let fields: Vec<_> = row.trim().split('\t').collect();
        assert_eq!(fields.len(), 11);
        assert_eq!(
            fields[..5],
            [
                "blake3-servil-mt",
                "crowd-3",
                "ContinuousMessages",
                "1 KiB",
                "B"
            ]
        );
        assert_eq!(
            fields[5],
            "1000000000/1024000000,1000000000/1024000000,1000000000/1024000000,1000000000/2048000000,1000000000/1024000000,1000000000/1024000000"
        );
        assert_eq!(fields[6], "5000,5000,5000,9000,9000,9000");
        // Round totals 3.072 and 4.096 GB/s, spreads x1 and x2: their means.
        assert!(
            report.contains("the machine 3.58 GB/s; luckiest/unluckiest x1.50"),
            "{report}"
        );
        assert!(report.contains("ns per B a program"), "{report}");
    }
}
