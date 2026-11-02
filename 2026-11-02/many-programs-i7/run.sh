#!/bin/sh
# N programs at once, each a servil mt stream of 64 KiB messages (and 1 KiB), 4 s each; the sum of their GB/s and the slowest/fastest. i7-12700K, 20 CPUs.
set -u
O=/home/agent/bench-hashes-validation/many-programs-i7
B=/home/agent/BLAKE3-fair/target/release/examples/many_programs
for len in 65536 1024; do
  for n in 1 2 4 10 20 40 80; do
    rm -f $O/out-$len-$n-*.txt
    for i in $(seq 1 $n); do $B 4 $len > $O/out-$len-$n-$i.txt & done; wait
    python3 - $len $n $O <<'PY'
import sys, glob
len_, n, O = sys.argv[1], sys.argv[2], sys.argv[3]
v = sorted(float(open(f).read()) for f in glob.glob(f'{O}/out-{len_}-{n}-*.txt'))
print(f'{len_:>6} B  N={n:>3}: sum {sum(v):7.2f} GB/s  each: min {v[0]:6.2f} median {v[len(v)//2]:6.2f} max {v[-1]:6.2f}  (max/min {v[-1]/max(v[0],1e-9):.2f})', flush=True)
PY
  done
done
