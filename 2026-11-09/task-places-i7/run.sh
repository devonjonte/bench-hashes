#!/bin/sh
# BLAKE3 #302's speed gate on the i7-12700K: the task places (candidate/devon-task-places)
# against its base, #329's head c7936a5f: every cell that goes through a source's ring,
# the stream's (continuous, lent, collection) and the pipeline's (batches, receive).
set -eu
cd /home/agent/bench-0194
export PATH=/home/agent/.cargo/bin:$PATH TMPDIR=/home/agent/tmp
./target/release/bench-hashes check --fork /home/agent/BLAKE3-302 --new candidate/devon-task-places --against c7936a5f \
  --points "continuous 64 B,continuous 128 B,continuous 256 B,continuous 1 KiB,continuous 4 KiB,continuous 16 KiB,continuous 64 KiB,continuous 1 MiB,continuous 16 MiB,continuous batch 16,continuous batch 64,continuous batch 256,continuous batch 1024,continuous batch 4096,continuous batch 16384,continuous batch 65536,lent 64 B,lent 1 KiB,lent 16 KiB,lent 1 MiB,lent batch 16,lent batch 1024,continuous collection git objects,receive saturated,receive 2 μs,receive 20 μs" \
  --keep /home/agent/bench-hashes-validation/places-check/kept --when-quiet
