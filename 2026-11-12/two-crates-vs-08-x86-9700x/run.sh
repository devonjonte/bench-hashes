#!/bin/sh
# BLAKE3 #357 step 3, a preview: the two-crate tree (candidate/split-release-tools, 5c0247cd) against 0.8
# (b5b988d8, its bench 3363bee8), every cell, bench next.
export PATH=$HOME/.cargo/bin:$PATH
O=$HOME/runs/core-vs-08; mkdir -p $O
git -C $HOME/work/BLAKE3 fetch -q origin
cd $HOME/work/bench-hashes && git fetch -q origin && git checkout -q --detach origin/next && cargo build --release 2>&1 | tail -1
git log --oneline -1 | cut -c1-60
./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new 5c0247cde0ff0e56e2f9937416766a5d15c84901 --against b5b988d8 --old-bench 3363bee8 --cells all --when-quiet --keep $O/kept
echo "check exit $? $(date -u +%H:%M)"
