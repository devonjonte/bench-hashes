#!/bin/sh
# Methodology audit E4 (declared before running): the cost of an incremental hasher made for one short message,
# beside the one-shot call, for BLAKE3-Servil, official BLAKE3 and ring. No benchmark cell times it alone.
set -u
export PATH=$HOME/.cargo/bin:$PATH
O=$HOME/runs/hasher-probe; REV=900d8c9279a001cf74dbd4b389581d61e2eacc44
cd $HOME/work
git -C bench-hashes fetch -q --all --tags
[ -d bench-align ] || git -C bench-hashes worktree add -q --detach ../bench-align $REV
B=$HOME/work/bench-align; git -C $B checkout -q --detach $REV; test "$(git -C $B rev-parse HEAD)" = $REV || { echo "probe checkout differs"; exit 1; }
cd $B; cargo build --release --example hasher_probe 2>&1 | tail -1
grep -m1 'model name' /proc/cpuinfo; echo "governor $(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 2>/dev/null)"
for i in 1 2; do taskset -c 2 ./target/release/examples/hasher_probe > $O/run-$i.tsv 2> $O/run-$i.stderr.txt; echo "== run $i exit $? $(date -u +%H:%M)"; done
echo "== done"
