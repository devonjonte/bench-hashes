#!/bin/sh
# 1. BLAKE3 #297 (packed leaves in whole groups, f2902fb2) against next (3313686b), every cell, bench next.
# 2. bench-hashes 0.21's b3sum run at the tag (the machine's release set lacked it).
# 3. The segments of BLAKE3 #368.
set -u
export PATH=$HOME/.cargo/bin:$PATH
cd $HOME/work/BLAKE3 && (git remote | grep -q devon || git remote add devon https://github.com/devonjonte/BLAKE3.git); git fetch -q origin; git fetch -q devon candidate/devon-packed-lanes
cd $HOME/work/bench-hashes && git fetch -q origin && git checkout -q --detach origin/next && cargo build --release 2>&1 | tail -1
git log --oneline -1 | cut -c1-60
./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new f2902fb2 --against 3313686b --cells all --when-quiet --keep $HOME/runs/gate-297/kept
echo "check exit $? $(date -u +%H:%M)"
O=$HOME/runs/release-021; EXE=$HOME/work/BLAKE3-pin/target/bench-hashes-build/release/bench-9434d50e50de-clean_servil-2037118ca1da-clean/bench-hashes
cd $HOME/work/bench-021tag
LAYOUTS=4 python3 tools/b3sum-contenders.py $HOME/work/BLAKE3-pin $HOME/b3c-pin > $O/b3sum-contenders.txt 2> $O/b3sum-contenders.stderr.txt; echo "contenders exit $?"
rm -rf $O/b3sum; mkdir -p $O/b3sum $HOME/b3sum-files
tr '\n' '\0' < $O/b3sum-contenders.txt | (cd $O/b3sum && xargs -0 $EXE b3sum --files $HOME/b3sum-files > report.txt 2> stderr.txt); echo "b3sum exit $? $(date -u +%H:%M)"
cd $HOME/runs/segments-368 && python3 segments.py > out.txt 2> err.txt
echo "segments done $(date -u +%H:%M)"
