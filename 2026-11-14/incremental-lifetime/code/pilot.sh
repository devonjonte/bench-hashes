#!/bin/sh
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O="$HOME/runs/incremental-pilot-2c867684"
export O
if [ "${BOUNDED_INCREMENTAL:-}" != yes ]; then
    export BOUNDED_INCREMENTAL=yes
    status=0
    timeout --kill-after=15s 3600s sh "$O/run.sh" || status=$?
    printf 'PILOT_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
    exit "$status"
fi
C=2c8676842feab053fa7855d4cb3393bdea26ed4a
BASE=8d9eb92ada887ed57b4d2102d3f913344067f84a
LIB=f62bc6ac0bc1c86861659d61ffbf4e9546bc8aec
B="$HOME/work/bench-incremental-pilot"
M="$HOME/work/BLAKE3"
git -C "$HOME/work/bench-hashes" fetch --all --tags
git -C "$M" fetch --all --tags
if [ ! -d "$B" ]; then git -C "$HOME/work/bench-hashes" worktree add --detach "$B" "$C"; fi
test -z "$(git -C "$B" status --porcelain)"
git -C "$B" checkout --detach "$C"
cd "$B"
cargo build --release --locked > "$O/build.txt" 2>&1
./target/release/bench-hashes provenance > "$O/provenance.txt"
SHORT='incremental 64 B,incremental 1 KiB,incremental 4 KiB,lent incremental 64 B,lent incremental 1 KiB,lent incremental 4 KiB,64 B,1 KiB,4 KiB,lent 64 B,lent 1 KiB,lent 4 KiB'
COMMON='64 B,4 KiB,continuous 1 MiB,receive saturated,lent 64 B,lent 4 KiB,continuous collection git objects'
printf 'candidate=%s\nbaseline=%s\nlibrary=%s\nshort=%s\ncommon=%s\n' "$C" "$BASE" "$LIB" "$SHORT" "$COMMON" > "$O/scope.txt"
check() {
    name=$1; oldbench=$2; oldlib=$3; newlib=$4; scope=$5
    printf 'ARM %s START %s\n' "$name" "$(date -u +%FT%TZ)"
    status=0
    ./target/release/bench-hashes check --fork "$M" --against "$oldlib" --new "$newlib" \
        --old-bench "$oldbench" --probe "$scope" --layouts 4 --when-quiet \
        --keep "$O/kept-$name" > "$O/$name.stdout.txt" 2> "$O/$name.stderr.txt" || status=$?
    printf 'ARM %s EXIT %s END %s\n' "$name" "$status" "$(date -u +%FT%TZ)"
    [ "$status" -eq 0 ] || exit "$status"
}
check samecode "$C" "$LIB" "$LIB" "$SHORT"
check harness "$BASE" "$LIB" "$LIB" "$COMMON"
check finalize "$C" c5d8331c7c3c89ac4890693f0c096336291d2639 0932d4a610e2dcc96e16af424f8d75d12cd4b360 "$SHORT"
./target/release/bench-hashes quiet --wait > "$O/snapshot-quiet.txt" 2>&1
mkdir -p "$O/snapshot"
cd "$O/snapshot"
"$B/target/release/bench-hashes" --all --points "$SHORT" --rounds 24 --expect-servil "$LIB" > "$O/snapshot.stdout.txt" 2> "$O/snapshot.stderr.txt"
printf 'DONE %s\n' "$(date -u +%FT%TZ)"
