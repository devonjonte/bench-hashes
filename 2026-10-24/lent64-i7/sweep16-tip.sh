#!/bin/sh
# Sam's #65 reproducer on the i7: the shared LentMessages 64 B cell over one
# 4 KiB cycle of the duo threads' stack offset (optional_static_tls in steps
# of 64 bytes), pinned to P cores (0-15) and to E cores (16-19).
B=$(pwd)/bench-hashes-2e892e1-offsetcheck
for cores in 0-15; do
  for s in $(seq 448 16 4544); do
    d=tip-$cores-$s; mkdir -p $d; cd $d
    out=$(GLIBC_TUNABLES=glibc.rtld.optional_static_tls=$s taskset -c $cores $B --contenders blake3-servil-st --points 'lent 64 B' --for-regression-check --rounds 96 2>&1)
    solo=$(printf '%s\n' "$out" | awk '/^SOLO/{f=1} f&&/64 B/{print $3; exit}')
    shared=$(printf '%s\n' "$out" | awk '/^SHARED/{f=1} f&&/64 B/{print $3; exit}')
    printf '%s\t%s\t%s\t%s\n' "$cores" "$s" "$solo" "$shared"
    cd ..
  done
done
