#!/bin/sh
# The pipeline contender: ring integration (old) and candidate/devon-task-prefix (new), alternating, 6 pairs.
D=/home/agent/bench-hashes-validation/prefix-pipe-i7
for pair in 1 2 3 4 5 6; do
  order="old new"; [ $((pair % 2)) = 0 ] && order="new old"
  for side in $order; do
    b=$D/bench-rint; [ $side = new ] && b=$D/bench-candidate-devon-task-prefix
    d=$D/pipe-$pair-$side; rm -rf $d; mkdir -p $d; cd $d
    $b --contenders blake3-servil-pipeline --points "receive saturated,receive 2 us,receive 20 us" --rounds 6 > out.txt 2> err.txt
    echo "pair $pair $side exit $?"
  done
done
