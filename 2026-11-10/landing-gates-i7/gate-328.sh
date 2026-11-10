#!/bin/sh
# BLAKE3 #328 (the build version) rebased on next: its suites, the extra builds, and a speed
# check on points with no pipeline cells (the old side has BLAKE3 #302's race).
set -eu
export PATH=/home/agent/.cargo/bin:$PATH TMPDIR=/home/agent/tmp
cd /home/agent/BLAKE3-devver
cargo fmt --check && (cd version && cargo fmt --check)
cargo nextest run --cargo-quiet --release 2>&1 | tail -1
cargo test -q --release --doc 2>&1 | tail -1
sh tools/check-builds.sh | tail -1
cd /home/agent/bench-0194
./target/release/bench-hashes check --fork /home/agent/BLAKE3-devver --new candidate/devon-dev-version --against origin/next \
  --points "64 B,1 KiB,16 KiB,continuous 64 B,continuous 1 KiB,1 MiB" --keep /home/agent/bench-hashes-validation/night-1110/kept-328 --when-quiet
