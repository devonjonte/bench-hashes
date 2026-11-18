//! Reader for this probe's own raw format. Uses the shared mean and
//! discoveries rule, all four cases together. The primary cost includes
//! preparation + callback, as the benchmark's after-gap cells do.
use std::collections::BTreeMap;

const CASES: [&str; 4] = ["empty", "hash", "hash8", "arithmetic"];
type Sample = [u64; 7]; // calls, wall, P time, cycles, instructions, references, misses

struct Run {
    mean: [[u128; 7]; 4],
}

fn read(text: &str) -> Run {
    assert!(text.starts_with("# core 27eacce3a5c2e03043f4fcd347c178a80f9d911c; clocks cade30fdb71682719f5fa3e586ff96146ae9fc25; 3 calls/sample; 128 B input\n"));
    let mut rows: BTreeMap<(usize, usize), [Option<Sample>; 2]> = BTreeMap::new();
    let mut declared = BTreeMap::new();
    let mut quiet = false;
    for line in text.lines() {
        if let Some(mean) = line.strip_prefix("# mean ") {
            let (name, rest) = mean.split_once(": ").unwrap();
            let (totals, fixed) = rest.split_once(" ns/call; Q64 ").unwrap();
            let (ns, calls) = totals.split_once('/').unwrap();
            let mean = clocks::summary::mean([(ns.parse().unwrap(), calls.parse().unwrap())]);
            assert_eq!(
                mean,
                fixed.parse::<u128>().unwrap(),
                "the producer's shared mean"
            );
            assert!(declared.insert(name, mean).is_none());
        } else if let Some(load) = line.strip_prefix("# load: ") {
            assert!(
                load.starts_with("quiet:"),
                "comparison requires observed quiet load: {load}"
            );
            quiet = true;
        } else if line.starts_with('#') || line.starts_with("round\t") || line.is_empty() {
            continue;
        } else {
            let fields: Vec<_> = line.split('\t').collect();
            assert_eq!(fields.len(), 11, "this probe's eleven-field record");
            let round: usize = fields[0].parse().unwrap();
            let case = CASES
                .iter()
                .position(|&n| n == fields[1])
                .expect("one of the four cases");
            let part = match fields[2] {
                "preparation" => 0,
                "call" => 1,
                _ => panic!("the two measured parts"),
            };
            let sample = std::array::from_fn(|i| fields[3 + i].parse::<u64>().unwrap());
            assert!(sample[0] > 0);
            assert!(
                rows.entry((round, case)).or_default()[part]
                    .replace(sample)
                    .is_none(),
                "each part once"
            );
        }
    }
    assert!(quiet, "an observed load line");
    assert_eq!(declared.len(), CASES.len());
    let mut samples: [Vec<[Sample; 2]>; 4] = std::array::from_fn(|_| Vec::new());
    for ((_, case), row) in rows {
        let row = row.map(|s| s.expect("both preparation and callback"));
        assert_eq!(row[0][0], row[1][0], "same calls in both parts");
        samples[case].push(row);
    }
    assert!(samples
        .iter()
        .all(|s| !s.is_empty() && s.len() == samples[0].len()));
    let mean = std::array::from_fn(|case| {
        let s = &samples[case];
        let call = clocks::summary::mean(s.iter().map(|r| (r[1][1], r[1][0])));
        assert_eq!(
            call, declared[CASES[case]],
            "raw callbacks reproduce the producer's mean"
        );
        let mean =
            |field| clocks::summary::mean(s.iter().map(|r| (r[0][field] + r[1][field], r[0][0])));
        [mean(1), mean(2), mean(3), mean(4), mean(5), mean(6), call]
    });
    Run { mean }
}

fn main() {
    let args: Vec<_> = std::env::args().skip(1).collect();
    let split = args
        .iter()
        .position(|a| a == "--")
        .expect("compare OLD... -- NEW...");
    let (old, new) = (&args[..split], &args[split + 1..]);
    assert!(
        old.len() >= 3 && old.len() == new.len(),
        "at least three paired runs"
    );
    let load = |p: &String| read(&std::fs::read_to_string(p).unwrap());
    let old: Vec<_> = old.iter().map(load).collect();
    let new: Vec<_> = new.iter().map(load).collect();
    let pairs = |case: usize, field: usize| {
        old.iter()
            .zip(&new)
            .map(|(a, b)| (a.mean[case][field], b.mean[case][field]))
            .collect::<Vec<_>>()
    };
    let cells: Vec<_> = (0..4).map(|case| pairs(case, 0)).collect();
    let judgments = clocks::summary::discoveries(&cells, 50, 30);
    let display = |n: u64| format!("{}.{:03}", n / 1000, n % 1000);
    let absolute = |case: usize, field: usize, new_side: bool| {
        let p: Vec<_> = pairs(case, field)
            .iter()
            .map(|&(a, b)| (1u128 << 64, if new_side { b } else { a }))
            .collect();
        display(clocks::summary::geometric_mean_permille(&p))
    };
    println!("# Fixed-build diagnostic: copy + callback wall time, four cases judged together by clocks::summary. No cross-layout or release claim.");
    println!("case\told_ns\tnew_ns\tratio_permille\tverdict\told_cycles\tnew_cycles\told_instructions\tnew_instructions\tcallback_ratio_permille");
    for case in 0..4 {
        let j = judgments[case];
        println!(
            "{}\t{}\t{}\t{}\t{:?}\t{}\t{}\t{}\t{}\t{}",
            CASES[case],
            absolute(case, 0, false),
            absolute(case, 0, true),
            j.ratio_permille,
            j.verdict,
            absolute(case, 2, false),
            absolute(case, 2, true),
            absolute(case, 3, false),
            absolute(case, 3, true),
            clocks::summary::geometric_mean_permille(&pairs(case, 6))
        );
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    fn fixture() -> String {
        let mut s = "# core 27eacce3a5c2e03043f4fcd347c178a80f9d911c; clocks cade30fdb71682719f5fa3e586ff96146ae9fc25; 3 calls/sample; 128 B input\n".to_owned();
        for name in CASES {
            s += &format!("0\t{name}\tpreparation\t3\t3\t3\t30\t60\t0\t0\t1\n0\t{name}\tcall\t3\t6\t6\t60\t90\t0\t0\t1\n# mean {name}: 6/3 ns/call; Q64 36893488147419103232\n");
        }
        s + "# load: quiet: fixed fixture\n"
    }
    #[test]
    fn raw_parts_reproduce_independent_totals() {
        let r = read(&fixture());
        assert_eq!(
            r.mean,
            [[
                3u128 << 64,
                3u128 << 64,
                30u128 << 64,
                50u128 << 64,
                0,
                0,
                2u128 << 64
            ]; 4]
        );
    }
    #[test]
    #[should_panic(expected = "observed quiet")]
    fn busy_load_stops_the_comparison() {
        read(&fixture().replace("quiet: fixed fixture", "busy: fixture"));
    }
    #[test]
    #[should_panic(expected = "producer's shared mean")]
    fn altered_reported_means_stop_the_reader() {
        read(&fixture().replace("36893488147419103232", "1"));
    }
    #[test]
    #[should_panic(expected = "same calls")]
    fn different_work_in_the_parts_stops_the_reader() {
        read(&fixture().replacen("preparation\t3\t3", "preparation\t2\t3", 1));
    }
}
