#!/bin/sh
# check: the workers' walk in turn (candidate/devon-pool-order 8d3be7a3-or-later) against servil 06f6e26d, the cells the change reaches.
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp; unset RUSTFLAGS
O=/home/agent/bench-hashes-validation/pool-order-i7
cd /home/agent/bench-0194; s=$(date +%s)
cargo run -q --release -- check --fork /home/agent/BLAKE3-m3 --against 06f6e26d --keep $O/check > $O/check.stdout.txt 2> $O/check.stderr.txt
echo "== check exit $? in $(( $(date +%s) - s )) s $(date -u +%H:%M)"
git checkout -q -- Cargo.lock 2>/dev/null
