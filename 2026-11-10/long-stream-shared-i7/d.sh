#!/bin/sh
# (1) 16 pairs: 06f6e26d (the 8 MiB ring for long messages) against its parent, the 0.8-era bench on both sides.
# (2) The November 7 whole-map check replayed on these cells: tip 8d6525c3 against 0.8, old bench 3363bee8,
#     from the bench that ran it then (ac1668a5). That run read "no cell slower" and kept no samples.
set -u
export PATH=/home/agent/.cargo/bin:$PATH TMPDIR=/home/agent/tmp
P="continuous 1 MiB,continuous 4 MiB,continuous 16 MiB"
echo "== 1: 06f6e26d against e4ef6f07, 16 pairs"
cd /home/agent/bench-3363c
./target/release/bench-hashes check --fork /home/agent/BLAKE3-m3 --new 06f6e26d --against e4ef6f07 --points "$P" --layouts 16 --keep /home/agent/bench-hashes-validation/long-shared/kept-d1 --when-quiet
echo "check exit $?"
echo "== 2: the November 7 check replayed: 8d6525c3 against b5b988d8, --old-bench 3363bee8, bench ac1668a5"
cd /home/agent/bench-ac16
./target/release/bench-hashes check --fork /home/agent/BLAKE3-m3 --new 8d6525c3 --against b5b988d8 --old-bench 3363bee8 --points "$P" --keep /home/agent/bench-hashes-validation/long-shared/kept-d2 --when-quiet
echo "check exit $?"
