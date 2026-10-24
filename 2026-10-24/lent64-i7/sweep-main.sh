#!/bin/sh
# The main thread's stack through one page (the environment's size, in steps
# of 16), solo 64 B, P cores; both binaries.
for b in bench-hashes-082afa3 bench-hashes-2e892e1-offsetcheck; do
  B=$(pwd)/$b
  for k in $(seq 0 16 4080); do
    d=main-$b-$k; mkdir -p $d; cd $d
    pad=$(head -c $k /dev/zero | tr '\0' x)
    out=$(env -i PATH="$PATH" HOME="$HOME" OFFSET_CHECK_PAD="$pad" taskset -c 0-15 $B --contenders blake3-servil-st --points 'lent 64 B' --for-regression-check --rounds 96 2>&1)
    solo=$(printf '%s\n' "$out" | awk '/^SOLO/{f=1} f&&/64 B/{print $3; exit}')
    shared=$(printf '%s\n' "$out" | awk '/^SHARED/{f=1} f&&/64 B/{print $3; exit}')
    printf '%s\t%s\t%s\t%s\n' "$b" "$k" "$solo" "$shared"
    cd ..
  done
done
