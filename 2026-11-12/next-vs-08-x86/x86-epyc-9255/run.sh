#!/bin/sh
# BLAKE3 #357 step 3: the two-crate library on next (c10d6804) against 0.8 (b5b988d8, under its own bench
# 3363bee8), every cell, bench next 774a6b63 (its pin is c10d6804).
set -eu
export PATH=$HOME/.cargo/bin:$PATH
O=$HOME/runs/next-vs-08; mkdir -p $O
git -C $HOME/work/BLAKE3 fetch -q origin
cd $HOME/work/bench-hashes && git fetch -q origin && git checkout -q --detach 774a6b63d5b3b6781754d4e1f65c89e44ba2273b
test "$(git rev-parse HEAD)" = 774a6b63d5b3b6781754d4e1f65c89e44ba2273b
cargo build --release 2>&1 | tail -1
set +e
./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new c10d6804f246767a79025332704f9843b3d96351 --against b5b988d8 --old-bench 3363bee8 --cells all --when-quiet --keep $O/kept
echo "check exit $? $(date -u +%H:%M)"
