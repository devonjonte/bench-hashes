#!/bin/sh
# The same-library check across the format change (v7 -> v8): the previous bench, 0.19.7 (e2b29f98, the tag), runs its own check of the fork at b5b988d8 against itself, every cell, to read beside 0.20.0's (check.stdout.txt).
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp; unset RUSTFLAGS
O=/home/agent/bench-hashes-validation/release-020-i7
cd /home/agent/bench-0197
s=$(date +%s); cargo run -q --release -- check --fork /home/agent/BLAKE3-rel019 --against b5b988d8982bea9490c38c79ec4b8c5c2428270c --cells all --keep $O/old-bench-aa > $O/old-aa.stdout.txt 2> $O/old-aa.stderr.txt; echo "== 0.19.7 A/A exit $? in $(( $(date +%s) - s )) s"
