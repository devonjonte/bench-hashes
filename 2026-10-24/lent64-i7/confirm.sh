#!/bin/sh
# Three repeats of the slow-looking window (3952-4080) beside a quiet one (1008-1136), P cores.
B=$(pwd)/bench-hashes-082afa3
for r in 1 2 3; do
  for s in $(seq 3952 16 4080) $(seq 1008 16 1136); do
    d=confirm-$r-$s; mkdir -p $d; cd $d
    out=$(GLIBC_TUNABLES=glibc.rtld.optional_static_tls=$s taskset -c 0-15 $B --contenders blake3-servil-st --points 'lent 64 B' --for-regression-check --rounds 96 2>&1)
    solo=$(printf '%s\n' "$out" | awk '/^SOLO/{f=1} f&&/64 B/{print $3; exit}')
    shared=$(printf '%s\n' "$out" | awk '/^SHARED/{f=1} f&&/64 B/{print $3; exit}')
    printf '%s\t%s\t%s\t%s\n' "$r" "$s" "$solo" "$shared"
    cd ..
  done
done
