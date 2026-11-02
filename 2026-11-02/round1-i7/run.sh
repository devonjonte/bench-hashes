#!/bin/sh
# Round 1: current servil (057d1eec) against the 0.8 release (b5b988d8), every cell, bench 0.19.5 (dd6478f1), i7.
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp; unset RUSTFLAGS
O=/home/agent/bench-hashes-validation/round1-i7
cd /home/agent/bench-0194
s=$(date +%s); cargo run -q --release -- check --fork /home/agent/BLAKE3-head --against b5b988d8982bea9490c38c79ec4b8c5c2428270c --cells all --keep $O/check > $O/check.stdout.txt 2> $O/check.stderr.txt; echo "check exit $? in $(( $(date +%s) - s )) s"
