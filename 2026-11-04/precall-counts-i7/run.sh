#!/bin/bash
# A/B: counts read before each after-pause call (stock) against none (a build whose Counts::read gives None).
cd "$(dirname "$0")"
for r in 1 2 3; do
  for v in counts nocounts; do
    d=run-$v-$r; rm -rf $d; mkdir -p $d; cd $d
    timeout 900 /home/agent/tmp/bh-$v --contenders blake3-servil-st --points "brief idle 64 B,idle 64 B,brief idle 1 KiB,idle 1 KiB,brief idle 16,idle 16" > report.txt 2> err.txt
    echo "$d exit $?"; cd ..
  done
done
