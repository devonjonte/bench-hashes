#!/bin/sh
# probe/l3-pool (9c25ed9e) against its parent servil 09d3bbc6 on the i7 (one L3 domain: expected level), bench 0.19.7, every cell.
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp; unset RUSTFLAGS
O=/home/agent/bench-hashes-validation/l3-i7
cd /home/agent/bench-0194 && git fetch -q john && git checkout -q --detach john/main
s=$(date +%s); cargo run -q --release -- check --fork /home/agent/BLAKE3-l3 --against 09d3bbc6d07e --cells all --keep $O/check > $O/check.stdout.txt 2> $O/check.stderr.txt; echo "check exit $? in $(( $(date +%s) - s )) s"
