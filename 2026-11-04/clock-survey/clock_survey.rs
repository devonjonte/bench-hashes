//! clock_survey: the clocks a machine offers, measured against what the
//! design of `clocks` assumes of them (Zooko, November 4, 2026).
//!
//!   cargo run --release -p clocks --example clock_survey [SLEW_SECONDS]
//!
//! For each clock this platform has (std's Instant; clock_gettime's
//! REALTIME, MONOTONIC, MONOTONIC_RAW, THREAD_CPUTIME; Darwin's
//! UPTIME_RAW and mach_absolute_time; the CPU's counter, rdtscp on x86-64
//! and cntvct on AArch64), in a table:
//!
//! 1. **read**: the cost of one read, nanoseconds, over a million reads
//!    back to back (the raw counter's nanoseconds, so a clock's own cost);
//! 2. **step**: the smallest nonzero difference between two reads: the
//!    clock's resolution as a program sees it (a clock stepping in whole
//!    microseconds shows 1000);
//! 3. **slew**: how the clock's rate differs from the raw counter's over
//!    SLEW_SECONDS (default 20), in ppm, and for the slewed clocks the
//!    offset from the raw counter now (what a time daemon has applied
//!    since boot); a raw clock reads 0 ppm within the read's noise;
//! 4. **dispersion** when timing one fixed call (a 1 KiB BLAKE3 hash,
//!    this crate's reference loop standing in: a fixed amount of integer
//!    work) 2000 times, back to back and each after a 1 ms sleep: the
//!    median and the spread (p90 / p10) of the readings; beside the wall
//!    clocks, the thread's cycles and instructions from `clocks::Counts`,
//!    read the same way, with the cost of a counts read.
//!
//! What the design assumes, and this checks: the raw clocks (MONOTONIC_RAW,
//! UPTIME_RAW) read at the same cost and step as the slewed ones; the
//! slewed ones (REALTIME, MONOTONIC, Instant on Linux) drift from the raw
//! counter at a rate a time daemon sets; the CPU's own counter is the
//! cheapest and the finest; thread CPU time is a system call and excludes
//! preemption; cycles and instructions disperse far less than any wall
//! clock after a pause, and more alike back to back.

use std::hint::black_box;
use std::time::{Duration, Instant};

#[repr(C)]
struct Timespec {
    sec: i64,
    nsec: i64,
}

unsafe extern "C" {
    fn clock_gettime(clock_id: i32, tp: *mut Timespec) -> i32;
}

#[cfg(target_vendor = "apple")]
unsafe extern "C" {
    fn clock_gettime_nsec_np(clock_id: u32) -> u64;
    fn mach_absolute_time() -> u64;
}

fn gettime(clock: i32) -> u64 {
    let mut ts = Timespec { sec: 0, nsec: 0 };
    // Sound: clock_gettime writes the timespec it is given.
    let r = unsafe { clock_gettime(clock, &mut ts) };
    assert_eq!(r, 0, "clock_gettime({clock})");
    ts.sec as u64 * 1_000_000_000 + ts.nsec as u64
}

#[cfg(target_vendor = "apple")]
const CLOCKS: &[(&str, i32)] = &[("REALTIME", 0), ("MONOTONIC", 6), ("MONOTONIC_RAW", 4), ("UPTIME_RAW", 8), ("THREAD_CPUTIME", 16)];
#[cfg(not(target_vendor = "apple"))]
const CLOCKS: &[(&str, i32)] = &[("REALTIME", 0), ("MONOTONIC", 1), ("MONOTONIC_RAW", 4), ("THREAD_CPUTIME", 3)];

/// The raw counter, the reference every other clock is held against:
/// MONOTONIC_RAW on Linux, UPTIME_RAW on Darwin (clocks::now reads these).
fn raw_ns() -> u64 {
    #[cfg(target_vendor = "apple")]
    {
        unsafe { clock_gettime_nsec_np(8) }
    }
    #[cfg(not(target_vendor = "apple"))]
    {
        gettime(4)
    }
}

/// The CPU's own counter, in its ticks, where the architecture offers one
/// to user code.
fn cpu_counter() -> Option<u64> {
    #[cfg(target_arch = "x86_64")]
    {
        let mut aux = 0u32;
        // Sound: rdtscp reads the time-stamp counter.
        Some(unsafe { core::arch::x86_64::__rdtscp(&mut aux) })
    }
    #[cfg(target_arch = "aarch64")]
    {
        let now: u64;
        // Sound: CNTVCT_EL0 is readable at EL0 on Linux and macOS.
        unsafe { core::arch::asm!("mrs {0}, cntvct_el0", out(reg) now, options(nomem, nostack, preserves_flags)) };
        Some(now)
    }
    #[cfg(not(any(target_arch = "x86_64", target_arch = "aarch64")))]
    None
}

/// A fixed amount of integer work, a 1 KiB hash's worth of a few
/// microseconds: the thing each clock times.
#[inline(never)]
fn work() -> u64 {
    let mut h = 0x9e37_79b9_7f4a_7c15u64;
    for i in 0..4096u64 {
        h = (h ^ black_box(i)).wrapping_mul(0x100_0000_01b3).rotate_left(23);
    }
    h
}

struct Clock {
    name: &'static str,
    read: Box<dyn Fn() -> u64>,
    /// Ticks per nanosecond of the raw counter (1 for nanosecond clocks).
    scale: f64,
    raw: bool,
}

fn clocks() -> Vec<Clock> {
    let mut v: Vec<Clock> = vec![Clock {
        name: "Instant",
        read: Box::new({
            let origin = Instant::now();
            move || origin.elapsed().as_nanos() as u64
        }),
        scale: 1.0,
        raw: cfg!(target_vendor = "apple"),
    }];
    for &(name, id) in CLOCKS {
        v.push(Clock { name, read: Box::new(move || gettime(id)), scale: 1.0, raw: name.ends_with("_RAW") });
    }
    #[cfg(target_vendor = "apple")]
    {
        let ticks_per_ns = {
            let (r0, m0) = (raw_ns(), unsafe { mach_absolute_time() });
            std::thread::sleep(Duration::from_millis(200));
            let (r1, m1) = (raw_ns(), unsafe { mach_absolute_time() });
            (m1 - m0) as f64 / (r1 - r0) as f64
        };
        v.push(Clock { name: "mach_absolute_time", read: Box::new(|| unsafe { mach_absolute_time() }), scale: ticks_per_ns, raw: true });
    }
    if let Some(_) = cpu_counter() {
        let ticks_per_ns = {
            let (r0, c0) = (raw_ns(), cpu_counter().unwrap());
            std::thread::sleep(Duration::from_millis(200));
            let (r1, c1) = (raw_ns(), cpu_counter().unwrap());
            (c1 - c0) as f64 / (r1 - r0) as f64
        };
        let name = if cfg!(target_arch = "x86_64") { "rdtscp" } else { "cntvct" };
        v.push(Clock { name, read: Box::new(|| cpu_counter().unwrap()), scale: ticks_per_ns, raw: true });
    }
    v
}

fn percentile(sorted: &[f64], p: f64) -> f64 {
    sorted[((sorted.len() - 1) as f64 * p) as usize]
}

fn main() {
    let slew_seconds: u64 = std::env::args().nth(1).and_then(|a| a.parse().ok()).unwrap_or(20);
    let clocks = clocks();
    println!(
        "clock_survey on {} {} ({} CPUs); the raw counter: {}",
        std::env::consts::OS,
        std::env::consts::ARCH,
        std::thread::available_parallelism().map_or(0, |n| n.get()),
        if cfg!(target_vendor = "apple") { "CLOCK_UPTIME_RAW" } else { "CLOCK_MONOTONIC_RAW" }
    );
    println!();
    println!("{:<20} {:>8} {:>8} {:>10} {:>14}   {:<}", "clock", "read ns", "step ns", "slew ppm", "offset ms", "note");
    // 1 and 2: read cost and smallest step, a million reads.
    let mut rows = Vec::new();
    for c in &clocks {
        const N: u64 = 1_000_000;
        let start = raw_ns();
        let mut last = (c.read)();
        let mut smallest = u64::MAX;
        for _ in 0..N {
            let t = (c.read)();
            if t > last && t - last < smallest {
                smallest = t - last;
            }
            last = t;
        }
        let read_ns = (raw_ns() - start) as f64 / N as f64;
        rows.push((read_ns, smallest as f64 / c.scale));
    }
    // 3: slew over SLEW_SECONDS, each clock against the raw counter; the
    // offset to the raw counter now (nanosecond clocks on one epoch).
    let starts: Vec<(u64, u64)> = clocks.iter().map(|c| (raw_ns(), (c.read)())).collect();
    std::thread::sleep(Duration::from_secs(slew_seconds));
    let ends: Vec<(u64, u64)> = clocks.iter().map(|c| (raw_ns(), (c.read)())).collect();
    for (i, c) in clocks.iter().enumerate() {
        let raw = (ends[i].0 - starts[i].0) as f64;
        let own = (ends[i].1 - starts[i].1) as f64 / c.scale;
        let ppm = (own - raw) / raw * 1e6;
        let offset = if c.name == "REALTIME" || c.name == "MONOTONIC" {
            format!("{:>14.1}", (ends[i].1 as i128 - ends[i].0 as i128) as f64 / 1e6)
        } else {
            format!("{:>14}", "-")
        };
        let note = match c.name {
            "THREAD_CPUTIME" => "this thread's CPU time: the sleep is not counted (a slew of about -1e6)",
            "Instant" if cfg!(target_vendor = "apple") => "std reads CLOCK_UPTIME_RAW here",
            "Instant" => "std reads CLOCK_MONOTONIC here",
            "REALTIME" => "the offset is since the epoch: the whole date",
            "MONOTONIC" => "the offset is the time daemon's slew since boot",
            _ if c.raw => "raw",
            _ => "",
        };
        println!("{:<20} {:>8.1} {:>8.0} {:>10.1} {}   {}", c.name, rows[i].0, rows[i].1, ppm, offset, note);
    }
    // 4: dispersion timing one fixed call, back to back and after a pause.
    println!();
    println!("timing one fixed call ({} ns of integer work) 2000 times: median, then p90 / p10", {
        let t = raw_ns();
        black_box(work());
        raw_ns() - t
    });
    println!("{:<20} {:>14} {:>10}   {:>14} {:>10}", "clock", "back to back", "p90/p10", "after 1 ms", "p90/p10");
    let time_with = |read: &dyn Fn() -> u64, scale: f64, pause: bool| -> (f64, f64) {
        let mut v: Vec<f64> = (0..2000)
            .map(|_| {
                if pause {
                    std::thread::sleep(Duration::from_millis(1));
                }
                let a = read();
                black_box(work());
                let b = read();
                (b - a) as f64 / scale
            })
            .collect();
        v.sort_by(f64::total_cmp);
        (percentile(&v, 0.5), percentile(&v, 0.9) / percentile(&v, 0.1).max(1.0))
    };
    for c in &clocks {
        let (m0, s0) = time_with(&*c.read, c.scale, false);
        let (m1, s1) = time_with(&*c.read, c.scale, true);
        println!("{:<20} {:>14.0} {:>10.3}   {:>14.0} {:>10.3}", c.name, m0, s0, m1, s1);
    }
    // The thread's counts: cycles and instructions, by clocks::Counts.
    match clocks::Counts::read() {
        None => println!("{:<20} {:>14}", "cycles/instructions", "none on this platform (clocks::Counts::read)"),
        Some(_) => {
            let cost = {
                let start = raw_ns();
                for _ in 0..10_000 {
                    black_box(clocks::Counts::read());
                }
                (raw_ns() - start) as f64 / 10_000.0
            };
            for (what, pick) in [("cycles", 0usize), ("instructions", 1usize)] {
                let read = || {
                    let c = clocks::Counts::read().unwrap();
                    if pick == 0 {
                        c.p.cycles + c.e.cycles
                    } else {
                        c.p.instructions + c.e.instructions
                    }
                };
                let (m0, s0) = time_with(&read, 1.0, false);
                let (m1, s1) = time_with(&read, 1.0, true);
                println!("{:<20} {:>14.0} {:>10.3}   {:>14.0} {:>10.3}   (a counts read costs {cost:.0} ns, a system call)", what, m0, s0, m1, s1);
            }
        }
    }
}
