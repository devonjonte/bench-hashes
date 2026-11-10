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
//! 4. **dispersion** when timing one fixed call (a few microseconds of
//!    integer work) 2000 times, back to back, each after a 1 ms sleep,
//!    and each after a 5 ms sleep (deeper idle states, a lower clock):
//!    the median and the spread (p90 / p10) of the readings; beside the
//!    wall clocks, the thread's cycles and instructions from
//!    `clocks::Counts`, and on Linux x86-64 perf's counters read two
//!    ways: by the `read` system call, and by `rdpmc` in user space
//!    through the event's mmap page (cycles, instructions, ref-cycles,
//!    the constant-rate reference), plus perf's `task-clock`, the
//!    thread's time as perf keeps it. Each with the cost of a read.
//!
//! What the design assumes, and this checks: the raw clocks (MONOTONIC_RAW,
//! UPTIME_RAW) read at the same cost and step as the slewed ones; the
//! slewed ones (REALTIME, MONOTONIC, Instant on Linux) drift from the raw
//! counter at a rate a time daemon sets; the CPU's own counter is the
//! cheapest and the finest; thread CPU time is a system call and excludes
//! preemption; cycles and instructions disperse far less than any wall
//! clock after a pause, and more alike back to back. Run it pinned to a
//! core of each kind the machine has (`taskset -c N`), and unpinned.

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

/// perf's counters on Linux x86-64, for this thread, each read two ways.
#[cfg(all(target_os = "linux", target_arch = "x86_64"))]
mod perf {
    use std::ffi::{c_int, c_long, c_void};

    #[repr(C)]
    struct Attr {
        kind: u32,
        size: u32,
        config: u64,
        sample_period: u64,
        sample_type: u64,
        read_format: u64,
        flags: u64,
        reserved: [u64; 2],
    }

    /// The first words of perf_event_mmap_page (the rest unused here).
    #[repr(C)]
    struct MmapPage {
        version: u32,
        compat_version: u32,
        lock: u32,
        index: u32,
        offset: i64,
        time_enabled: u64,
        time_running: u64,
        capabilities: u64,
        pmc_width: u16,
    }

    unsafe extern "C" {
        fn syscall(number: c_long, ...) -> c_long;
        fn read(fd: c_int, buffer: *mut c_void, size: usize) -> isize;
        fn mmap(addr: *mut c_void, len: usize, prot: c_int, flags: c_int, fd: c_int, offset: i64) -> *mut c_void;
        fn sched_getcpu() -> c_int;
    }

    pub struct Counter {
        fd: c_int,
        page: *const MmapPage,
    }

    /// The PMU type for the core this thread runs on: a hybrid machine's
    /// cpu_core or cpu_atom, else the generic hardware PMU (0).
    fn pmu_for_this_cpu() -> u32 {
        let cpu = unsafe { sched_getcpu() };
        for pmu in ["cpu_core", "cpu_atom"] {
            let dir = format!("/sys/bus/event_source/devices/{pmu}");
            let (Ok(cpus), Ok(kind)) = (std::fs::read_to_string(format!("{dir}/cpus")), std::fs::read_to_string(format!("{dir}/type"))) else { continue };
            let holds = cpus.trim().split(',').any(|range| {
                let mut ends = range.split('-').map(|x| x.trim().parse::<i32>().unwrap_or(-1));
                let a = ends.next().unwrap_or(-1);
                let b = ends.next().unwrap_or(a);
                (a..=b).contains(&cpu)
            });
            if holds {
                return kind.trim().parse().unwrap_or(0);
            }
        }
        0
    }

    /// A counter of `event` (PERF_TYPE_HARDWARE's, or software's with
    /// `software`) for this thread, user space alone for the hardware ones.
    pub fn open(name: &'static str, event: u64, software: bool) -> Option<Counter> {
        let (kind, config) = if software { (1u32, event) } else { (0u32, (u64::from(pmu_for_this_cpu()) << 32) | event) };
        // disabled 0, exclude_kernel (bit 5), exclude_hv (bit 6) for hardware.
        let flags = if software { 0 } else { (1 << 5) | (1 << 6) };
        let attr = Attr { kind, size: 64, config, sample_period: 0, sample_type: 0, read_format: 0, flags, reserved: [0; 2] };
        // Sound: perf_event_open reads the attr given; pid 0 (this thread), any CPU, no group, CLOEXEC.
        let fd = unsafe { syscall(298, &attr as *const Attr, 0, -1, -1, 8 as c_long) } as c_int;
        if fd < 0 {
            return None;
        }
        // Sound: a page of the event's mmap, read only; perf keeps it while the fd lives.
        let page = unsafe { mmap(std::ptr::null_mut(), 4096, 1, 1, fd, 0) };
        let page = if page as isize == -1 { std::ptr::null() } else { page as *const MmapPage };
        let _ = name;
        Some(Counter { fd, page })
    }

    impl Counter {
        /// The count by the read system call.
        pub fn read_syscall(&self) -> u64 {
            let mut v = 0u64;
            // Sound: reads 8 bytes into v.
            let n = unsafe { read(self.fd, &mut v as *mut u64 as *mut c_void, 8) };
            assert_eq!(n, 8, "a counter read");
            v
        }

        /// Whether rdpmc is allowed for this event (the mmap page says).
        pub fn rdpmc_allowed(&self) -> bool {
            if self.page.is_null() {
                return false;
            }
            // Sound: the page is mapped for the fd's life.
            let p = unsafe { &*self.page };
            p.capabilities & (1 << 2) != 0 && p.index > 0
        }

        /// The count by rdpmc in user space (seqlock on the page, as perf
        /// documents: index, offset and width, the counter, then the lock
        /// again).
        pub fn read_rdpmc(&self) -> u64 {
            // Sound: the page is mapped for the fd's life; rdpmc of an index
            // the page gave this thread is allowed by capabilities.
            unsafe {
                let p = &*self.page;
                loop {
                    let seq = std::ptr::read_volatile(&p.lock);
                    core::sync::atomic::fence(core::sync::atomic::Ordering::SeqCst);
                    let index = std::ptr::read_volatile(&p.index);
                    let offset = std::ptr::read_volatile(&p.offset);
                    let width = std::ptr::read_volatile(&p.pmc_width);
                    let raw = if index > 0 {
                        let lo: u32;
                        let hi: u32;
                        core::arch::asm!("rdpmc", in("ecx") index - 1, out("eax") lo, out("edx") hi, options(nomem, nostack, preserves_flags));
                        (u64::from(hi) << 32) | u64::from(lo)
                    } else {
                        0
                    };
                    core::sync::atomic::fence(core::sync::atomic::Ordering::SeqCst);
                    if std::ptr::read_volatile(&p.lock) == seq {
                        let shift = 64 - u32::from(width);
                        let signed = ((raw << shift) as i64) >> shift;
                        return (offset + signed) as u64;
                    }
                }
            }
        }
    }
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
    println!(
        "{:<28} {:>12} {:>8}   {:>12} {:>8}   {:>12} {:>8}   {:>8}",
        "clock", "back to back", "p90/p10", "after 1 ms", "p90/p10", "after 5 ms", "p90/p10", "read ns"
    );
    let time_with = |read: &dyn Fn() -> u64, scale: f64, pause_ms: u64| -> (f64, f64) {
        let mut v: Vec<f64> = (0..2000)
            .map(|_| {
                if pause_ms > 0 {
                    std::thread::sleep(Duration::from_millis(pause_ms));
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
    let read_cost = |read: &dyn Fn() -> u64| -> f64 {
        let start = raw_ns();
        for _ in 0..10_000 {
            black_box(read());
        }
        (raw_ns() - start) as f64 / 10_000.0
    };
    let row = |name: &str, read: &dyn Fn() -> u64, scale: f64| {
        let (m0, s0) = time_with(read, scale, 0);
        let (m1, s1) = time_with(read, scale, 1);
        let (m5, s5) = time_with(read, scale, 5);
        println!("{:<28} {:>12.0} {:>8.3}   {:>12.0} {:>8.3}   {:>12.0} {:>8.3}   {:>8.0}", name, m0, s0, m1, s1, m5, s5, read_cost(read));
    };
    for c in &clocks {
        row(c.name, &*c.read, c.scale);
    }
    // The thread's counts: cycles and instructions, by clocks::Counts (a
    // read system call for a group on each core kind's PMU).
    match clocks::Counts::read() {
        None => println!("{:<28} {:>12}", "Counts cycles/instructions", "none on this platform (clocks::Counts::read)"),
        Some(_) => {
            for (what, pick) in [("Counts cycles", 0usize), ("Counts instructions", 1usize)] {
                let read = || {
                    let c = clocks::Counts::read().unwrap();
                    if pick == 0 {
                        c.p.cycles + c.e.cycles
                    } else {
                        c.p.instructions + c.e.instructions
                    }
                };
                row(what, &read, 1.0);
            }
        }
    }
    // perf's counters, each by the read system call and by rdpmc.
    #[cfg(all(target_os = "linux", target_arch = "x86_64"))]
    {
        let events: [(&str, u64, bool); 4] =
            [("perf cycles", 0, false), ("perf instructions", 1, false), ("perf ref-cycles", 9, false), ("perf task-clock ns", 1, true)];
        for (name, event, software) in events {
            match perf::open(name, event, software) {
                None => println!("{:<28} {:>12}", name, "perf_event_open refused (perf_event_paranoid, or no such event here)"),
                Some(counter) => {
                    row(&format!("{name}, read()"), &|| counter.read_syscall(), 1.0);
                    if counter.rdpmc_allowed() {
                        row(&format!("{name}, rdpmc"), &|| counter.read_rdpmc(), 1.0);
                        // Does rdpmc agree with the kernel's read of the same
                        // counter? Over 200 calls: the difference the two ways
                        // give, both bracketing the same work, the worst of them.
                        let mut worst = 0i128;
                        for _ in 0..200 {
                            let (r0, p0) = (counter.read_syscall(), counter.read_rdpmc());
                            black_box(work());
                            let (p1, r1) = (counter.read_rdpmc(), counter.read_syscall());
                            // read() brackets rdpmc, so its count is the larger by the reads' own work.
                            let (by_read, by_rdpmc) = ((r1 - r0) as i128, (p1 - p0) as i128);
                            worst = worst.max((by_read - by_rdpmc).abs());
                        }
                        println!("{:<28} {:>12}   rdpmc and read() agree within {worst} of the count over a call (read() brackets rdpmc, so a small excess is its own)", format!("{name}, agreement"), "");
                    } else {
                        println!(
                            "{:<28} {:>12}",
                            format!("{name}, rdpmc"),
                            if software { "no counter register (software)" } else { "not allowed here (the mmap page's cap_user_rdpmc)" }
                        );
                    }
                }
            }
        }
        println!();
        println!("the core's clock from the counts after each pause (Counts cycles over the thread's time), MHz:");
        for pause_ms in [0u64, 1, 5] {
            let mut mhz: Vec<f64> = (0..500)
                .map(|_| {
                    if pause_ms > 0 {
                        std::thread::sleep(Duration::from_millis(pause_ms));
                    }
                    let a = clocks::Counts::read().unwrap();
                    black_box(work());
                    let d = clocks::Counts::read().unwrap().since(a);
                    (d.p.cycles + d.e.cycles) as f64 * 1000.0 / (d.p.time_ns + d.e.time_ns).max(1) as f64
                })
                .collect();
            mhz.sort_by(f64::total_cmp);
            println!("  after {pause_ms} ms: median {:.0} MHz, p10 {:.0}, p90 {:.0}", percentile(&mhz, 0.5), percentile(&mhz, 0.1), percentile(&mhz, 0.9));
        }
    }
}
