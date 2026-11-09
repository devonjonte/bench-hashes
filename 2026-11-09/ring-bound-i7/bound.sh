#!/bin/sh
cd /home/agent/bench-mainline
P="continuous 64 B,continuous 128 B,continuous 256 B,continuous 1 KiB,continuous 4 KiB,continuous 16 KiB,continuous 64 KiB,continuous 1 MiB,continuous batch 1024,collection git objects"
echo "=== no-generation against main"
./target/release/bench-hashes check --fork /home/agent/BLAKE3-m3 --new rnogen --against main-tip --points "$P" --layouts 8 --keep /home/agent/bench-hashes-validation/rnogen-main-i7 --when-quiet; git checkout -q -- Cargo.lock
echo "=== no-generation against the released ring"
./target/release/bench-hashes check --fork /home/agent/BLAKE3-m3 --new rnogen --against relring --points "$P" --layouts 8 --keep /home/agent/bench-hashes-validation/rnogen-rel-i7 --when-quiet; git checkout -q -- Cargo.lock
