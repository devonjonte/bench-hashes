#!/bin/sh
# Deletion trial (BLAKE3 #234, Zooko's refined plan): the caller parks at once (no SPIN_BEFORE_SLEEP/YIELD_EVERY polling) against the scheduling branch, every cell, bench 0.20.4.
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp; unset RUSTFLAGS
O=/home/agent/bench-hashes-validation/nopoll-i7
cd /home/agent/bench-020tag
s=$(date +%s); cargo run -q --release -- check --fork /home/agent/BLAKE3-m3 --against 0d6fc148bfe0c635505318227b282f3de239e280 --cells all --keep $O/check > $O/check.stdout.txt 2> $O/check.stderr.txt; echo "== check exit $? in $(( $(date +%s) - s )) s"
