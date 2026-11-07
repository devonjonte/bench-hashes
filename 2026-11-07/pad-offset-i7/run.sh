#!/bin/sh
# One executable, the two calibrated sample sizes of the full gate, the 64 B stream cell.
set -eu
M=/home/agent/instr-mystery
for exe in new/bench-hashes-24 old/bench-hashes-0; do
  for sz in first:/home/agent/bench-hashes-validation/i7-09-fullgate3/sizes.tsv second:/home/agent/bench-hashes-validation/i7-09-fullgate3/second/sizes.tsv; do
    tag=$(echo $exe | tr / -)-${sz%%:*}; d=$M/$tag; rm -rf $d; mkdir -p $d; cd $d
    taskset -c 2 /home/agent/BLAKE3-m3/target/check/$exe --contenders blake3-servil-st --points "continuous 64 B" --sizes ${sz#*:} --rounds 2 > out.txt 2> err.txt
  done
done
echo DONE
