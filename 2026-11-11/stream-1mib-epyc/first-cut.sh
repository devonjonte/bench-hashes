#!/bin/sh
# BLAKE3 #368, the first cut: the shared stream cells, 64 pairs each.
# (a) 0.8 against the last commit with its API (27717b3f), bench 3363bee8 on both sides.
# (b) 27717b3f against the pin 2037118c, the old side by bench 3363bee8, the new by the 0.21 tag.
set -u
export PATH=$HOME/.cargo/bin:$PATH
O=$HOME/runs/bisect-368; M=$HOME/work/BLAKE3; P="continuous 1 MiB,continuous 4 MiB"
cd $HOME/work/bench-3363 && cargo build --release 2>&1 | tail -1
echo "== a: 27717b3f against 0.8"
./target/release/bench-hashes check --fork $M --new 27717b3f --against b5b988d8 --points "$P" --layouts 16 --when-quiet --keep $O/kept-a
echo "check exit $?"
cd $HOME/work/bench-021tag
echo "== b: 2037118c against 27717b3f"
./target/release/bench-hashes check --fork $M --new 2037118ca1da85710aef55d7f13b3abd9095b485 --against 27717b3f --old-bench 3363bee8 --points "$P" --layouts 16 --when-quiet --keep $O/kept-b
echo "check exit $?"
