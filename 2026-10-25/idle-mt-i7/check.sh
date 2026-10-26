#!/bin/sh
set -eu
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp
unset RUSTFLAGS
cd /home/agent/BLAKE3-rel08/bench-hashes
cargo run -q --release -- check --against bfbda19 --old-bench 5be5f236 --cells all --pairs 8 --keep /home/agent/bench-hashes-validation/idle-mt-i7/samples
