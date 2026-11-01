#!/bin/sh
# 0.18.3 (1f4dfd63; clocks f448bb32, load = all busy time less ours) beside dd.
set -u
O=/home/agent/bench-hashes-validation/review-019-i7/dd-018
B=/home/agent/bench-0183/target/release/bench-hashes
rm -rf $O; mkdir -p $O && cd $O
one() { mkdir $1 && (cd $1 && $B --contenders blake3-servil-st,blake3-servil-mt,sha256-ring --points "1 KiB,64 KiB,1 MiB,8 MiB,continuous 64 KiB,continuous 1 MiB" > report.txt 2> err.txt); echo "$1: $(grep -h 'load during' $1/report.txt | sed 's/^ *//')"; }
for i in 1 2 3; do
  one quiet-$i
  taskset -c 12 dd if=/dev/zero of=/dev/null bs=1M 2>/dev/null & P=$!; one dd-$i; kill $P; wait $P 2>/dev/null
done
