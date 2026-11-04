#!/bin/sh
# For each kept run: the second stage's 64 pairs (or the first stage's 4 where there was no second), judged by wall, cycles and instructions.
set -u
export PATH=/home/agent/.cargo/bin:$PATH TMPDIR=/home/agent/tmp
B=/home/agent/bench-0194/target/release/bench-hashes
O=/home/agent/bench-hashes-validation/judge-i7
for name in aa known119 spin450 cold450 hash3; do
  for stage in second first; do
    if [ $stage = second ]; then d=$O/$name/second; else d=$O/$name; fi
    [ -d "$d" ] || continue
    OLD=$(ls $d/run-*-old.tsv 2>/dev/null | sort); NEW=$(ls $d/run-*-new.tsv 2>/dev/null | sort)
    [ -n "$OLD" ] || continue
    for by in wall cycles instructions; do
      $B compare --judge-by $by $OLD -- $NEW > $O/$name.$stage.$by.txt 2>&1
      echo "$name $stage $by: $(grep -c ' slower,' $O/$name.$stage.$by.txt) slower, $(grep -c ' faster,' $O/$name.$stage.$by.txt) faster, $(grep -c ' level,' $O/$name.$stage.$by.txt) level"
    done
  done
done
