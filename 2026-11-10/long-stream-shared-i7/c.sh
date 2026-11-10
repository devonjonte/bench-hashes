#!/bin/sh
# The shared long-stream cells, the library alone with the 0.8-era bench (3363bee8) on both sides:
# (1) 0.8 against the last commit before the API rename (27717b3f); (2) around 06f6e26d, the 8 MiB ring for long messages.
set -u
export PATH=/home/agent/.cargo/bin:$PATH TMPDIR=/home/agent/tmp
cd /home/agent/bench-3363c
P="continuous 1 MiB,continuous 4 MiB,continuous 16 MiB"
echo "== 1: 27717b3f against 0.8 (b5b988d8)"
./target/release/bench-hashes check --fork /home/agent/BLAKE3-m3 --new 27717b3f --against b5b988d8 --points "$P" --keep /home/agent/bench-hashes-validation/long-shared/kept-c1 --when-quiet
echo "check exit $?"
echo "== 2: 06f6e26d against its parent e4ef6f07"
./target/release/bench-hashes check --fork /home/agent/BLAKE3-m3 --new 06f6e26d --against e4ef6f07 --points "$P" --keep /home/agent/bench-hashes-validation/long-shared/kept-c2 --when-quiet
echo "check exit $?"
