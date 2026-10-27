#!/bin/sh
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp
unset RUSTFLAGS
cd /home/agent/BLAKE3-fork/bench-hashes
cargo run -q --release -- check --against candidate/devon-prerelease-fixes --pairs 8 --keep /home/agent/bench-hashes-validation/fork-panic/samples
echo "== exit $? $(date -u +%H:%M)"
