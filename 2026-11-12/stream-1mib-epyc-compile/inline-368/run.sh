#!/bin/sh
# BLAKE3 #368, after the pinned pair read level (take_task and run_task never inlined on both sides): which
# way is the fast one, and does forcing it give the removal its speed back? Bench 4fcff35f, "continuous 1 MiB".
export PATH=$HOME/.cargo/bin:$PATH
O=$HOME/runs/inline-368; mkdir -p $O; cd $HOME/work/bench-4fcff35f
git -C $HOME/work/BLAKE3 fetch -q devon exp/devon-368-r1-inlined exp/devon-368-base-pinned
echo "== 1: the base with the two never inlined (83959074fb4f516c0fe2a536d324f20ca70aff75) against the base as it is (0a23cb70)"
./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new 83959074fb4f516c0fe2a536d324f20ca70aff75 --against 0a23cb70 --points "continuous 1 MiB" --when-quiet --keep $O/kept-1
echo "check exit $? $(date -u +%H:%M)"
echo "== 2: the removal's first half with the two always inlined (0febba2d7d3fe4cd9e55798727b3fc084f3de1e1) against the base as it is"
./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new 0febba2d7d3fe4cd9e55798727b3fc084f3de1e1 --against 0a23cb70 --points "continuous 1 MiB" --when-quiet --keep $O/kept-2
echo "check exit $? $(date -u +%H:%M)"
echo "== 3: the removal's first half as it is (0c131a08) against the base as it is, again"
./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new 0c131a084cb8e9e567439ae6c133d8c59d3651db --against 0a23cb70 --points "continuous 1 MiB" --when-quiet --keep $O/kept-3
echo "check exit $? $(date -u +%H:%M)"
echo "== done"
