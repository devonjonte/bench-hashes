//! Bench-hashes #261 probe: measure `convenience::hash` (st) and
//! `throughput::hash_multithreaded` (via unaligned convenience vs aligned)
//! — specifically `blake3_servil_core::convenience::hash` (which calls the
//! AVX-512 16-way/32-way wide kernels directly on arbitrary `&[u8]` slices)
//! at offset 0 (64-byte aligned) vs offset 16 (16 bytes past a 64-byte line)
//! vs offset 1, for 64 KiB, 1 MiB, and 16 MiB messages.
//! Also checks `blake3_servil::convenience::hash_multithreaded` (wait: does
//! `convenience::hash` or `Hasher::update` take `&[u8]`? Both!).
use blake3_servil::convenience::{Hasher, hash};
use std::hint::black_box;
use std::time::Instant;

fn main() {
    blake3_servil::initialize_multithreaded(None);
    let rounds: usize = std::env::args().nth(1).map_or(31, |a| a.parse().unwrap());
    let sizes = [
        ("64 KiB", 64 * 1024usize, 400usize),
        ("1 MiB", 1024 * 1024, 40),
        ("16 MiB", 16 * 1024 * 1024, 4),
    ];
    let offsets = [0usize, 16, 32, 1];
    let max_len = 16 * 1024 * 1024;
    let mut backing = vec![0u8; max_len + 128];
    let mut x = 0x9E37_79B9_7F4A_7C15u64;
    for b in &mut backing {
        x ^= x << 13;
        x ^= x >> 7;
        x ^= x << 17;
        *b = x as u8;
    }
    let base = backing.as_ptr().align_offset(64);
    assert_eq!((backing.as_ptr() as usize + base) % 64, 0);

    for (label, len, iters) in sizes {
        // Verify all offsets hash identical content to identical digest.
        let mut slices = Vec::new();
        for &off in &offsets {
            let mut buf = vec![0u8; len + 128];
            let b0 = buf.as_ptr().align_offset(64);
            let start = b0 + off;
            buf[start..start + len].copy_from_slice(&backing[base..base + len]);
            slices.push((off, buf, start));
        }
        let want = hash(&slices[0].1[slices[0].2..slices[0].2 + len]);
        for &(off, ref buf, start) in &slices {
            assert_eq!(hash(&buf[start..start + len]), want, "offset {off}");
        }

        // Single-threaded convenience::hash (calls 16-way / 32-way AVX-512 kernel directly on &[u8])
        let mut times: Vec<Vec<f64>> = vec![Vec::new(); offsets.len()];
        for _ in 0..3 {
            for (i, &(_, ref buf, start)) in slices.iter().enumerate() {
                let _ = i;
                black_box(hash(black_box(&buf[start..start + len])));
            }
        }
        for r in 0..rounds {
            for k in 0..offsets.len() {
                let idx = (r + k) % offsets.len();
                let (_, ref buf, start) = slices[idx];
                let s = &buf[start..start + len];
                let t0 = Instant::now();
                for _ in 0..iters {
                    black_box(hash(black_box(s)));
                }
                let ns_per_b = t0.elapsed().as_nanos() as f64 / (len * iters) as f64;
                times[idx].push(ns_per_b);
            }
        }
        println!("st convenience::hash  {label}  ({rounds} rounds x {iters} iters)");
        let mut med0 = 0.0;
        for (i, &off) in offsets.iter().enumerate() {
            times[i].sort_by(f64::total_cmp);
            let med = times[i][rounds / 2];
            if i == 0 { med0 = med; }
            println!("  offset {off:2}: median {med:.4} ns/B  fastest {:.4} ns/B  ratio vs 0: x{:.4}", times[i][0], med / med0);
        }

        // Multithreaded Hasher::update_multithreaded (takes arbitrary &[u8] slice, no Block alignment required)
        let mut mt_times: Vec<Vec<f64>> = vec![Vec::new(); offsets.len()];
        for r in 0..rounds {
            for k in 0..offsets.len() {
                let idx = (r + k) % offsets.len();
                let (_, ref buf, start) = slices[idx];
                let s = &buf[start..start + len];
                let t0 = Instant::now();
                for _ in 0..iters {
                    let mut h = Hasher::new(blake3_servil::Mode::Plain, None);
                    blake3_servil::throughput::update_multithreaded(&mut h, black_box(s));
                    black_box(h.finalize());
                }
                let ns_per_b = t0.elapsed().as_nanos() as f64 / (len * iters) as f64;
                mt_times[idx].push(ns_per_b);
            }
        }
        println!("mt update_multithreaded  {label}  ({rounds} rounds x {iters} iters)");
        let mut med0 = 0.0;
        for (i, &off) in offsets.iter().enumerate() {
            mt_times[i].sort_by(f64::total_cmp);
            let med = mt_times[i][rounds / 2];
            if i == 0 { med0 = med; }
            println!("  offset {off:2}: median {med:.4} ns/B  fastest {:.4} ns/B  ratio vs 0: x{:.4}", mt_times[i][0], med / med0);
        }
    }
}
