#!/bin/sh
# BLAKE3 #368: the removal's first half (R1 0c131a08 against 0a23cb70) under a bench whose stream loop is a
# function of its own, never inlined (my fork, scratch/devon-368-stream-own-fn e6ba47fd). If the cells read
# level here where they moved under bench 4fcff35f, the bench's shared function carried the effect.
export PATH=$HOME/.cargo/bin:$PATH
O=$HOME/runs/ownfn-368; mkdir -p $O
cd $HOME/work/bench-hashes && (git remote | grep -q devon || git remote add devon https://github.com/devonjonte/bench-hashes.git); git fetch -q devon scratch/devon-368-stream-own-fn
[ -d $HOME/work/bench-ownfn ] || git worktree add -q --detach $HOME/work/bench-ownfn e6ba47fd9368306bab1d5a7a972128819a89394d
cd $HOME/work/bench-ownfn && cargo build --release 2>&1 | tail -1
./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new 0c131a084cb8e9e567439ae6c133d8c59d3651db --against 0a23cb70 --points "continuous 1 MiB" --when-quiet --keep $O/kept
echo "check exit $? $(date -u +%H:%M)"
