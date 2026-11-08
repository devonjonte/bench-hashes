#!/bin/sh
cd /home/agent/bench-0194
P="continuous 64 B,continuous 128 B,continuous 256 B,continuous 1 KiB,continuous 4 KiB,continuous 16 KiB"
echo "=== r88 against fbfb"
./target/release/bench-hashes check --fork /home/agent/BLAKE3-m3 --new r88 --against rfbfb --points "$P" --layouts 8 --keep /home/agent/bench-hashes-validation/r88-i7 --when-quiet
git checkout -q -- Cargo.lock
echo "=== r88 + task prefix against fbfb"
./target/release/bench-hashes check --fork /home/agent/BLAKE3-m3 --new candidate/devon-task-prefix-88 --against rfbfb --points "$P" --layouts 8 --keep /home/agent/bench-hashes-validation/r88p-i7 --when-quiet
git checkout -q -- Cargo.lock
