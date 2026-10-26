#!/bin/sh
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp
cd /home/agent/BLAKE3-night
echo "== mutation check $(git rev-parse HEAD) $(date -u +%H:%M)"
python3 tools/mutants/check.py
echo "== mutation check exit $? $(date -u +%H:%M)"
unset RUSTFLAGS
cd /home/agent/BLAKE3-night/bench-hashes
cargo run -q --release -- check --against origin/candidate/release-0.8 --cells all --pairs 8 --keep /home/agent/bench-hashes-validation/night2/samples
echo "== speed check exit $? $(date -u +%H:%M)"
