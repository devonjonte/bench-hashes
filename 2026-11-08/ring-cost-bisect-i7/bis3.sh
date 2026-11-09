#!/bin/sh
cd /home/agent/bench-pin85bf
for v in prefix inline; do
  echo "=== $v"
  ./target/release/bench-hashes check --fork /home/agent/BLAKE3-m3 --new exp/bis85-$v --against bisbase-85bf73a6 --points "continuous 64 B,continuous 128 B" --layouts 6 --keep /home/agent/bench-hashes-validation/bis85-$v-i7 --when-quiet
  git checkout -q -- Cargo.lock
done
