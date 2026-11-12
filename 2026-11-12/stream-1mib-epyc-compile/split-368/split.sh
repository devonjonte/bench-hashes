#!/bin/sh
# BLAKE3 #368: the removal (b6377425 against 0a23cb70: 13.5% slower two caches, 7.6% alone) in two halves.
# R1 = the removal with lanes.rs left as it was (exp/devon-368-r1). Bench 4fcff35f, "continuous 1 MiB", the default four layouts and the second stage.
export PATH=$HOME/.cargo/bin:$PATH
O=$HOME/runs/split-368; mkdir -p $O; cd $HOME/work/bench-4fcff35f
git -C $HOME/work/BLAKE3 fetch -q devon exp/devon-368-r1
echo "== 1: R1 against 0a23cb70 (everything but lanes.rs)"
./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new 0c131a084cb8e9e567439ae6c133d8c59d3651db --against 0a23cb70 --points "continuous 1 MiB" --when-quiet --keep $O/kept-1
echo "check exit $? $(date -u +%H:%M)"
echo "== 2: b6377425 against R1 (lanes.rs alone)"
./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new b6377425 --against 0c131a084cb8e9e567439ae6c133d8c59d3651db --points "continuous 1 MiB" --when-quiet --keep $O/kept-2
echo "check exit $? $(date -u +%H:%M)"
echo "== done"
