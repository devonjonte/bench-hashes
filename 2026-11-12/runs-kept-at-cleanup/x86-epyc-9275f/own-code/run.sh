#!/bin/sh
# bench-hashes candidate "every cell's timed code in a function of its own" (1a3e4fafd62f3cc24975632b5abbba3a15ba0fff) against bench next
# (fbd1c8de), the same library on both sides (BLAKE3 next e9da0a1e), every cell: what the change moves.
export PATH=$HOME/.cargo/bin:$PATH
O=$HOME/runs/own-code; mkdir -p $O
git -C $HOME/work/BLAKE3 fetch -q origin
cd $HOME/work/bench-hashes && (git remote | grep -q devon || git remote add devon https://github.com/devonjonte/bench-hashes.git); git fetch -q origin; git fetch -q devon candidate/devon-cell-own-code
[ -d $HOME/work/bench-own-code ] || git worktree add -q --detach $HOME/work/bench-own-code 1a3e4fafd62f3cc24975632b5abbba3a15ba0fff
cd $HOME/work/bench-own-code && git checkout -q --detach 1a3e4fafd62f3cc24975632b5abbba3a15ba0fff && cargo build --release 2>&1 | tail -1
./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new e9da0a1e --against e9da0a1e --old-bench fbd1c8de --cells all --when-quiet --keep $O/kept
echo "check exit $? $(date -u +%H:%M)"
