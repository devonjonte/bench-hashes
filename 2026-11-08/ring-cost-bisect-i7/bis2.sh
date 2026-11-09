#!/bin/sh
c=$1
for b in ${BENCHES:-/home/agent/bench-mainline /home/agent/bench-0194}; do
  cd $b
  ./target/release/bench-hashes check --fork /home/agent/BLAKE3-m3 --new exp/bis-$c --against bisbase-$c --points "continuous 64 B,continuous 128 B" --layouts 6 --keep /home/agent/bench-hashes-validation/bis-$c-i7 --when-quiet && { git checkout -q -- Cargo.lock; exit 0; }
  git checkout -q -- Cargo.lock
  echo "=== bench $b failed; next"
done
