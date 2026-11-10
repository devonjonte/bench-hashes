#!/bin/sh
# BLAKE3 #349: x86-64's long ring at 2 MiB (John's candidate, rebased on next f4378b28) and at 4 MiB, each against next
# (8 MiB), 16 pairs, the multithreaded stream's long cells and 1 MiB.
set -u
export PATH=/home/agent/.cargo/bin:$PATH TMPDIR=/home/agent/tmp
cd /home/agent/bench-0194
P="continuous 1 MiB,continuous 4 MiB,continuous 16 MiB"
for b in candidate/long-ring-x86:2mib exp/devon-long-ring-4mib:4mib; do
  echo "== ${b%%:*} against next"
  ./target/release/bench-hashes check --fork /home/agent/BLAKE3-248 --new ${b%%:*} --against origin/next --points "$P" --layouts 16 \
    --keep /home/agent/bench-hashes-validation/long-ring/kept-${b##*:} --when-quiet
  echo "check exit $?"
done
