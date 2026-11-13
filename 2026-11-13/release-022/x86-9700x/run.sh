#!/bin/sh
# bench-hashes 0.22 on this machine: bench v0.22.0+d7723f110a6f519cccb2e4ab8f2a18be7a4f4d41 (pin BLAKE3-Servil 0.9.0, bf2da8b9): the full run, crowd,
# b3sum, the core check against 0.8 and the same-library check against 0.21's bench. CONTRIBUTING "Releases", step 4.
set -u
export PATH=$HOME/.cargo/bin:$PATH
O=$HOME/runs/release-022; C=bf2da8b957f5e0c80babb57952de3e53f95c921a; BREV=v0.22.0+d7723f110a6f519cccb2e4ab8f2a18be7a4f4d41; M=$HOME/work/BLAKE3
cd $HOME/work
git -C BLAKE3 fetch -q --all --tags; git -C bench-hashes fetch -q --all --tags
[ -d bench-022 ] || git -C bench-hashes worktree add -q --detach ../bench-022 $BREV
[ -d BLAKE3-090 ] || git -C BLAKE3 worktree add -q --detach ../BLAKE3-090 $C
B=$HOME/work/bench-022; F=$HOME/work/BLAKE3-090
git -C $B checkout -q --detach $BREV; test "$(git -C $B rev-parse HEAD)" = "$(git -C $B rev-parse "$BREV^{commit}")" || { echo "bench checkout differs"; exit 1; }
test "$(git -C $F rev-parse HEAD)" = $C || { echo "library checkout differs"; exit 1; }
cd $B; echo "== bench $(git log --oneline -1 | cut -c1-60); library $(git -C $F rev-parse --short=8 HEAD); governor $(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor) $(date -u +%H:%M)"
cargo build --release 2>&1 | tail -1
EXE=$(./target/release/bench-hashes build-against $F 2> $O/build-against.stderr.txt | tail -1); echo "built: $EXE"
git checkout -q -- Cargo.lock 2>/dev/null
rm -rf $O/full; mkdir -p $O/full; cd $O/full
s=$(date +%s); $EXE --all --expect-servil $C > report.txt 2> stderr.txt; echo "== full exit $? in $(( $(date +%s) - s )) s $(date -u +%H:%M)"
rm -rf $O/crowd; mkdir -p $O/crowd; cd $O/crowd
s=$(date +%s); $EXE crowd > report.txt 2> stderr.txt; echo "== crowd exit $? in $(( $(date +%s) - s )) s $(date -u +%H:%M)"
cd $B
LAYOUTS=4 python3 tools/b3sum-contenders.py $F $HOME/b3c-090 > $O/b3sum-contenders.txt 2> $O/b3sum-contenders.stderr.txt; echo "== contenders exit $?"
rm -rf $O/b3sum; mkdir -p $O/b3sum $HOME/b3sum-files
s=$(date +%s); tr '\n' '\0' < $O/b3sum-contenders.txt | (cd $O/b3sum && xargs -0 $EXE b3sum --files $HOME/b3sum-files > report.txt 2> stderr.txt); echo "== b3sum exit $? in $(( $(date +%s) - s )) s $(date -u +%H:%M)"
s=$(date +%s); ./target/release/bench-hashes check --fork $M --new $C --against b5b988d8 --old-bench 3363bee8 --contenders blake3-servil-st --cells all --when-quiet --keep $O/kept-core > $O/check-core.stdout.txt 2> $O/check-core.stderr.txt; echo "== release check: the core (single-threaded) against 0.8, every cell: exit $? in $(( $(date +%s) - s )) s $(date -u +%H:%M)"
s=$(date +%s); ./target/release/bench-hashes check --fork $M --new 2037118ca1da85710aef55d7f13b3abd9095b485 --against 2037118ca1da85710aef55d7f13b3abd9095b485 --old-bench 9434d50e --contenders blake3-servil-st --cells all --when-quiet --keep $O/kept-same > $O/check-same.stdout.txt 2> $O/check-same.stderr.txt; echo "== same-library check (library 2037118c on both sides; this bench against 0.21's): exit $? in $(( $(date +%s) - s )) s $(date -u +%H:%M)"

echo "== done $(date -u +%H:%M)"
