#!/bin/sh
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp; unset RUSTFLAGS
O=/home/agent/bench-hashes-validation/round-up-i7
cd /home/agent/BLAKE3-m3 && git checkout -q candidate/devon-round-up-lanes && git log --oneline -1 | cut -c1-70
cd /home/agent/bench-0194; s=$(date +%s)
cargo run -q --release -- check --fork /home/agent/BLAKE3-m3 --against a2651d64 --when-quiet --keep $O/check > $O/check.stdout.txt 2> $O/check.stderr.txt
echo "== check exit $? in $(( $(date +%s) - s )) s $(date -u +%H:%M)"
git checkout -q -- Cargo.lock 2>/dev/null
