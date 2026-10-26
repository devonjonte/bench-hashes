#!/bin/sh
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp
unset RUSTFLAGS
cd /home/agent/BLAKE3-rel08
echo "== fork $(git rev-parse HEAD), bench $(git -C bench-hashes rev-parse HEAD) $(date -u +%H:%M)"
cd bench-hashes
cargo run -q --release -- check --against bfbda19 --old-bench 5be5f236 --cells all --keep /home/agent/bench-hashes-validation/release-e7c5/check
echo "== check exit $? $(date -u +%H:%M)"
cd ..
python3 tools/mutants/check.py
echo "== mutants exit $? $(date -u +%H:%M)"
