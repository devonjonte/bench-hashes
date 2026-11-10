#!/bin/sh
# Run next's bench build (the one that segfaulted in #328's check) on the pipeline's
# batch 16 cell under gdb until it stops on a signal or panics, or 20 minutes pass.
cd /home/agent/bench-hashes-validation/next-segv
end=$(( $(date +%s) + 1200 )); n=0
while [ $(date +%s) -lt $end ]; do
  n=$((n+1)); rm -rf scratch; mkdir scratch
  ( cd scratch && gdb -q -batch -ex 'set pagination off' -ex run -ex 'echo \n== BACKTRACE ==\n' -ex 'thread apply all bt 14' --args ../bench-hashes-8 --contenders blake3-servil-pipeline --points "continuous batch 16,continuous batch 64" > ../last.txt 2>&1 )
  if grep -q 'received signal\|panicked' last.txt; then cp last.txt crash-$n.txt; echo "run $n: STOPPED"; grep -m3 'received signal\|panicked' last.txt; exit 0; fi
done
echo "no stop in $n runs"
