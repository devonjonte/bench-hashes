#!/bin/sh
# check with the link reuse and evidence ranking, ported onto bench 0.19
# (candidate/devon-check-links-019 on 015a4d3d; clocks with Judgment::rank).
# Known truth: d09708f90857758308399a92234b13faab1158db (servil 057d1eec + rank, #210 reverted) against
# 080d250f939e2f11b69ff2f7bc0d075e5d26c9e9 (servil + rank), x3; then A/A x2.
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp BENCH_CLOCKS_CHECKOUT=/home/agent/BLAKE3-rank019/clocks; unset RUSTFLAGS
O=/home/agent/bench-hashes-validation/links-019-i7
FIX=080d250f939e2f11b69ff2f7bc0d075e5d26c9e9
cd /home/agent/bench-links019
run() { name=$1; shift; echo "== $name $(date -u +%H:%M:%S)"; s=$(date +%s); cargo run -q --release -- check "$@" --keep $O/$name > $O/$name.stdout.txt 2> $O/$name.stderr.txt; echo "$name exit $? in $(( $(date +%s) - s )) s"; }
for i in 1 2 3; do run known-$i --fork /home/agent/BLAKE3-r019-119 --against $FIX; done
for i in 1 2; do run aa-$i --fork /home/agent/BLAKE3-r019-aa --against $FIX --cells all; done
