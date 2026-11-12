#!/bin/sh
# A probe: bench 4fcff35f with one change to check (my fork, scratch/devon-compile-variants c40fc128f5a1c3156320c4639276450a94e0c89a): each layout
# is built with its own inliner threshold (225, 150, 325, 100, 275, 400, 190, 500 in turn), the same for the
# two sides of a pair. Then a verdict averages over compilations as it does over link orders.
# 1. BLAKE3 #368's removal against its base (read 7.6 to 15% slower alone, six times, under one compilation).
# 2. A control that must stay slower: the 8 MiB long ring (2037118c^) against the 2 MiB one (2037118c), 4 MiB stream
#    (BLAKE3 #349: 23 to 28% on the i7; here 2037118c read 13 to 14% faster than its predecessors).
set -eu
export PATH=$HOME/.cargo/bin:$PATH
O=$HOME/runs/compile-variants; mkdir -p $O
cd $HOME/work/bench-hashes; git remote | grep -q devon || git remote add devon https://github.com/devonjonte/bench-hashes.git
git fetch -q devon scratch/devon-compile-variants; test "$(git rev-parse FETCH_HEAD)" = c40fc128f5a1c3156320c4639276450a94e0c89a
[ -d $HOME/work/bench-variants ] || git worktree add -q --detach $HOME/work/bench-variants c40fc128f5a1c3156320c4639276450a94e0c89a
cd $HOME/work/bench-variants && git checkout -q --detach c40fc128f5a1c3156320c4639276450a94e0c89a && cargo build --release 2>&1 | tail -1
set +e
echo "== 1: the removal against its base, 1 MiB stream"
./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new b6377425 --against 0a23cb70 --points "continuous 1 MiB" --when-quiet --keep $O/kept-removal
echo "check exit $? $(date -u +%H:%M)"
echo "== 2: a change that must stay slower: 2037118c's parent (the 8 MiB long ring) against 2037118c (2 MiB), 4 MiB stream"
./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new 2037118c^ --against 2037118c --points "continuous 4 MiB" --when-quiet --keep $O/kept-ring
echo "check exit $? $(date -u +%H:%M)"
echo "== done"
