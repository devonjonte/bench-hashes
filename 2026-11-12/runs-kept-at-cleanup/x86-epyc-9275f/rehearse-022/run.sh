#!/bin/sh
# A rehearsal of bench-hashes 0.22 on this machine: bench next 774a6b63 (pin BLAKE3-Servil c10d6804, the two
# crates): the full run, crowd, b3sum, and the same-library check against bench 0.21 (the library both benches
# build: 0.21's pin 2037118c). The release check against 0.8 is ~/runs/next-vs-08.
set -u
export PATH=$HOME/.cargo/bin:$PATH
O=$HOME/runs/rehearse-022; C=c10d6804f246767a79025332704f9843b3d96351; M=$HOME/work/BLAKE3
B=$HOME/work/bench-hashes
cd $HOME/work; [ -d BLAKE3-next ] || git -C BLAKE3 worktree add -q --detach ../BLAKE3-next $C
git -C BLAKE3-next checkout -q --detach $C; F=$HOME/work/BLAKE3-next
cd $B && git checkout -q --detach 774a6b63d5b3b6781754d4e1f65c89e44ba2273b && cargo build --release 2>&1 | tail -1
echo "== bench $(git log --oneline -1 | cut -c1-50) $(date -u +%H:%M)"
EXE=$(./target/release/bench-hashes build-against $F 2> $O/build-against.stderr.txt | tail -1); echo "built: $EXE"
git checkout -q -- Cargo.lock 2>/dev/null
rm -rf $O/full; mkdir -p $O/full; cd $O/full
s=$(date +%s); $EXE --all --expect-servil $C > report.txt 2> stderr.txt; echo "== full exit $? in $(( $(date +%s) - s )) s $(date -u +%H:%M)"
rm -rf $O/crowd; mkdir -p $O/crowd; cd $O/crowd
s=$(date +%s); $EXE crowd > report.txt 2> stderr.txt; echo "== crowd exit $? in $(( $(date +%s) - s )) s $(date -u +%H:%M)"
cd $B
LAYOUTS=4 python3 tools/b3sum-contenders.py $F $HOME/b3c-next > $O/b3sum-contenders.txt 2> $O/b3sum-contenders.stderr.txt; echo "== contenders exit $?"
rm -rf $O/b3sum; mkdir -p $O/b3sum $HOME/b3sum-files
s=$(date +%s); tr '\n' '\0' < $O/b3sum-contenders.txt | (cd $O/b3sum && xargs -0 $EXE b3sum --files $HOME/b3sum-files > report.txt 2> stderr.txt); echo "== b3sum exit $? in $(( $(date +%s) - s )) s $(date -u +%H:%M)"
s=$(date +%s); ./target/release/bench-hashes check --fork $M --new 2037118ca1da85710aef55d7f13b3abd9095b485 --against 2037118ca1da85710aef55d7f13b3abd9095b485 --old-bench 9434d50e --cells all --when-quiet --keep $O/check-same > $O/check-same.stdout.txt 2> $O/check-same.stderr.txt; echo "== same-library check exit $? in $(( $(date +%s) - s )) s $(date -u +%H:%M)"
echo "== done $(date -u +%H:%M)"
