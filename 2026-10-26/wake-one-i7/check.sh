#!/bin/sh
set -eu
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp
unset RUSTFLAGS
cd /home/agent/BLAKE3-wakeone/bench-hashes
cargo run -q --release -- check --against candidate/devon-list-check --pairs 8 --keep /home/agent/bench-hashes-validation/wake-one/samples
