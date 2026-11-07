#!/bin/sh
set -eu
M=/home/agent/instr-mystery; E=/home/agent/BLAKE3-m3/target/check/new/bench-hashes-24; S=/home/agent/bench-hashes-validation/i7-09-fullgate3/sizes.tsv
v() { tag=$1; shift; d=$M/v-$tag; rm -rf $d; mkdir -p $d; cd $d; "$@" --sizes $S --rounds 2 > out.txt 2> err.txt; }
v cpu3      taskset -c 3 $E --contenders blake3-servil-st --points "continuous 64 B"
v cpu0      taskset -c 0 $E --contenders blake3-servil-st --points "continuous 64 B"
v unpinned  $E --contenders blake3-servil-st --points "continuous 64 B"
v stmt      taskset -c 2 $E --contenders blake3-servil-st,blake3-servil-mt --points "continuous 64 B"
v morepts   taskset -c 2 $E --contenders blake3-servil-st --points "64 B,continuous 64 B,lent 64 B,continuous 4 KiB"
echo DONE
