#!/bin/sh
# BLAKE3 #357 step 3, the core's gate, PINNED (bench next 77d4a7650c1bf97f0e05954089af6ccda743e3ed): the single-threaded contender on next (c10d6804,
# the two crates) against 0.8 (b5b988d8 under its own bench 3363bee8), every cell, both stages.
set -eu
export PATH=$HOME/.cargo/bin:$PATH
O=$HOME/runs/core-gate-pinned
mkdir -p $HOME/work && cd $HOME/work
[ -d bench-hashes ] || git clone -q https://github.com/servil-software-factory/bench-hashes.git
[ -d BLAKE3 ] || git clone -q https://github.com/servil-software-factory/BLAKE3.git
git -C BLAKE3 fetch -q origin
cd bench-hashes && git fetch -q origin && git checkout -q --detach 77d4a7650c1bf97f0e05954089af6ccda743e3ed; test "$(git rev-parse HEAD)" = 77d4a7650c1bf97f0e05954089af6ccda743e3ed
cargo build --release 2>&1 | tail -1
set +e
./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new c10d6804f246767a79025332704f9843b3d96351 --against b5b988d8 --old-bench 3363bee8 --contenders blake3-servil-st --cells all --when-quiet --keep $O/kept
echo "check exit $? $(date -u +%H:%M)"
