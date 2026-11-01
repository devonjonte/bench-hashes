#!/bin/sh
# C: servil st idle 16 alone, ASLR on against off (setarch -R), 8 runs each, alternating.
set -u
O=/home/agent/bench-hashes-validation/mysteries-i7
E=/home/agent/BLAKE3-rel019/target/bench-hashes-build/release/bench-hashes
one() { d=$O/$1; shift; mkdir -p $d && (cd $d && "$@" > report.txt 2> stderr.txt); }
for i in 1 2 3 4 5 6 7 8; do
  one C-aslr-$i $E --contenders blake3-servil-st --points "idle 16"
  one C-noaslr-$i setarch -R $E --contenders blake3-servil-st --points "idle 16"
done
echo done
