#!/bin/sh
# Methodology audit E3 (declared before running): does a one-message hash's speed depend on where its input sits
# in a cache line? The benchmark's one-message cells give every contender a 64-byte boundary; a program's large
# Vec<u8> from glibc sits 16 bytes into a line. examples/align_probe.rs (probe branch, 973cf428c20a54b63edda2a9dc0d4e39abacd859) hashes the
# same bytes at offsets 0, 16 and 1, call after call, on one pinned core, twice. A ratio within 2% of 1 everywhere
# closes the question; a larger one names a gap in what the benchmark asks.
set -u
export PATH=$HOME/.cargo/bin:$PATH
O=$HOME/runs/align-probe; REV=973cf428c20a54b63edda2a9dc0d4e39abacd859
cd $HOME/work
git -C bench-hashes fetch -q --all --tags
[ -d bench-align ] || git -C bench-hashes worktree add -q --detach ../bench-align $REV
B=$HOME/work/bench-align; git -C $B checkout -q --detach $REV; test "$(git -C $B rev-parse HEAD)" = $REV || { echo "probe checkout differs"; exit 1; }
cd $B; cargo build --release --example align_probe 2>&1 | tail -1
grep -m1 'model name' /proc/cpuinfo; echo "governor $(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 2>/dev/null)"
for i in 1 2; do taskset -c 2 ./target/release/examples/align_probe > $O/run-$i.tsv 2> $O/run-$i.stderr.txt; echo "== run $i exit $? $(date -u +%H:%M)"; done
echo "== done"
