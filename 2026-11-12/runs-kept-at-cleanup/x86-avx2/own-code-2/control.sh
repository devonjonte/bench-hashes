#!/bin/sh
# bench #191's one slower cell on this machine (the multithreaded tree of 16384 leaves, two programs on two
# caches: +20.6% and +13.2% against the bench before it, 64 pairs each). The control: under the candidate bench
# on both sides, the library against itself plus one inert instruction in Hasher::new, which no tree cell calls.
# If this reads the cell moved too, the cell moves with any recompilation on this machine.
set -eu
export PATH=$HOME/.cargo/bin:$PATH
O=$HOME/runs/own-code-2; cd $HOME/work/BLAKE3 && git fetch -q devon scratch/devon-aa-next
cd $HOME/work/bench-own-code; test -x ./target/release/bench-hashes
set +e
./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new d9c2c209b9155f21ee69710907a6ae4e5a8af5a8 --against e9da0a1e --points "merkle 16384,merkle 4096,continuous 64 B" --when-quiet --keep $O/kept-control
echo "check exit $? $(date -u +%H:%M)"
./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new e9da0a1e --against d9c2c209b9155f21ee69710907a6ae4e5a8af5a8 --points "merkle 16384,merkle 4096,continuous 64 B" --when-quiet --keep $O/kept-control-2
echo "check exit $? $(date -u +%H:%M)"
