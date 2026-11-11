#!/bin/sh
# BLAKE3 #368: the bisect named 3ab4584a. That commit against its parent 9f7caef3, one bench (f24b6f4d) on both sides, 16 pairs.
export PATH=$HOME/.cargo/bin:$PATH
cd $HOME/work/bench-f24b && cargo build --release 2>&1 | tail -1
./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new 3ab4584a --against 9f7caef3 --points "continuous 1 MiB" --layouts 16 --when-quiet --keep $HOME/runs/bisect-368/kept-confirm
echo "check exit $?"
