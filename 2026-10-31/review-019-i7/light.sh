#!/bin/sh
# Load under 0.19's rule (other programs' user time), and the calibration
# cache, with a short run of the default contenders at a few points.
set -u
O=/home/agent/bench-hashes-validation/review-019-i7
B=/home/agent/bench-019/target/release/bench-hashes
mkdir -p $O/light && cd $O/light
short() { $B --contenders blake3-servil-st,sha256-ring --points "1 KiB,64 KiB,1 MiB" > $1.txt 2> $1.err; grep -hE 'other programs kept|sample sizes' $1.txt $1.err benchmark-results/*/bench-hashes.samples.tsv 2>/dev/null | sort -u | cut -c1-200; }
echo "== quiet, first run (calibrates)"; short quiet1
echo "== quiet, second run (the cache?)"; short quiet2
echo "== beside a user-time spinner on CPU 12"; taskset -c 12 python3 -c 'while True: pass' & P=$!; short spinner; kill $P
echo "== beside dd (kernel time) on CPU 12"; taskset -c 12 dd if=/dev/zero of=/dev/null bs=1M & P=$!; short dd; python3 -c "import sys; f=open('/proc/$P/stat').read().split(')')[1].split(); print(f'dd: user {int(f[11])/100:.1f} s, system {int(f[12])/100:.1f} s')"; kill $P; wait
