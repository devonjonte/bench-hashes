#!/bin/sh
# 4 messages: placement (input page-aligned at 0, output at OUT_AT past the
# next page) and address randomization on/off; cycles per call, P core 2.
W=/home/agent/bisect-idle
for c in bfbda19 f1db8cd; do
  for oa in 0 64 1024 2048 3968; do echo "$c placement out_at=$oa $(taskset -c 2 perf stat -x, -e cpu_core/cycles/u -- $W/target-$c/release/examples/offset_probe 4 2000000 0 $oa 2>&1 >/dev/null | grep cycles | cut -d, -f1)"; done
  for i in 1 2 3 4 5 6 7 8 9 10; do echo "$c aslr $(taskset -c 2 perf stat -x, -e cpu_core/cycles/u -- $W/target-$c/release/examples/small_probe 4 2000000 2>&1 >/dev/null | grep cycles | cut -d, -f1)"; done
  for i in 1 2 3 4 5; do echo "$c noaslr $(taskset -c 2 perf stat -x, -e cpu_core/cycles/u -- setarch -R $W/target-$c/release/examples/small_probe 4 2000000 2>&1 >/dev/null | grep cycles | cut -d, -f1)"; done
done
