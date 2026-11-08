#!/bin/sh
cd /home/agent/bench-0194
for v in d a c; do
  echo "=== variant $v"
  ./target/release/bench-hashes check --fork /home/agent/BLAKE3-m3 --new exp/devon-prefix-$v --against rint --points "continuous 64 B,continuous 128 B,continuous 1 KiB,continuous 4 KiB,continuous 1 MiB" --layouts 8 --keep /home/agent/bench-hashes-validation/split-$v-i7 --when-quiet
  git checkout -q -- Cargo.lock
done
