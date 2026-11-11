#!/bin/sh
# The 0.9-shaped tree (trial/two-crates-squashed) against next, every cell, on the x86-avx2 machine (2 x EPYC 7443).
set -u
export PATH=$HOME/.cargo/bin:$PATH
cd $HOME/work/bench-hashes
cargo build --release 2>&1 | tail -1
./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new origin/trial/two-crates-squashed --against origin/next --cells all --when-quiet --keep $HOME/runs/two-crates-all/kept
echo "check exit $?"
