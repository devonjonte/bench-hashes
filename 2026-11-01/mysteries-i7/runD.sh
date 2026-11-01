#!/bin/sh
# D: servil st idle 16 alone, unpinned against pinned to P core 2 (taskset -c 2), 6 runs each, alternating.
set -u
O=/home/agent/bench-hashes-validation/mysteries-i7
E=/home/agent/BLAKE3-rel019/target/bench-hashes-build/release/bench-hashes
one() { d=$O/$1; shift; mkdir -p $d && (cd $d && "$@" > report.txt 2> stderr.txt); }
for i in 1 2 3 4 5 6; do
  one D-free-$i $E --contenders blake3-servil-st --points "idle 16"
  one D-pinned-$i taskset -c 2 $E --contenders blake3-servil-st --points "idle 16"
done
echo done
