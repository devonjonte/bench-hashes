#!/bin/sh
cd /home/agent/bench-0194
echo "=== old: 8db14f7b vs 7b8de621"
./target/release/bench-hashes check --fork /home/agent/BLAKE3-m3 --new r248old --against 7b8de621 --points "3 KiB,idle 3 KiB" --layouts 8 --keep /home/agent/bench-hashes-validation/g248c-old-i7 --when-quiet; git checkout -q -- Cargo.lock
echo "=== new: 085b89a0 vs 5d966a0c"
./target/release/bench-hashes check --fork /home/agent/BLAKE3-m3 --new r248new --against origin/next --points "3 KiB,idle 3 KiB" --layouts 8 --keep /home/agent/bench-hashes-validation/g248c-new-i7 --when-quiet; git checkout -q -- Cargo.lock
