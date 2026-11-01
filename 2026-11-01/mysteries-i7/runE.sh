#!/bin/sh
# E: servil st idle 16 pinned to CPU 2, with CPU 2's idle-state entries (cpuidle usage) before and after each run, 10 runs.
set -u
O=/home/agent/bench-hashes-validation/mysteries-i7
E=/home/agent/BLAKE3-rel019/target/bench-hashes-build/release/bench-hashes
usage() { for s in /sys/devices/system/cpu/cpu2/cpuidle/state*; do printf '%s ' $(cat $s/usage); done; }
for i in $(seq 1 10); do
  d=$O/E-$i; mkdir -p $d
  echo "before $(usage)" > $d/cpuidle.txt
  (cd $d && taskset -c 2 $E --contenders blake3-servil-st --points "idle 16" > report.txt 2> stderr.txt)
  echo "after $(usage)" >> $d/cpuidle.txt
done
echo done
