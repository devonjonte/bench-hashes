#!/bin/sh
# Two cells of the same-library check, investigated with bench 0.19.3
# (a48ee6c7) built against blake3-servil 0.8 (b5b988d8).
# A: servil mt shared lent 64 MiB: settling curves (no warm-up, 300 samples, one visit), x3.
# B: servil st idle 16: alone / after 0.19's nonstop cells / after them measured 0.18's way, x4 each, rotating.
set -u
O=/home/agent/bench-hashes-validation/mysteries-i7
E=/home/agent/BLAKE3-rel019/target/bench-hashes-build/release/bench-hashes
NONSTOP="lent 64 MiB,lent 16 MiB,lent 4 MiB,lent 1 MiB,continuous 1 MiB,continuous 64 KiB,lent batch 16384,continuous batch 1024"
one() { d=$O/$1; shift; mkdir -p $d && (cd $d && "$@" > report.txt 2> stderr.txt); echo "$(basename $d) exit $?"; }
for i in 1 2 3; do
  one A-settle-$i $E --contenders blake3-servil-mt --points "lent 64 MiB" --train 0,300 --nonstop-visits 1
done
for i in 1 2 3 4; do
  one B-alone-$i $E --contenders blake3-servil-st --points "idle 16"
  one B-after019-$i $E --contenders blake3-servil-st,blake3-servil-mt --points "idle 16,$NONSTOP"
  one B-after018way-$i $E --contenders blake3-servil-st,blake3-servil-mt --points "idle 16,$NONSTOP" --train 0,1 --nonstop-visits 6
done
