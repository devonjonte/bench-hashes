//! Positive work-accounting control: one or two observed hashes per request.
//! Timing belongs to clocks; analysis belongs to shared readers/speed rules.
use sha2::{Digest, Sha256};
use std::{fmt::Write as _, hint::black_box};

fn hash(algorithm: &str, input: &[u8]) -> [u8; 32] {
    match algorithm {
        "sha256" => Sha256::digest(black_box(input)).into(),
        "blake3-servil-st" => *blake3_servil::hash(black_box(input)).as_bytes(),
        _ => panic!("the control covers sha256 and blake3-servil-st"),
    }
}

fn main() {
    let args: Vec<_> = std::env::args().skip(1).collect();
    assert_eq!(args.len(), 2, "work_control FACTOR BATCHES (factor 1 or 2; positive batches)");
    let factor: u64 = args[0].parse().unwrap();
    let batch_count: usize = args[1].parse().unwrap();
    assert!([1, 2].contains(&factor) && batch_count > 0);
    let mut rows = String::new();
    let mut trace = String::from("contender,length,sample,calls,factor,completed_hashes,wall_ns,p_cycles,p_instructions,p_time_ns,e_cycles,e_instructions,e_time_ns\n");
    let mut accounting = String::from("contender,length,factor,calls_per_batch,measured_batches,completed_including_calibration\n");
    for algorithm in ["sha256", "blake3-servil-st"] {
        for length in [64, 2048, 102400] {
            let input: Vec<u8> = (0..length).map(|i| (i % 251) as u8).collect();
            let family = if algorithm == "sha256" { "sha256" } else { "blake3" };
            let expected = include_str!("../tools/fixtures/harness-digests.tsv").lines()
                .filter(|l| !l.starts_with('#')).find(|l| {
                    let mut f = l.split('\t');
                    f.next().unwrap().parse::<usize>().unwrap() == length && f.next().unwrap() == family
                }).unwrap().split('\t').nth(2).unwrap();
            let actual: String = hash(algorithm, &input).iter().map(|b| format!("{b:02x}")).collect();
            assert_eq!(actual, expected, "fixed independent preflight anchor");
            let mut completed = 0u64;
            let batches = clocks::measure(batch_count, 2_000_000, || {
                for _ in 0..factor {
                    black_box(hash(algorithm, &input));
                    completed += 1;
                }
            });
            let calls = batches[0].calls;
            assert!(batches.iter().all(|b| b.calls == calls));
            assert_eq!(completed, (batches.len() as u64 + 1) * calls * factor, "all completed hashes, including calibration");
            writeln!(accounting, "{algorithm},{length},{factor},{calls},{},{completed}", batches.len()).unwrap();
            let values = batches.iter().map(|b| format!("{}/{}", b.wall_ns, b.calls)).collect::<Vec<_>>().join(",");
            let starts = batches.iter().map(|b| (b.started_ns / 1_000_000).to_string()).collect::<Vec<_>>().join(",");
            writeln!(rows, "{algorithm}\tsolo\tPositiveWorkControl\t{length} B\tcall\t{values}\t{starts}").unwrap();
            for (i, b) in batches.iter().enumerate() {
                let counts = match b.counts {
                    Some(c) => format!("{},{},{},{},{},{}", c.p.cycles, c.p.instructions, c.p.time_ns, c.e.cycles, c.e.instructions, c.e.time_ns),
                    None => ",,,,,".to_owned(),
                };
                writeln!(trace, "{algorithm},{length},{i},{},{factor},{},{},{counts}", b.calls, b.calls * factor, b.wall_ns).unwrap();
            }
        }
    }
    let windows = clocks::load::windows();
    let listed = windows.iter().map(|w| format!("{}-{}:{}:{}", w.start_ns / 1_000_000, w.end_ns / 1_000_000, w.other_milli_cpus, w.steal_milli_cpus)).collect::<Vec<_>>().join(",");
    println!("# bench-hashes samples v4\n# power: not measured by this diagnostic caller\n# load: {}\n# load windows (start ms-end ms:other milli-CPUs:steal milli-CPUs): {listed}\n# rounds: {batch_count}\n# contenders: --contenders sha256,blake3-servil-st\n# factor: {factor}\n# thread cycles: unavailable on Linux; empty trace fields\ncontender\tscenario\tuse_case\tpoint\tunit\tns/units\tstart ms\n{rows}", clocks::load::describe(&windows));
    std::fs::write("clocks.csv", trace).unwrap();
    std::fs::write("accounting.csv", accounting).unwrap();
}
