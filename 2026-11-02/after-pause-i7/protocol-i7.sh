#!/bin/bash
# bench-hashes: the after-pause cells' protocol experiment (#106 follow-up, Sam and Zooko's request
# for active controls). Factors:
#   pause before the call: 20 us, 200 us, 1 ms (today's), 5 ms, shuffled visit by visit;
#   idle settings, where there are states: as shipped; C6 disabled; C1E and C6 disabled (all CPUs,
#   restored on exit), as blocks in rotated order, 2 rounds;
#   cells: servil st hash_many 16 x 64 B; servil st one 1 KiB message; official 1.8.7 one 1 KiB
#   message; servil mt hash_multithreaded 1 MiB (the pool's wake).
# Recorded per visit, all outside the timed call (read before the pause and after the call): CPU 2's
# cpuidle usage deltas, and where the machine has the cstate_core PMU, the core's C1 and C6
# residency (hardware counters) and the TSC, so their share of the pause. Every 10th visit also
# times a call after 50 warm ones (the steady reference). blake3-servil 0.8 (b5b988d8). Caller on CPU 2.
set -u
R="$1"; O="$R/out"; mkdir -p "$O"; cd "$R"
export PATH=/home/agent/.cargo/bin:$PATH TMPDIR=/home/agent/tmp; unset RUSTFLAGS
CPU=2
{ grep -m1 'model name' /proc/cpuinfo; nproc; uname -r; sort -u /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
  echo "cpuidle driver: $(cat /sys/devices/system/cpu/cpuidle/current_driver) governor: $(cat /sys/devices/system/cpu/cpuidle/current_governor)"
  for s in /sys/devices/system/cpu/cpu$CPU/cpuidle/state*; do [ -d "$s" ] && echo "$(basename $s) $(cat $s/name) latency $(cat $s/latency) residency $(cat $s/residency)"; done
  [ -d /sys/bus/event_source/devices/cstate_core ] && echo "cstate_core type $(cat /sys/bus/event_source/devices/cstate_core/type) c1 $(cat /sys/bus/event_source/devices/cstate_core/events/c1-residency 2>/dev/null) c6 $(cat /sys/bus/event_source/devices/cstate_core/events/c6-residency 2>/dev/null)"
  git -C fork log -1 --format=%H; } > "$O/machine.txt"
mkdir -p probe/src
cat > probe/Cargo.toml <<'TOML_END'
[package]
name = "pause-probe"
version = "0.0.0"
edition = "2021"
[dependencies]
blake3-servil = { path = "../fork" }
blake3 = "=1.8.7"
libc = "0.2"
TOML_END
cat > probe/src/main.rs <<'RUST_END'
//! pause-probe CPU VISITS SEED: per visit, a cell and a pause from a shuffled schedule; counters
//! read; the pause; the timed call; counters read again. One line a visit:
//! cell pause_us first_ns steady_ns(-) cpuidle_usage_deltas c1_res c6_res tsc
use blake3_servil::performance::{hash_many, hash_multithreaded, Batch, Block};
use blake3_servil::Mode;
use std::time::{Duration, Instant};

#[repr(C)]
#[derive(Default)]
struct PerfEventAttr { type_: u32, size: u32, config: u64, sample_period: u64, sample_type: u64, read_format: u64, flags: u64, wakeup_events: u32, bp_type: u32, config1: u64 }

fn sysfs(p: &str) -> Option<String> { std::fs::read_to_string(p).ok().map(|s| s.trim().to_string()) }

/// The cstate_core PMU's counter `event` for `cpu`, if the machine has it.
fn cstate(cpu: usize, name: &str) -> Option<i32> {
    let ty: u32 = sysfs("/sys/bus/event_source/devices/cstate_core/type")?.parse().ok()?;
    let ev = sysfs(&format!("/sys/bus/event_source/devices/cstate_core/events/{name}"))?;
    let config = u64::from_str_radix(ev.strip_prefix("event=0x")?, 16).ok()?;
    let attr = PerfEventAttr { type_: ty, size: std::mem::size_of::<PerfEventAttr>() as u32, config, ..Default::default() };
    // Sound: perf_event_open reads `attr` (its size given): a system-wide counter of `cpu`'s core.
    let fd = unsafe { libc::syscall(libc::SYS_perf_event_open, &attr as *const PerfEventAttr, -1, cpu as i32, -1, 0) } as i32;
    (fd >= 0).then_some(fd)
}
fn read_fd(fd: Option<i32>) -> u64 {
    let Some(fd) = fd else { return 0 };
    let mut v = 0u64;
    // Sound: reads 8 bytes into v.
    unsafe { libc::read(fd, &mut v as *mut u64 as *mut libc::c_void, 8) };
    v
}
fn usage(cpu: usize, n: usize) -> Vec<u64> {
    (0..n).map(|s| sysfs(&format!("/sys/devices/system/cpu/cpu{cpu}/cpuidle/state{s}/usage")).and_then(|v| v.parse().ok()).unwrap_or(0)).collect()
}
fn pin(cpu: usize) {
    // Sound: a zeroed cpu_set_t is empty; CPU_SET writes within it.
    unsafe { let mut set: libc::cpu_set_t = core::mem::zeroed(); libc::CPU_SET(cpu, &mut set); assert_eq!(libc::sched_setaffinity(0, core::mem::size_of::<libc::cpu_set_t>(), &set), 0); }
}
fn main() {
    let a: Vec<String> = std::env::args().collect();
    let (cpu, visits, seed): (usize, usize, u64) = (a[1].parse().unwrap(), a[2].parse().unwrap(), a[3].parse().unwrap());
    blake3_servil::initialize_multithreaded(None);
    pin(cpu);
    let nstates = (0..).take_while(|s| std::path::Path::new(&format!("/sys/devices/system/cpu/cpu{cpu}/cpuidle/state{s}")).exists()).count();
    let (c1, c6) = (cstate(cpu, "c1-residency"), cstate(cpu, "c6-residency"));
    println!("# states {nstates} cstate_core c1 {} c6 {}", c1.is_some(), c6.is_some());
    let batch_blocks = vec![Block([5u8; 64]); 16];
    let one_k: Vec<u8> = (0..1024).map(|i| (i * 7) as u8).collect();
    let mib: Vec<Block> = (0..(1 << 20) / 64).map(|i| Block([i as u8; 64])).collect();
    let mut out = vec![[0u8; 32]; 16];
    let cells = ["st16x64", "st1k", "off1k", "mt1m"];
    let pauses = [20u64, 200, 1000, 5000];
    // The schedule: every (cell, pause) `visits` times, shuffled (xorshift from `seed`).
    let mut sched: Vec<(usize, usize)> = (0..visits).flat_map(|_| (0..cells.len()).flat_map(|c| (0..pauses.len()).map(move |p| (c, p)))).collect();
    let mut x = seed | 1;
    for i in (1..sched.len()).rev() { x ^= x << 13; x ^= x >> 7; x ^= x << 17; sched.swap(i, (x % (i as u64 + 1)) as usize); }
    let mut call = |c: usize| -> u64 {
        let t = Instant::now();
        match c {
            0 => { hash_many(Mode::Plain, &Batch::from_blocks(&batch_blocks, 64), &mut out); std::hint::black_box(&out); }
            1 => { std::hint::black_box(blake3_servil::convenience::hash(&one_k)); }
            2 => { std::hint::black_box(blake3::hash(&one_k)); }
            _ => { std::hint::black_box(hash_multithreaded(Mode::Plain, &mib, mib.len() * 64)); }
        }
        t.elapsed().as_nanos() as u64
    };
    for c in 0..cells.len() { for _ in 0..20 { call(c); } }
    for (i, &(c, p)) in sched.iter().enumerate() {
        let (u0, r1, r6) = (usage(cpu, nstates), read_fd(c1), read_fd(c6));
        // Sound: rdtsc reads the time-stamp counter.
        let t0 = unsafe { core::arch::x86_64::_rdtsc() };
        std::thread::sleep(Duration::from_micros(pauses[p]));
        let first = call(c);
        let t1 = unsafe { core::arch::x86_64::_rdtsc() };
        let (u1, s1, s6) = (usage(cpu, nstates), read_fd(c1), read_fd(c6));
        let steady = if i % 10 == 0 { for _ in 0..50 { call(c); } call(c).to_string() } else { "-".into() };
        let du: Vec<String> = u0.iter().zip(&u1).map(|(a, b)| (b - a).to_string()).collect();
        println!("{}\t{}\t{first}\t{steady}\t{}\t{}\t{}\t{}", cells[c], pauses[p], du.join(","), s1.wrapping_sub(r1), s6.wrapping_sub(r6), t1 - t0);
    }
}
RUST_END
(cd probe && cargo build --release) > "$O/probe-build.log" 2>&1 || { echo "probe build failed" >> "$O/status.txt"; exit 2; }
grep -A2 'name = "blake3-servil"' probe/Cargo.lock > "$O/probe-lock.txt"; grep -A1 'name = "blake3"$' probe/Cargo.lock >> "$O/probe-lock.txt"
P="$R/probe/target/release/pause-probe"
NS=$(ls -d /sys/devices/system/cpu/cpu$CPU/cpuidle/state* 2>/dev/null | wc -l)
for f in /sys/devices/system/cpu/cpu*/cpuidle/state*/disable; do echo "$f $(cat $f)"; done > "$O/disable-before.txt"
restore() { :; } # i7: no root, states as shipped
trap restore EXIT
# Disable, on every CPU, the states named (by name, from sysfs).
disable() { local s; for s in /sys/devices/system/cpu/cpu[0-9]*/cpuidle/state*; do for n in "$@"; do [ "$(cat $s/name)" = "$n" ] && echo 1 > $s/disable; done; done; }
CONFIGS="shipped" # i7: no root for the controlled blocks
for round in 1 2; do
  L=$CONFIGS; [ $round = 2 ] && L=$(echo $CONFIGS | tr ' ' '\n' | tac | tr '\n' ' ')
  for c in $L; do
    restore
    case $c in noC6) disable C6 ;; C1only) disable C1E C6 ;; esac
    { for s in /sys/devices/system/cpu/cpu$CPU/cpuidle/state*; do [ -d "$s" ] && printf '%s=%s ' $(cat $s/name) $(cat $s/disable); done; echo; } > "$O/$c-$round.states"
    "$P" $CPU 300 $round$NS > "$O/$c-$round.tsv" 2> "$O/$c-$round.err"
    echo "$c round $round exit $?" >> "$O/status.txt"
  done
done
restore; trap - EXIT
for f in /sys/devices/system/cpu/cpu*/cpuidle/state*/disable; do echo "$f $(cat $f)"; done > "$O/disable-after.txt"
cmp -s "$O/disable-before.txt" "$O/disable-after.txt" && echo "states restored" >> "$O/status.txt" || echo "STATES NOT RESTORED" >> "$O/status.txt"
echo "protocol done" >> "$O/status.txt"
