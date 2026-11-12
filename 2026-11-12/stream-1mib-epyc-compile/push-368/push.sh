#!/bin/sh
# BLAKE3 #368: the bisect named 6fc30a3d, which split the stream's publish into push(task: Task), a 1,656-byte
# task passed by value through a call with two callers. The test: 6fc30a3d with push inlined (exp/devon-368-push-inline)
# against 3ab4584a (its parent on the list, level), and against 6fc30a3d. Bench f24b6f4d, the default four layouts and the second stage.
export PATH=$HOME/.cargo/bin:$PATH
O=$HOME/runs/push-368; mkdir -p $O; cd $HOME/work/bench-f24b6f4d
git -C $HOME/work/BLAKE3 fetch -q devon exp/devon-368-push-inline
echo "== 1: push inlined, against 6fc30a3d as landed"
./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new a5ccdf1fc8b187dad6249fa508b00c0309bf9ab3 --against 6fc30a3d --points "continuous 1 MiB" --when-quiet --keep $O/kept-1
echo "check exit $? $(date -u +%H:%M)"
echo "== 2: push inlined, against 6fc30a3d's parent"
./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new a5ccdf1fc8b187dad6249fa508b00c0309bf9ab3 --against 6fc30a3d^ --points "continuous 1 MiB" --when-quiet --keep $O/kept-2
echo "check exit $? $(date -u +%H:%M)"
echo "== done"
