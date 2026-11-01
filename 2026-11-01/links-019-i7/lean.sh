#!/bin/sh
# The lean port: suspects by evidence and the 64-pair second stage, the
# first stage at 4 pairs (FIRST_RUNS 1). Known truths: spin0 x2, #119 x2.
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp BENCH_CLOCKS_CHECKOUT=/home/agent/BLAKE3-rank019/clocks; unset RUSTFLAGS
O=/home/agent/bench-hashes-validation/links-019-i7
FIX=080d250f939e2f11b69ff2f7bc0d075e5d26c9e9
cd /home/agent/bench-links019
run() { name=$1; shift; echo "== $name $(date -u +%H:%M:%S)"; s=$(date +%s); cargo run -q --release -- check "$@" --keep $O/$name > $O/$name.stdout.txt 2> $O/$name.stderr.txt; echo "$name exit $? in $(( $(date +%s) - s )) s"; }
for i in 1 2; do run lean-spin0-$i --fork /home/agent/BLAKE3-r019-spin0 --against $FIX; done
for i in 1 2; do run lean-known-$i --fork /home/agent/BLAKE3-r019-119 --against $FIX; done
