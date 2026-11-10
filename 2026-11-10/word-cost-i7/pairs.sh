#!/bin/sh
# 32 pairs each, the multithreaded stream of 64 B messages, against the base c7936a5f:
# the ring word as in the experiment, its counter moved, and the word stored and loaded but unused.
set -u
export PATH=/home/agent/.cargo/bin:$PATH TMPDIR=/home/agent/tmp
cd /home/agent/bench-0bb3
for b in exp/devon-places-in-order exp/devon-places-count-own-line exp/devon-places-word-unused; do
  n=$(echo $b | sed 's|exp/devon-places-||')
  echo "== $b"
  ./target/release/bench-hashes check --fork /home/agent/BLAKE3-revert --new $b --against c7936a5f \
    --points "continuous 64 B" --layouts 32 --keep /home/agent/bench-hashes-validation/word-cost/kept-$n --when-quiet
  echo "check exit $?"
done
