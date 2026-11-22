#!/bin/sh
# Declared before running (November 22, 2026). Zooko's question: what would a
# caller who cares for latency, and will pay for it, gain from a latency API
# beside the throughput API?
# This probe measures the one mechanism only the library can supply: pool
# workers that poll between calls in place of parking, and with them a lower
# length from which hash_multithreaded splits.
# Method: BLAKE3 probe/latency-ready (COMMIT below), examples/host_lab.rs,
# "latency VISITS": one call after each kind of gap (none; other work; 20 us
# asleep; 5 ms asleep), on one thread (convenience::hash) and over the pool
# (throughput::hash_multithreaded), under each setting: the library as it
# ships; the split at 32 KiB with workers asleep; the split at 32 KiB with
# 1, 3, 7 and all workers kept awake. Settings and cells are shuffled within
# each round. The process runs on the CPUs of CPU 0's last-level cache alone,
# so on a machine with several such caches the pool has one place.
# A probe: one build, one run, the clocks crate's wall clock, thread counts
# and load windows.
set -eu
COMMIT=de1a3f00ce2b899a784a7260aff1879143f37d45
VISITS=500
export PATH="$HOME/.cargo/bin:$PATH" CARGO_BUILD_JOBS=16 CARGO_INCREMENTAL=0
unset CARGO_TARGET_DIR RUSTFLAGS CARGO_ENCODED_RUSTFLAGS
O=$PWD
W="$HOME/work/latency-ready"
rm -rf "$W"
mkdir -p "$W"
git clone -q --filter=blob:none --no-checkout https://github.com/servil-software-factory/BLAKE3 "$W/lib"
git -C "$W/lib" fetch -q origin "$COMMIT"
git -C "$W/lib" checkout -q --detach "$COMMIT"
(cd "$W/lib" && cargo build --release --example host_lab > "$O/build.txt" 2>&1) || { tail -30 "$O/build.txt"; exit 1; }
CPUS=$(cat /sys/devices/system/cpu/cpu0/cache/index3/shared_cpu_list)
{
    echo "commit $COMMIT"
    echo "visits $VISITS"
    uname -srm
    rustc -V
    lscpu | grep -E -m3 'Model name|^CPU\(s\)|Thread\(s\) per core'
    echo "cpus used (CPU 0's last-level cache): $CPUS"
    echo "governor: $(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 2>/dev/null || echo none) driver: $(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver 2>/dev/null || echo none)"
    echo "idle driver: $(cat /sys/devices/system/cpu/cpuidle/current_driver 2>/dev/null || echo none)"
    for s in /sys/devices/system/cpu/cpu0/cpuidle/state*; do
        [ -d "$s" ] && echo "idle state $(cat "$s/name"): exit latency $(cat "$s/latency") us, target residency $(cat "$s/residency") us, disabled $(cat "$s/disable")"
    done
    echo "perf_event_paranoid: $(cat /proc/sys/kernel/perf_event_paranoid 2>/dev/null || echo unknown)"
} > "$O/provenance.txt" 2>&1
taskset -c "$CPUS" "$W/lib/target/release/examples/host_lab" latency "$VISITS" > "$O/report.txt" 2> "$O/host_lab.stderr.txt"
cat "$O/provenance.txt"
head -8 "$O/report.txt"
rm -rf "$W"
