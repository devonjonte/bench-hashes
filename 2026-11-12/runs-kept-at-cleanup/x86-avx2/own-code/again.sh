#!/bin/sh
# The candidate against bench next, one library: the one cell the every-cell check flagged (single-threaded 2 KiB
# after a pause, +10.8% over 64 pairs), by name with its neighbours; then #297 under the candidate (BLAKE3 #372).
export PATH=$HOME/.cargo/bin:$PATH
cd $HOME/work/bench-own-code
./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new e9da0a1e --against e9da0a1e --old-bench fbd1c8de --points "idle 2 KiB,idle 1 KiB,idle 4 KiB" --when-quiet --keep $HOME/runs/own-code/kept-idle
echo "check exit $? $(date -u +%H:%M)"
./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new 40b38526 --against 3313686b --points "merkle 1048576 x 32 B,merkle 65536 x 32 B,merkle 1048576 x 16 B" --when-quiet --keep $HOME/runs/trees-297-own/kept
echo "check exit $? $(date -u +%H:%M)"
