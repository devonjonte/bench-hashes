#!/bin/sh
# BLAKE3 #372: #297 (40b38526) against its parent (3313686b), the trees by name, under the bench candidate
# whose every cell is a function of its own (1a3e4faf). Under bench next this machine read the multithreaded
# tree of 1048576 x 32 B 6.4% slower (64 pairs).
export PATH=$HOME/.cargo/bin:$PATH
O=$HOME/runs/trees-297-own; mkdir -p $O; cd $HOME/work/bench-own-code
./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new 40b38526 --against 3313686b --points "merkle 1048576 x 32 B,merkle 65536 x 32 B,merkle 1048576 x 16 B" --when-quiet --keep $O/kept
echo "check exit $? $(date -u +%H:%M)"
