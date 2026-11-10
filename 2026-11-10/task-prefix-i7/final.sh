#!/bin/sh
# BLAKE3 #314, a full task as one whole-struct copy (826f9140), against next, 16 pairs.
set -u
export PATH=/home/agent/.cargo/bin:$PATH TMPDIR=/home/agent/tmp
cd /home/agent/bench-0194
./target/release/bench-hashes check --fork /home/agent/BLAKE3-302 --new candidate/devon-task-prefix --against origin/next \
  --points "continuous 64 B,continuous 256 B,continuous 4 KiB,continuous 16 KiB" --layouts 16 --keep /home/agent/bench-hashes-validation/prefix-314/kept-final2 --when-quiet
echo "check exit $?"
