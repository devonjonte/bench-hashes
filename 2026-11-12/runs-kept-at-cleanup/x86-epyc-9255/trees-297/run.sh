#!/bin/sh
# BLAKE3 #297 (packed leaves in whole groups, 40b38526) against its parent 3313686b on this machine: the trees
# and two batch points by name, the default layouts and the second stage. For #372 and the changelog's figures.
export PATH=$HOME/.cargo/bin:$PATH
O=$HOME/runs/trees-297; mkdir -p $O
git -C $HOME/work/BLAKE3 fetch -q origin
cd $HOME/work/bench-hashes && git fetch -q origin && git checkout -q --detach origin/next && cargo build --release 2>&1 | tail -1
git log --oneline -1 | cut -c1-60
./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new 40b38526 --against 3313686b --points "merkle 1048576 x 32 B,merkle 65536 x 32 B,merkle 1048576 x 16 B,continuous batch 16,continuous batch 1024" --when-quiet --keep $O/kept
echo "check exit $? $(date -u +%H:%M)"
