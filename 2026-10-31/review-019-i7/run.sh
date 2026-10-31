#!/bin/sh
# bench-hashes 0.19 candidate 99eefde3, the review's runs (i7-12700K).
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp; unset RUSTFLAGS
O=/home/agent/bench-hashes-validation/review-019-i7
cd /home/agent/bench-019
run() { name=$1; shift; echo "== $name $(date -u +%H:%M:%S)"; s=$(date +%s); cargo run -q --release -- check "$@" --keep $O/$name > $O/$name.stdout.txt 2> $O/$name.stderr.txt; echo "$name exit $? in $(( $(date +%s) - s )) s"; }
run aa --fork /home/agent/BLAKE3-r019-aa --against b5b988d8982bea9490c38c79ec4b8c5c2428270c --cells all
run spin0 --fork /home/agent/BLAKE3-r019-spin0 --against b5b988d8982bea9490c38c79ec4b8c5c2428270c
run hash6 --fork /home/agent/BLAKE3-r019-hash6 --against b5b988d8982bea9490c38c79ec4b8c5c2428270c
run known119-1 --fork /home/agent/BLAKE3-r019-119 --against a88ba52a
run known119-2 --fork /home/agent/BLAKE3-r019-119 --against a88ba52a
