#!/bin/sh
# Methodology audit E1 (declared before running): what do the two benches themselves differ by?
# A check of BLAKE3-Servil 0.9.0 against 0.8 runs bench 0.22 on one side and bench 3363bee8 on the other.
# Here two contenders whose crates are identical on both sides (blake3 1.8.7, ring 0.17.14) run the same cells
# beside blake3-servil-st, by name, 24 fresh pairs. If their cells read level where servil's read slower, the
# difference is the library's; if they move with servil's, it is the benches'.
set -u
export PATH=$HOME/.cargo/bin:$PATH
O=$HOME/runs/@RUN@; M=$HOME/work/BLAKE3; REV=e310174178ac6b5721c6c4b597af12e88c8fb427
cd $HOME/work
git -C BLAKE3 fetch -q --all --tags; git -C bench-hashes fetch -q --all --tags
[ -d bench-probe ] || git -C bench-hashes worktree add -q --detach ../bench-probe $REV
B=$HOME/work/bench-probe; git -C $B checkout -q --detach $REV; test "$(git -C $B rev-parse HEAD)" = $REV || { echo "probe checkout differs"; exit 1; }
cd $B; cargo build --release 2>&1 | tail -1
echo "== bench $(git log --oneline -1 | cut -c1-60); governor $(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 2>/dev/null) $(date -u +%H:%M)"
P="64 B,1536 B,2304 B,4 KiB,16 KiB,32 KiB,64 KiB,continuous 64 B,continuous 4 KiB,brief idle 4 KiB,idle 4 KiB"
s=$(date +%s)
./target/release/bench-hashes check --fork $M --new bf2da8b957f5e0c80babb57952de3e53f95c921a --against b5b988d8 --old-bench 3363bee8 --contenders blake3-servil-st,blake3-official,sha256-ring --points "$P" --layouts 24 --when-quiet --keep $O/kept > $O/check.stdout.txt 2> $O/check.stderr.txt
echo "== check exit $? in $(( $(date +%s) - s )) s $(date -u +%H:%M)"
olds=$(ls $O/kept/run-*-old.tsv | tr '\n' ' '); news=$(ls $O/kept/run-*-new.tsv | tr '\n' ' ')
./target/release/bench-hashes compare $olds -- $news > $O/compare.txt 2> $O/compare.stderr.txt; echo "== compare exit $?"
# The kept runs are the evidence: deliver them (bench-submit removes kept* after the tarball is written).
echo "== done $(date -u +%H:%M)"
