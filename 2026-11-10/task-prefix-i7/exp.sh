#!/bin/sh
# BLAKE3 #314's experiment: a full task takes the whole-struct write. Against next, 16 pairs, the cells that leaned and two that gained.
set -u
export PATH=/home/agent/.cargo/bin:$PATH TMPDIR=/home/agent/tmp
cd /home/agent/bench-0194
./target/release/bench-hashes check --fork /home/agent/BLAKE3-302 --new exp/devon-prefix-full-whole --against origin/next \
  --points "continuous 64 B,continuous 256 B,continuous 4 KiB,continuous 16 KiB" --layouts 16 --keep /home/agent/bench-hashes-validation/prefix-314/kept-exp --when-quiet
echo "check exit $?"
