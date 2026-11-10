#!/bin/sh
# BLAKE3 #314 on next: the stream's cells, the candidate against next (bench c2804417).
set -u
export PATH=/home/agent/.cargo/bin:$PATH TMPDIR=/home/agent/tmp
cd /home/agent/bench-0194
./target/release/bench-hashes check --fork /home/agent/BLAKE3-302 --new candidate/devon-task-prefix --against origin/next \
  --points "continuous 64 B,continuous 256 B,continuous 1 KiB,continuous 4 KiB,continuous 16 KiB,continuous 64 KiB,continuous 1 MiB,continuous 4 MiB,continuous 16 MiB,lent 64 B,continuous batch 16,continuous batch 1024,continuous collection git objects" \
  --keep /home/agent/bench-hashes-validation/prefix-314/kept --when-quiet
echo "check exit $?"
