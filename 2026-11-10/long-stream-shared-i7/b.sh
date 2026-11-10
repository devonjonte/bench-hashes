#!/bin/sh
# The shared long-stream cells, the library alone across the November 7 window: db3cab99 against 85bf73a6
# (the pipeline prototype on the pool, and "the producer helps where no worker takes a task"), one bench (a9a57a09).
set -u
export PATH=/home/agent/.cargo/bin:$PATH TMPDIR=/home/agent/tmp
cd /home/agent/bench-a9a5
./target/release/bench-hashes check --fork /home/agent/BLAKE3-m3 --new 85bf73a6 --against db3cab99 \
  --points "continuous 1 MiB,continuous 4 MiB,continuous 16 MiB" --keep /home/agent/bench-hashes-validation/long-shared/kept-b --when-quiet
echo "check exit $?"
