#!/bin/sh
set -u
O=/home/agent/bench-hashes-validation/review-019-i7/dd-ab
B=/home/agent/bench-019/target/release/bench-hashes
rm -rf $O; mkdir -p $O && cd $O
one() { mkdir $1 && (cd $1 && $B --contenders blake3-servil-st,blake3-servil-mt,sha256-ring --points "1 KiB,64 KiB,1 MiB,8 MiB,continuous 64 KiB,continuous 1 MiB" > report.txt 2> err.txt); }
for i in 1 2 3 4 5 6; do
  if [ $((i % 2)) = 1 ]; then one quiet-$i; taskset -c 12 dd if=/dev/zero of=/dev/null bs=1M 2>/dev/null & P=$!; one dd-$i; kill $P; wait $P 2>/dev/null
  else taskset -c 12 dd if=/dev/zero of=/dev/null bs=1M 2>/dev/null & P=$!; one dd-$i; kill $P; wait $P 2>/dev/null; one quiet-$i; fi
done
grep -h 'load during' */report.txt | sort | uniq -c
$B compare quiet-*/benchmark-results/*/bench-hashes.samples.tsv -- dd-*/benchmark-results/*/bench-hashes.samples.tsv
