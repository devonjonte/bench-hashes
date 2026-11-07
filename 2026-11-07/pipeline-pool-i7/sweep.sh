#!/bin/sh
# The pipeline's receive cells by pool size on the i7: two passes over the sizes, alternating order.
set -u
E=/home/agent/BLAKE3-pin/target/bench-hashes-build/release/bench-0b9ccc2f9cfc-clean_servil-4eda049c89c2-clean/bench-hashes
O=/home/agent/bench-hashes-validation/pipeline-i7/sweep
for pass in 1 2; do
  sizes="2 3 4 6 8 12 16 20"; [ $pass = 2 ] && sizes="20 16 12 8 6 4 3 2"
  for t in $sizes; do
    d=$O/p$pass-t$t; rm -rf $d; mkdir -p $d; cd $d
    $E --contenders blake3-servil-pipeline,blake3-servil-mt --points "receive saturated,receive 2 us" --threads $t --rounds 6 > out.txt 2> err.txt
    echo "pass $pass threads $t exit $?"
  done
done
