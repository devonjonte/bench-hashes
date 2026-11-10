//! The diagnostic events (clocks::events) on known work, as John Servil
//! validated the Mac's (bench-hashes #160): each kernel's events per step,
//! read around many steps (the reads' cost diluted), beside a bracket
//! around nothing. Run it on each kind of core:
//!
//!     cargo run --release --example events_check            # anywhere
//!     taskset -c 2 cargo run --release --example events_check   # a P core
//!
//! What each kernel should show, per step:
//! - `dependent`: a chain of dependent multiply-adds: a few cycles a step
//!   (the multiply's latency), most of them backend stalls, no misses.
//! - `chase`: a pointer chase through 256 MiB in a random cycle: about one
//!   L1 data miss and one dTLB miss a step, the stalls most of the cycles.
//! - `branches`: a branch on a random bit: about half a mispredict a step.
//! - `sequential`: a sum over 64 MiB in order: about one L1 data miss a
//!   64-byte line (an eighth a step of 8 bytes), next to no dTLB misses.
use clocks::events::{Events, NAMES};
use std::hint::black_box;

fn measure(name: &str, steps: u64, mut work: impl FnMut()) {
    let then = Events::read().expect("this platform counts the diagnostic events");
    work();
    let now = Events::read().unwrap();
    let d = now.since(then);
    let total = d.total();
    let per = |v: Option<u64>| v.map_or("-".to_owned(), |v| format!("{:.3}", v as f64 / steps as f64));
    let kinds = format!("P {} ms, E {} ms", d.p.time_ns / 1_000_000, d.e.time_ns / 1_000_000);
    println!("{name:<11} {} | {kinds}", NAMES.iter().zip(total.values).map(|(n, v)| format!("{n} {}", per(v))).collect::<Vec<_>>().join(", "));
}

#[inline(never)]
fn one(x: u64) -> u64 {
    black_box(x.wrapping_mul(3))
}

#[inline(never)]
fn other(x: u64) -> u64 {
    black_box(x ^ 0x55)
}

fn main() {
    measure("nothing", 1, || {});
    let n: u64 = 20_000_000;
    measure("dependent", n, || {
        // The multiplier through black_box, each step: no closed form.
        let mut x = black_box(3u64);
        for _ in 0..n {
            x = x.wrapping_mul(black_box(0x9e37_79b9_7f4a_7c15)).wrapping_add(x >> 7);
        }
        black_box(x);
    });
    // A random cycle through 32 Mi slots of 8 bytes (Sattolo's shuffle).
    let len = 32 << 20;
    let mut next: Vec<u64> = (0..len as u64).collect();
    let mut seed = 0x2545_f491_4f6c_dd1du64;
    let mut rand = move || {
        seed ^= seed << 13;
        seed ^= seed >> 7;
        seed ^= seed << 17;
        seed
    };
    for i in (1..len).rev() {
        let j = (rand() % i as u64) as usize;
        next.swap(i, j);
    }
    let steps = 4_000_000u64;
    measure("chase", steps, || {
        let mut at = 0usize;
        for _ in 0..steps {
            at = next[at] as usize;
        }
        black_box(at);
    });
    let bits: Vec<u8> = (0..steps).map(|_| (rand() & 1) as u8).collect();
    measure("branches", steps, || {
        // Two calls the compiler cannot merge into a select.
        let mut count = 0u64;
        for &b in &bits {
            if black_box(b) == 1 {
                count = one(count);
            } else {
                count = other(count);
            }
        }
        black_box(count);
    });
    let words = 8 << 20; // 64 MiB of u64
    measure("sequential", words as u64, || {
        let mut sum = 0u64;
        for &w in &next[..words] {
            sum = sum.wrapping_add(w);
        }
        black_box(sum);
    });
}
