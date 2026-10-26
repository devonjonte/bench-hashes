#!/bin/sh
# mt after-a-pause cells alone: f1db8cd (new) against bfbda19 (old) at 23
# pairs on the check's relinked layouts; then two same-code controls (old
# against old, new against new, 12 pairs each, disjoint layouts).
set -eu
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp
C=/home/agent/BLAKE3-rel08/target/check
B=/home/agent/BLAKE3-rel08/bench-hashes/target/release/bench-hashes
cd /home/agent/BLAKE3-rel08/bench-hashes
P="idle 1,idle 2,idle 3,idle 4,idle 6,idle 8,idle 12,idle 16,idle 24,idle 32"
o() { for i in "$@"; do printf '%s ' "$C/old/bench-hashes-$i"; done; }
n() { for i in "$@"; do printf '%s ' "$C/new/bench-hashes-$i"; done; }
K=/home/agent/bench-hashes-validation/idle-mt-i7
echo "== f1db8cd against bfbda19, 23 pairs"
$B regress --pairs 23 --contenders blake3-servil-mt --points "$P" --keep $K/t-main $(o 0 1 2 3 4 5 6 7 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30) -- $(n 8 9 10 11 12 13 14 15 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46) || true
echo "== control: bfbda19 against bfbda19, 12 pairs"
$B regress --pairs 12 --contenders blake3-servil-mt --points "$P" --keep $K/t-aa-old $(o 0 1 2 3 4 5 6 7 16 17 18 19) -- $(o 20 21 22 23 24 25 26 27 28 29 30 31) || true
echo "== control: f1db8cd against f1db8cd, 12 pairs"
$B regress --pairs 12 --contenders blake3-servil-mt --points "$P" --keep $K/t-aa-new $(n 8 9 10 11 12 13 14 15 32 33 34 35) -- $(n 36 37 38 39 40 41 42 43 44 45 46 47) || true
