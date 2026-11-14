//! Synthetic assumption check, EXPERIMENT ONLY. No machine is timed.
//! Independent layout pairs contain a fast and a slow copy of identical code;
//! their side assignment is a fair coin. Repeats share that pair's layout.
//! This stress test establishes no empirical false-call rate for real runs.
use clocks::summary::{discoveries, mean, Verdict};

fn choose(n: usize, k: usize) -> u128 {
    (1..=k.min(n - k)).fold(1, |c, i| c * (n + 1 - i) as u128 / i as u128)
}

fn pairs(layouts: usize, positive: usize, repeats: usize, fast: u64, slow: u64) -> Vec<(u128, u128)> {
    let (f, s) = (mean([(fast, 1)]), mean([(slow, 1)]));
    (0..repeats).flat_map(|_| (0..layouts).map(move |i| if i < positive { (f, s) } else { (s, f) })).collect()
}

fn judge(pairs: Vec<(u128, u128)>, family: usize) -> Verdict {
    let neutral = mean([(1000, 1)]);
    let mut cells = vec![vec![(neutral, neutral); pairs.len()]; family];
    cells[0] = pairs;
    discoveries(&cells, 50, 30)[0].verdict
}

fn main() {
    // Independent anchors: paired t is 1 with 16 observations (10 positive,
    // 6 negative equal log magnitudes). Copying each observation four times
    // makes it sqrt(63/15), about 2.049; the df63 two-sided 5% cutoff is 1.998.
    // The geometric-mean effect exceeds 3% for the 5/4 ratio.
    assert_eq!(judge(pairs(16, 10, 1, 4, 5), 1), Verdict::Level);
    assert_eq!(judge(pairs(16, 10, 4, 4, 5), 1), Verdict::Slower);
    let q = |n| mean([(n, 1)]);
    assert_eq!(judge(vec![(q(1000), q(1000)); 64], 8), Verdict::Level);
    assert_eq!(judge(vec![(q(1000), q(1060)); 64], 8), Verdict::Slower);
    println!("# Synthetic layout-repeat assumption check; no timing, no empirical calibration claim");
    println!("# One noisy null cell; any other family members are exactly level");
    println!("fast\tslow\tlayout_pairs\trepeats\tfamily\tslower_assignments\tfaster_assignments\ttotal_assignments\tfalse_call_ppm");
    for (fast, slow) in [(10, 11), (4, 5)] {
        for family in [1, 8] {
            for (layouts, repeats) in [(16, 1), (16, 4), (64, 1)] {
                let (mut slower, mut faster) = (0u128, 0u128);
                for positive in 0..=layouts {
                    let weight = choose(layouts, positive);
                    match judge(pairs(layouts, positive, repeats, fast, slow), family) {
                        Verdict::Slower => slower += weight,
                        Verdict::Faster => faster += weight,
                        Verdict::Level => {}
                    }
                }
                let total = 1u128 << layouts;
                let ppm = ((slower + faster) * 1_000_000 + total / 2) / total;
                println!("{fast}\t{slow}\t{layouts}\t{repeats}\t{family}\t{slower}\t{faster}\t{total}\t{ppm}");
            }
        }
    }
}
