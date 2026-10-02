//! Positive work-accounting control: 100 logical requests plus known extra hashes.
//! Accounting contract v3: matched fixed logical work per sample; one warm-up batch.
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
    assert_eq!(args.len(), 3, "work_control SUBJECT_EXTRA_PER100 BATCHES CONTROL_EXTRA_PER100 (extras 0..100; positive batches)");
    let subject_extra: u64 = args[0].parse().unwrap();
    let batch_count: usize = args[1].parse().unwrap();
    let control_extra: u64 = args[2].parse().unwrap();
    assert!(subject_extra <= 100 && control_extra <= 100 && batch_count > 0);
    const REQUESTS_PER_BLOCK: u64 = 100;
    let mut rows = String::new();
    let mut trace = String::from("contender,length,sample,blocks,calls,hashes_per_block,completed_hashes,wall_ns,p_cycles,p_instructions,p_time_ns,e_cycles,e_instructions,e_time_ns\n");
    let mut accounting = String::from("contender,length,hashes_per_block,blocks_per_batch,calls_per_batch,measured_batches,completed_including_calibration\n");
    for algorithm in ["sha256", "blake3-servil-st"] {
        let extra = if algorithm == "sha256" { control_extra } else { subject_extra };
        let hashes_per_block = REQUESTS_PER_BLOCK + extra;
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
            let fixed_blocks = match length { 64 => 500, 2048 => 30, 102400 => 2, _ => unreachable!() };
            let mut completed = 0u64;
            let mut block = || {
                for _ in 0..hashes_per_block {
                    black_box(hash(algorithm, &input));
                    completed += 1;
                }
            };
            // One explicit untimed warm-up batch, identical in logical work
            // to a measured batch; completion accounting includes it.
            for _ in 0..fixed_blocks { block(); }
            let batches = clocks::measure_calls(batch_count, fixed_blocks, block);
            let blocks = batches[0].calls;
            let calls = blocks * REQUESTS_PER_BLOCK;
            assert!(batches.iter().all(|b| b.calls == blocks));
            assert_eq!(completed, (batches.len() as u64 + 1) * blocks * hashes_per_block, "all completed hashes, including the explicit warm-up");
            writeln!(accounting, "{algorithm},{length},{hashes_per_block},{blocks},{calls},{},{completed}", batches.len()).unwrap();
            let values = batches.iter().map(|b| format!("{}/{}", b.wall_ns, b.calls * REQUESTS_PER_BLOCK)).collect::<Vec<_>>().join(",");
            let starts = batches.iter().map(|b| (b.started_ns / 1_000_000).to_string()).collect::<Vec<_>>().join(",");
            writeln!(rows, "{algorithm}\tsolo\tPositiveWorkControl\t{length} B\tcall\t{values}\t{starts}").unwrap();
            for (i, b) in batches.iter().enumerate() {
                let counts = match b.counts {
                    Some(c) => format!("{},{},{},{},{},{}", c.p.cycles, c.p.instructions, c.p.time_ns, c.e.cycles, c.e.instructions, c.e.time_ns),
                    None => ",,,,,".to_owned(),
                };
                writeln!(trace, "{algorithm},{length},{i},{},{},{hashes_per_block},{},{},{counts}", b.calls, b.calls * REQUESTS_PER_BLOCK, b.calls * hashes_per_block, b.wall_ns).unwrap();
            }
        }
    }
    let windows = clocks::load::windows();
    let listed = windows.iter().map(|w| format!("{}-{}:{}:{}", w.start_ns / 1_000_000, w.end_ns / 1_000_000, w.other_milli_cpus, w.steal_milli_cpus)).collect::<Vec<_>>().join(",");
    println!("# bench-hashes samples v4\n# power: not measured by this diagnostic caller\n# load: {}\n# load windows (start ms-end ms:other milli-CPUs:steal milli-CPUs): {listed}\n# rounds: {batch_count}\n# contenders: --contenders sha256,blake3-servil-st\n# work control version: 3\n# fixed blocks per sample: 64=500,2048=30,102400=2\n# logical requests per block: {REQUESTS_PER_BLOCK}\n# subject extra per100: {subject_extra}\n# control extra per100: {control_extra}\n# thread cycles: unavailable on Linux; empty trace fields\ncontender\tscenario\tuse_case\tpoint\tunit\tns/units\tstart ms\n{rows}", clocks::load::describe(&windows));
    std::fs::write("clocks.csv", trace).unwrap();
    std::fs::write("accounting.csv", accounting).unwrap();
}
