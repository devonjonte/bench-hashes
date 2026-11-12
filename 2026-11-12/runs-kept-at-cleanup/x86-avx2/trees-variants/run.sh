#!/bin/sh
# BLAKE3 #372: #297 (40b38526) against its parent (3313686b), the trees by name. Under the bench's own
# compilation this machine read the multithreaded tree of 1048576 x 32 B 6.4% and 4.9% slower (64 pairs).
# 1. bench 4fcff35f with each layout its own inliner threshold (scratch/devon-compile-variants).
# 2. bench 4fcff35f as it is, both sides under thin LTO and 16 codegen units.
set -eu
export PATH=$HOME/.cargo/bin:$PATH
O=$HOME/runs/trees-variants; mkdir -p $O
P="merkle 1048576 x 32 B,merkle 65536 x 32 B,merkle 1048576 x 16 B"
cd $HOME/work/bench-variants; test -x ./target/release/bench-hashes
set +e
echo "== 1: thresholds in turn"
./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new 40b38526 --against 3313686b --points "$P" --when-quiet --keep $O/kept-thresholds
echo "check exit $? $(date -u +%H:%M)"
cd $HOME/work/bench-4fcff35f
echo "== 2: thin LTO, 16 codegen units"
CARGO_PROFILE_RELEASE_LTO=thin CARGO_PROFILE_RELEASE_CODEGEN_UNITS=16 ./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new 40b38526 --against 3313686b --points "$P" --when-quiet --keep $O/kept-thin
echo "check exit $? $(date -u +%H:%M)"
echo "== 3: the bench's own compilation, again"
./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new 40b38526 --against 3313686b --points "$P" --when-quiet --keep $O/kept-own
echo "check exit $? $(date -u +%H:%M)"
