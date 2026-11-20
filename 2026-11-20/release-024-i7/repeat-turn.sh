#!/bin/sh
# Declared before running (November 20, 2026, 18:38 UTC): the i7's 0.24 release check (old side bench 0.22,
# new side bench 0.24) marked three turn cells (+7.0%, +7.0%, +8.8%) and mt shared-one-cache
# ContinuousBatches 65536 (+8.5%) for 0.10.0 against 0.9.1. This repeats those points by name with ONE
# bench (0.22, 97c0fbcb) on both sides, 16 layouts a side, to tell a library cost from a difference
# between benches. A cell slower here beyond the margin is the library's.
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp CARGO_BUILD_JOBS=6 CARGO_INCREMENTAL=0; unset RUSTFLAGS CARGO_TARGET_DIR CARGO_ENCODED_RUSTFLAGS
O=/home/agent/bench-hashes-validation/release-024/i7; B=/home/agent/bench-022-plain; F=/home/agent/BLAKE3-0100
test "$(git -C $B rev-parse HEAD)" = 97c0fbcbedb8fe8f8395115647684dfde75d67a3 || exit 1
cd $B
s=$(date +%s); ./target/release/bench-hashes check --fork $F --new 2fd4ff6f643ef04f98f7a2e5f8ca0f096298827a --against 2c60420c2bccbf6073e35e668691d98520f9b096 --points "turn 1024 x 1 KiB,idle turn 1024 x 1 KiB,continuous batch 65536" --contenders blake3-servil-st,blake3-servil-mt --layouts 16 --when-quiet --keep $O/kept-repeat-turn > $O/repeat-turn-check.stdout.txt 2> $O/repeat-turn-check.stderr.txt; echo "== named repeat exit $? in $(( $(date +%s) - s )) s $(date -u +%H:%M)"
