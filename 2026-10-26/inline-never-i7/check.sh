#!/bin/sh
set -eu
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp
unset RUSTFLAGS
cd /home/agent/BLAKE3-inline-never/bench-hashes
cargo run -q --release -- check --against f1db8cd --cells all --pairs 8 --keep /home/agent/bench-hashes-validation/inline-never-i7/samples
