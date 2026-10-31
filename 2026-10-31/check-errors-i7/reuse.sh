#!/bin/sh
# 64 pairs from 16 cached layouts a side, each run 4 times: known truth, then A/A.
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp
cd /home/agent/BLAKE3-aa/bench-hashes
EXE=/home/agent/BLAKE3-aa/target/check/new/bench-hashes-24
J='blake3-servil-st|solo|OneMessage|3839 B;blake3-servil-mt|solo|OneMessage|3839 B;blake3-servil-st|solo|IdleOneMessage|3839 B;blake3-servil-mt|solo|IdleOneMessage|3839 B;blake3-servil-st|solo|OneMessage|7935 B;blake3-servil-mt|solo|OneMessage|7935 B;blake3-servil-st|solo|IdleOneMessage|7935 B;blake3-servil-mt|solo|IdleOneMessage|7935 B'
OLD=""; NEW=""; AA1=""; AA2=""
for r in 1 2 3 4; do
  for s in $(seq 8 23); do OLD="$OLD /home/agent/BLAKE3-aa/target/check/old/bench-hashes-$s"; done
  for s in $(seq 24 39); do NEW="$NEW /home/agent/BLAKE3-aa/target/check/new/bench-hashes-$s"; done
  for i in $(seq 0 7); do for s in $((8+i)); do AA1="$AA1 /home/agent/BLAKE3-aa/target/check/old/bench-hashes-$s"; AA2="$AA2 /home/agent/BLAKE3-aa/target/check/old/bench-hashes-$((16+i))"; done; done
done
AA1="$AA1 $AA1"; AA2="$AA2 $AA2"
echo "== known truth $(date -u +%H:%M)"
$EXE regress --pairs 64 --contenders blake3-servil-mt,blake3-servil-st --points "3839 B,idle 3839 B,7935 B,idle 7935 B" --judge "$J" --keep /home/agent/bench-hashes-validation/check-errors-i7/reuse-known $OLD -- $NEW > /home/agent/bench-hashes-validation/check-errors-i7/reuse-known.stdout.txt 2> /home/agent/bench-hashes-validation/check-errors-i7/reuse-known.stderr.txt; echo "exit $?"
echo "== A/A $(date -u +%H:%M)"
$EXE regress --pairs 64 --contenders blake3-servil-mt,blake3-servil-st --points "3839 B,idle 3839 B,7935 B,idle 7935 B" --judge "$J" --keep /home/agent/bench-hashes-validation/check-errors-i7/reuse-aa $AA1 -- $AA2 > /home/agent/bench-hashes-validation/check-errors-i7/reuse-aa.stdout.txt 2> /home/agent/bench-hashes-validation/check-errors-i7/reuse-aa.stderr.txt; echo "exit $?"
