#!/bin/sh
# BLAKE3 #368: is the 1 MiB shared slowdown the library's or the bench's? Two checks with one new side (the pin
# under the 0.21 bench) and old sides of the same library code under two benches: 27717b3f under bench 3363bee8,
# and 86b11263 (27717b3f with the calls renamed, nothing else) under bench 8a153ce2. 64 pairs each.
export PATH=$HOME/.cargo/bin:$PATH
cd $HOME/work/bench-021tag
P=2037118ca1da85710aef55d7f13b3abd9095b485
echo "== 1: the pin against 27717b3f under bench 3363bee8"
./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new $P --against 27717b3f --old-bench 3363bee8 --points "continuous 1 MiB" --layouts 64 --when-quiet --keep $HOME/runs/bisect-368/kept-two-1
echo "check exit $?"
echo "== 2: the pin against 86b11263 under bench 8a153ce2"
./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new $P --against 86b11263 --old-bench 8a153ce2 --points "continuous 1 MiB" --layouts 64 --when-quiet --keep $HOME/runs/bisect-368/kept-two-2
echo "check exit $?"
echo "== done"
