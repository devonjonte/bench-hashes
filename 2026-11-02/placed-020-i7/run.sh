#!/bin/sh
# bench 0.20 candidate (a40c26db, shared copies placed on CPUs 0 and 2): A/A of every cell, the fork at 0.8.
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp; unset RUSTFLAGS
O=/home/agent/bench-hashes-validation/placed-020-i7
cd /home/agent/bench-mtshared
s=$(date +%s); cargo run -q --release -- check --fork /home/agent/BLAKE3-rel019 --against b5b988d8982bea9490c38c79ec4b8c5c2428270c --cells all --keep $O/aa > $O/aa.stdout.txt 2> $O/aa.stderr.txt; echo "aa exit $? in $(( $(date +%s) - s )) s"
