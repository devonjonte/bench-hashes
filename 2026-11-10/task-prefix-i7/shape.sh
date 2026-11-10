#!/bin/sh
# BLAKE3 #314: the experiment's shape again (a full task's path returns early), the two small cells, 32 pairs.
set -u
export PATH=/home/agent/.cargo/bin:$PATH TMPDIR=/home/agent/tmp
cd /home/agent/bench-0194
./target/release/bench-hashes check --fork /home/agent/BLAKE3-302 --new candidate/devon-task-prefix --against origin/next \
  --points "continuous 64 B,continuous 256 B" --layouts 32 --keep /home/agent/bench-hashes-validation/prefix-314/kept-shape --when-quiet
echo "check exit $?"
