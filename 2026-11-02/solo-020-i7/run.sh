#!/bin/sh
# bench 0.20 candidate (2259e1f8): A/A check of every cell, the fork at 0.8; then the same-library check against 0.19.6 (v7 bridge).
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp; unset RUSTFLAGS
O=/home/agent/bench-hashes-validation/solo-020-i7
cd /home/agent/bench-solo
s=$(date +%s); cargo run -q --release -- check --fork /home/agent/BLAKE3-rel019 --against b5b988d8982bea9490c38c79ec4b8c5c2428270c --cells all --keep $O/aa > $O/aa.stdout.txt 2> $O/aa.stderr.txt; echo "aa exit $? in $(( $(date +%s) - s )) s"
s=$(date +%s); cargo run -q --release -- check --fork /home/agent/BLAKE3-rel019 --against b5b988d8982bea9490c38c79ec4b8c5c2428270c --old-bench 71c71159217a2a627fb06f270bb39890b76138f3 --cells all --keep $O/same > $O/same.stdout.txt 2> $O/same.stderr.txt; echo "same-library exit $? in $(( $(date +%s) - s )) s"
