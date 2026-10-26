#!/bin/sh
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp
unset RUSTFLAGS
cd /home/agent/BLAKE3-rel08/bench-hashes
cargo run -q --release -- check --against 612e845 --pairs 8 --keep /home/agent/bench-hashes-validation/check-612-e7c5/samples
echo "== exit $? $(date -u +%H:%M)"
