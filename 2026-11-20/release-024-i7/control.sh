#!/bin/sh
# The control beside the i7's 0.24.0 run: one library (0.10.0), benches 0.23 and 0.24.
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp CARGO_BUILD_JOBS=6 CARGO_INCREMENTAL=0; unset RUSTFLAGS CARGO_TARGET_DIR CARGO_ENCODED_RUSTFLAGS
O=/home/agent/bench-hashes-validation/release-024/i7; B=/home/agent/bench-024tag; F=/home/agent/BLAKE3-0100
C=2fd4ff6f643ef04f98f7a2e5f8ca0f096298827a
cd $B
s=$(date +%s); ./target/release/bench-hashes check --fork $F --new $C --against $C --old-bench cade30fdb71682719f5fa3e586ff96146ae9fc25 --cells all --when-quiet --keep $O/kept-control > $O/control-check.stdout.txt 2> $O/control-check.stderr.txt; echo "== control check exit $? in $(( $(date +%s) - s )) s $(date -u +%H:%M)"
