#!/bin/sh
for c in 149707e1 6fc30a3d; do
  echo "=== $c"
  cd /home/agent/bench-mainline
  ./target/release/bench-hashes check --fork /home/agent/BLAKE3-m3 --new exp/bis-$c --against bisbase-$c --points "continuous 64 B,continuous 128 B" --layouts 6 --keep /home/agent/bench-hashes-validation/bis-$c-i7 --when-quiet
  git checkout -q -- Cargo.lock
done
