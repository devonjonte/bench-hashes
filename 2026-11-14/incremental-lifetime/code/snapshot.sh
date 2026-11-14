#!/bin/sh
# Correct the pilot's display-only invocation: --points requires --contenders.
# The three completed comparisons and original exit134 remain untouched.
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O="$HOME/runs/incremental-snapshot-2c867684"
export O
if [ "${BOUNDED_SNAPSHOT:-}" != yes ]; then
    export BOUNDED_SNAPSHOT=yes
    status=0
    timeout --kill-after=15s 600s sh "$O/run.sh" || status=$?
    printf 'SNAPSHOT_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
    exit "$status"
fi
B="$HOME/work/bench-incremental-pilot"
test "$(git -C "$B" rev-parse HEAD)" = 2c8676842feab053fa7855d4cb3393bdea26ed4a
test -z "$(git -C "$B" status --porcelain)"
"$B/target/release/bench-hashes" provenance > "$O/provenance.txt"
"$B/target/release/bench-hashes" --list > "$O/contenders.txt"
"$B/target/release/bench-hashes" quiet --wait > "$O/quiet.txt" 2>&1
mkdir -p "$O/snapshot"
cd "$O/snapshot"
P='incremental 64 B,incremental 1 KiB,incremental 4 KiB,lent incremental 64 B,lent incremental 1 KiB,lent incremental 4 KiB,64 B,1 KiB,4 KiB,lent 64 B,lent 1 KiB,lent 4 KiB'
"$B/target/release/bench-hashes" --contenders blake3-servil-st,blake3-servil-mt,sha256,sha256-ring,blake3-official,blake3-official-mt,sha1dc,sha3-256 --points "$P" --rounds 24 --expect-servil f62bc6ac0bc1c86861659d61ffbf4e9546bc8aec > "$O/report.txt" 2> "$O/progress.txt"
