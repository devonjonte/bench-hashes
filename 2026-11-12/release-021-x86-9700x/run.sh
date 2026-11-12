#!/bin/sh
# bench-hashes 0.21 at its tag on this machine, pin BLAKE3-Servil 2037118c: the full run, crowd, b3sum, the
# release checks against 0.8 (the long stream cells named, then every cell), the same-library check.
set -u
export PATH=$HOME/.cargo/bin:$PATH
O=$HOME/runs/release-021; C=2037118ca1da85710aef55d7f13b3abd9095b485; M=$HOME/work/BLAKE3
cd $HOME/work
[ -d bench-021tag ] || git -C bench-hashes worktree add -q --detach ../bench-021tag "v0.21.0+84236bf0f0c832f6619b8f99ce7bc878c7800ef0"
[ -d BLAKE3-pin ] || git -C BLAKE3 worktree add -q --detach ../BLAKE3-pin $C
B=$HOME/work/bench-021tag; F=$HOME/work/BLAKE3-pin
cd $B; echo "== bench $(git log --oneline -1 | cut -c1-50); governor $(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor) $(date -u +%H:%M)"
cargo build --release 2>&1 | tail -1
EXE=$(./target/release/bench-hashes build-against $F 2> $O/build-against.stderr.txt | tail -1); echo "built: $EXE"
git checkout -q -- Cargo.lock 2>/dev/null
rm -rf $O/full; mkdir -p $O/full; cd $O/full
s=$(date +%s); $EXE --all --expect-servil $C > report.txt 2> stderr.txt; echo "== full exit $? in $(( $(date +%s) - s )) s $(date -u +%H:%M)"
rm -rf $O/crowd; mkdir -p $O/crowd; cd $O/crowd
s=$(date +%s); $EXE crowd > report.txt 2> stderr.txt; echo "== crowd exit $? in $(( $(date +%s) - s )) s $(date -u +%H:%M)"
cd $B
LAYOUTS=4 python3 tools/b3sum-contenders.py $F $HOME/b3c-pin > $O/b3sum-contenders.txt 2> $O/b3sum-contenders.stderr.txt; echo "== contenders exit $?"
rm -rf $O/b3sum; mkdir -p $O/b3sum $HOME/b3sum-files
s=$(date +%s); tr '\n' '\0' < $O/b3sum-contenders.txt | (cd $O/b3sum && xargs -0 $EXE b3sum --files $HOME/b3sum-files > report.txt 2> stderr.txt); echo "== b3sum exit $? in $(( $(date +%s) - s )) s $(date -u +%H:%M)"
s=$(date +%s); ./target/release/bench-hashes check --fork $M --new $C --against b5b988d8 --old-bench 3363bee8 --points "continuous 1 MiB,continuous 4 MiB,continuous 16 MiB" --when-quiet --keep $O/check-long > $O/check-long.stdout.txt 2> $O/check-long.stderr.txt; echo "== release check, long stream cells exit $? in $(( $(date +%s) - s )) s $(date -u +%H:%M)"
s=$(date +%s); ./target/release/bench-hashes check --fork $M --new $C --against b5b988d8 --old-bench 3363bee8 --cells all --when-quiet --keep $O/check > $O/check.stdout.txt 2> $O/check.stderr.txt; echo "== release check, every cell exit $? in $(( $(date +%s) - s )) s $(date -u +%H:%M)"
s=$(date +%s); ./target/release/bench-hashes check --fork $M --new $C --against $C --old-bench 148827f3 --cells all --when-quiet --keep $O/check-same > $O/check-same.stdout.txt 2> $O/check-same.stderr.txt; echo "== same-library check exit $? in $(( $(date +%s) - s )) s $(date -u +%H:%M)"
echo "== done $(date -u +%H:%M)"
