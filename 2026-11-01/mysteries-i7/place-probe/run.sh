#!/bin/sh
# 4 processes, pinned to CPU 2, 40 allocations each.
O=/home/agent/bench-hashes-validation/mysteries-i7/place-probe
for p in 1 2 3 4; do taskset -c 2 $O/place_probe.bin 40 > $O/proc-$p.tsv; echo "proc $p exit $?"; done
