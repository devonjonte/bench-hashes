#!/bin/sh
# BLAKE3 #314, V2: V1, and the open task handed over where it lies (no take, no pass by value).
# Against next, 16 pairs; both contenders' stream cells are read.
set -u
export PATH=/home/agent/.cargo/bin:$PATH TMPDIR=/home/agent/tmp
cd /home/agent/bench-0194
./target/release/bench-hashes check --fork /home/agent/BLAKE3-302 --new exp/devon-prefix-byref --against origin/next \
  --points "continuous 64 B,continuous 256 B,continuous 4 KiB,continuous 16 KiB" --layouts 16 --keep /home/agent/bench-hashes-validation/prefix-314/kept-v2 --when-quiet
echo "check exit $?"
