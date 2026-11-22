//! BLAKE3 PR #484, review finding 9: the group call on separately borrowed
//! short messages (`TreeHasher::try_hash_group_on`), timed per group.
//! Built once against each library commit; prints ns per group for each cell.
use blake3_servil_core::thread_support::Platform;
use blake3_servil_core::throughput::TreeHasher;
use std::hint::black_box;
use std::time::Instant;

#[inline(never)]
pub fn group(tree: &TreeHasher, platform: Platform, messages: &[&[u8]], out: &mut [[u8; 32]]) -> bool {
    tree.try_hash_group_on(platform, messages.len(), |i| messages[i], |i, digest| out[i] = digest)
}

fn main() {
    blake3_servil_core::initialize();
    let platform = Platform::detect();
    let tree = TreeHasher::new(blake3_servil_core::Mode::Plain);
    let rounds: usize = std::env::args().nth(1).map_or(15, |a| a.parse().unwrap());
    let mut backing = vec![0u8; 128 * 1024 + 64];
    let mut x = 0x9E37_79B9_7F4A_7C15u64;
    for b in &mut backing {
        x ^= x << 13;
        x ^= x >> 7;
        x ^= x << 17;
        *b = x as u8;
    }
    let cells = [(2usize, 64usize), (3, 64), (4, 64), (8, 64), (16, 64), (64, 64), (2, 128), (2, 1024), (16, 1024)];
    for (count, len) in cells {
        let messages: Vec<&[u8]> = (0..count).map(|i| &backing[i * 1024..][..len]).collect();
        let mut out = vec![[0u8; 32]; count];
        assert!(group(&tree, platform, &messages, &mut out));
        for (i, m) in messages.iter().enumerate() {
            assert_eq!(out[i], *blake3_servil_core::convenience::hash(m).as_bytes());
        }
        // About 20 ms a round.
        let t0 = Instant::now();
        let mut n = 0u64;
        while t0.elapsed().as_millis() < 20 {
            for _ in 0..1000 {
                black_box(group(&tree, platform, black_box(&messages), &mut out));
            }
            n += 1000;
        }
        let iters = n;
        let mut times = Vec::with_capacity(rounds);
        for _ in 0..rounds {
            let t = Instant::now();
            for _ in 0..iters {
                black_box(group(&tree, platform, black_box(&messages), &mut out));
            }
            times.push(t.elapsed().as_nanos() as f64 / iters as f64);
        }
        times.sort_by(f64::total_cmp);
        println!("{count}x{len}\t{:.3}\t{:.3}", times[rounds / 2], times[0]);
    }
}
