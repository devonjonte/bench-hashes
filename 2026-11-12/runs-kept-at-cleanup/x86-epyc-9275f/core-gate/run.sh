#!/bin/sh
# BLAKE3 #357 step 3, the core's gate: blake3-servil-core's calls (the single-threaded contender) on next
# (c10d6804) against 0.8 (b5b988d8, under its own bench 3363bee8), every cell, both stages. Bench next cb9dc38421279268b20fb91109fba6c7f33af783.
set -eu
export PATH=$HOME/.cargo/bin:$PATH
O=$HOME/runs/core-gate; mkdir -p $O
git -C $HOME/work/BLAKE3 fetch -q origin
cd $HOME/work/bench-hashes && git fetch -q origin && git checkout -q --detach cb9dc38421279268b20fb91109fba6c7f33af783
test "$(git rev-parse HEAD)" = cb9dc38421279268b20fb91109fba6c7f33af783
cargo build --release 2>&1 | tail -1
set +e
./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new c10d6804f246767a79025332704f9843b3d96351 --against b5b988d8 --old-bench 3363bee8 --contenders blake3-servil-st --cells all --when-quiet --keep $O/kept
echo "check exit $? $(date -u +%H:%M)"
