//! Fixed synthetic paired-copy control, calling the shared bootstrap only.
//! No timing, speed splitter, bootstrap or samples parser is reimplemented.
use clocks::speeds::bootstrap_median_interval;

fn next(state: &mut u64) -> u64 {
    *state = state.wrapping_add(0x9e3779b97f4a7c15);
    let mut x = *state;
    x = (x ^ (x >> 30)).wrapping_mul(0xbf58476d1ce4e5b9);
    x = (x ^ (x >> 27)).wrapping_mul(0x94d049bb133111eb);
    x ^ (x >> 31)
}

fn main() {
    // Uniform integer test values1..99 have median50. SplitMix64 inputs,
    // seed0xD3A0_C1A0_2026_1001; multiply-shift range selection.
    let seed = 0xd3a0c1a020261001u64;
    let mut state = seed;
    let trials = 4000usize;
    for visits in [6usize, 12, 24, 48] {
        let (mut grouped_hits, mut flattened_hits) = (0usize, 0usize);
        let (mut grouped_width, mut flattened_width) = (0u128, 0u128);
        for _ in 0..trials {
            let mut groups: Vec<u128> = (0..visits).map(|_| (((u128::from(next(&mut state)) * 99) >> 64) + 1) << 64).collect();
            groups.sort_unstable();
            // Both copies share exactly the same value on each visit.
            let flat: Vec<_> = groups.iter().flat_map(|&x| [x, x]).collect();
            let g = bootstrap_median_interval(&groups);
            let f = bootstrap_median_interval(&flat);
            let truth = 50u128 << 64;
            grouped_hits += usize::from(g.0 <= truth && truth <= g.1);
            flattened_hits += usize::from(f.0 <= truth && truth <= f.1);
            grouped_width += g.1 - g.0;
            flattened_width += f.1 - f.0;
        }
        println!("visits={visits} trials={trials} seed={seed:x} grouped_hits={grouped_hits} flattened_hits={flattened_hits} grouped_width_q64_sum={grouped_width} flattened_width_q64_sum={flattened_width}");
    }
}
