#!/bin/sh
# B: servil st idle 16 inside full --all runs: 0.19 as released against 0.19 measuring 0.18's way, 3 pairs alternating.
set -u
O=/home/agent/bench-hashes-validation/mysteries-i7
E=/home/agent/BLAKE3-rel019/target/bench-hashes-build/release/bench-hashes
one() { d=$O/$1; shift; mkdir -p $d && (cd $d && "$@" > report.txt 2> stderr.txt); echo "$(basename $d) exit $?"; }
for i in 1 2 3; do
  if [ $((i % 2)) = 1 ]; then one B2-trains-$i $E --all; one B2-018way-$i $E --all --train 0,1 --nonstop-visits 6
  else one B2-018way-$i $E --all --train 0,1 --nonstop-visits 6; one B2-trains-$i $E --all; fi
done
