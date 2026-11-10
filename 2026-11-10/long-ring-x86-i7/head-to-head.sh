#!/bin/sh
# BLAKE3 #349: x86-64's long ring at 4 MiB against 2 MiB, head to head, 16 pairs.
set -u
export PATH=/home/agent/.cargo/bin:$PATH TMPDIR=/home/agent/tmp
cd /home/agent/bench-0194
./target/release/bench-hashes check --fork /home/agent/BLAKE3-248 --new exp/devon-long-ring-4mib --against candidate/long-ring-x86 \
  --points "continuous 1 MiB,continuous 4 MiB,continuous 16 MiB" --layouts 16 --keep /home/agent/bench-hashes-validation/long-ring/kept-4-vs-2 --when-quiet
echo "check exit $?"
