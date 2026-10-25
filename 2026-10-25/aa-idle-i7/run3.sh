#!/bin/sh
# Three same-code controls (bench-hashes #81): the integration against its
# own head, --cells all, one after another.
set -u
cd /home/agent/BLAKE3-rel08/bench-hashes
for i in 1 2 3; do
  echo "== control $i, $(date -u +%H:%M:%S)"
  cargo run --release -q -- check --against HEAD --cells all --keep /home/agent/bench-hashes-validation/aa-idle-i7/run$i
  echo "exit $?"
done
