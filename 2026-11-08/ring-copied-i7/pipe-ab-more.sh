#!/bin/sh
# The pipeline contender, old (next 7ee5c1f8) and new (eb3e9ba2) alternating, 4 pairs.
set -u
D=/home/agent/bench-hashes-validation/ring-copied-i7
for pair in 5 6 7 8 9 10 11 12 13 14 15 16; do
  order="old new"; [ $((pair % 2)) = 0 ] && order="new old"
  for side in $order; do
    d=$D/pipe-$pair-$side; rm -rf $d; mkdir -p $d; cd $d
    $D/bench-$side --contenders blake3-servil-pipeline --points "receive saturated" --rounds 6 > out.txt 2> err.txt
    echo "pair $pair $side exit $?"
  done
done
