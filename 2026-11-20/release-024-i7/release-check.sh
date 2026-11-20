#!/bin/sh
# The release comparison on the i7: 0.10.0 under bench 0.24 against 0.9.1 under bench 0.22
# (0.24 does not build against 0.9.1).
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp CARGO_BUILD_JOBS=6 CARGO_INCREMENTAL=0; unset RUSTFLAGS CARGO_TARGET_DIR CARGO_ENCODED_RUSTFLAGS
O=/home/agent/bench-hashes-validation/release-024/i7; B=/home/agent/bench-024tag; F=/home/agent/BLAKE3-0100
C=2fd4ff6f643ef04f98f7a2e5f8ca0f096298827a
cd $B
s=$(date +%s); ./target/release/bench-hashes check --fork $F --new $C --against 2c60420c2bccbf6073e35e668691d98520f9b096 --old-bench 97c0fbcbedb8fe8f8395115647684dfde75d67a3 --cells all --when-quiet --keep $O/kept-release > $O/release-check.stdout.txt 2> $O/release-check.stderr.txt; echo "== release check exit $? in $(( $(date +%s) - s )) s $(date -u +%H:%M)"
