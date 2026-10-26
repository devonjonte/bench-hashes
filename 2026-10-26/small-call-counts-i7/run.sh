#!/bin/sh
# Per call, warm, pinned to P core 2: user-space instructions and cycles of
# hash_many over MSGS 64-byte messages, 2,000,000 calls a process, 5 processes.
W=/home/agent/bisect-idle
for c in bfbda19 f1db8cd; do for m in 1 2 4 16 64; do for i in 1 2 3 4 5; do
  echo "$c $m $(taskset -c 2 perf stat -x, -e cpu_core/instructions/u,cpu_core/cycles/u -- $W/target-$c/release/examples/small_probe $m 2000000 2>&1 >/dev/null | cut -d, -f1,3 | tr '\n' ' ')"
done; done; done
