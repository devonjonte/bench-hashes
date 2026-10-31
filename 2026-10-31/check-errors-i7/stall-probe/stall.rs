const THRESH: u64 = 36_000; // 10 us
// Back-to-back slices of ~4 us of work, timed with the TSC; prints how
// many slices took over 5x the median, the extra time they cost, and the
// slice count, over a fixed duration. Run pinned (taskset).
use std::arch::x86_64::_rdtsc;
fn main() {
    let secs: u64 = std::env::args().nth(1).unwrap().parse().unwrap();
    let work: u64 = std::env::args().nth(2).unwrap().parse().unwrap();
    let mut x = 1u64;
    let mut t = Vec::with_capacity(4_000_000);
    let mut big: Vec<u64> = Vec::new();
    let t_end = std::time::Instant::now() + std::time::Duration::from_secs(secs);
    while std::time::Instant::now() < t_end {
        for _ in 0..1000 {
            let a = unsafe { _rdtsc() };
            for _ in 0..work { x = x.wrapping_mul(6364136223846793005).wrapping_add(1442695040888963407); }
            let b = unsafe { _rdtsc() };
            t.push(b - a);
            if b - a > THRESH { big.push(a); }
        }
    }
    std::hint::black_box(x);
    let mut s = t.clone(); s.sort_unstable();
    let med = s[s.len() / 2];
    let slow: Vec<u64> = t.iter().copied().filter(|&d| d > 5 * med).collect();
    let extra: u64 = slow.iter().map(|d| d - med).sum();
    let mut sl = slow.clone(); sl.sort_unstable();
    for lim in [2_000u64, 20_000, 72_000, 360_000] {
        println!("  extra over {:>7} ticks ({:>5.1} us): {:>6} ({:.1} /s)", lim, lim as f64 / 3600.0, slow.iter().filter(|&&d| d - med > lim).count(), slow.iter().filter(|&&d| d - med > lim).count() as f64 / secs as f64);
    }
    let mut ru: libc_rusage = unsafe { std::mem::zeroed() };
    unsafe { getrusage(1, &mut ru) };
    println!("  this thread's context switches: voluntary {} involuntary {}", ru.f[16], ru.f[17]);
    if let Some(p) = std::env::args().nth(3) { std::fs::write(p, big.iter().map(|x| x.to_string()).collect::<Vec<_>>().join("\n")).unwrap(); }
    let gaps: Vec<u64> = big.windows(2).map(|w| (w[1] - w[0]) / 3600).collect();
    let mut g = gaps.clone(); g.sort_unstable(); if g.is_empty() { g.push(0); }
    println!("  >100 us stalls: {}; gaps between them in us: first {:?}; sorted quartiles {:?}", big.len(), &gaps[..gaps.len().min(16)], [g[g.len()/4], g[g.len()/2], g[3*g.len()/4]]);
    println!("slices {} median {} ticks; over 5x: {} ({:.0} /s); their extra: median {} ticks, max {}; total {:.2}% of time",
        t.len(), med, slow.len(), slow.len() as f64 / secs as f64,
        sl.get(sl.len() / 2).map_or(0, |d| d - med), sl.last().map_or(0, |d| d - med),
        100.0 * extra as f64 / t.iter().sum::<u64>() as f64);
}

#[repr(C)]
struct libc_rusage { f: [i64; 18] }
extern "C" { fn getrusage(who: i32, usage: *mut libc_rusage) -> i32; }
