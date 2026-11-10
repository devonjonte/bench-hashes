#!/bin/sh
# The shared long-stream cells: the 0.21 pin against next before tonight's landings (a4095ba6), one bench (7c1645d4).
set -u
export PATH=/home/agent/.cargo/bin:$PATH TMPDIR=/home/agent/tmp
cd /home/agent/bench-0194
./target/release/bench-hashes check --fork /home/agent/BLAKE3-m3 --new 5663b129e2c0ac19897a8d4e148b32abe99bb9c5 --against a4095ba6 \
  --points "continuous 1 MiB,continuous 4 MiB,continuous 16 MiB" --layouts 8 --keep /home/agent/bench-hashes-validation/long-shared/kept-a --when-quiet
echo "check exit $?"
