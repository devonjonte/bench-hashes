#!/bin/sh
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O="$HOME/runs/incremental-shared-followup-2c867684"
export O
if [ "${BOUNDED_SHARED_FOLLOWUP:-}" != yes ]; then
    export BOUNDED_SHARED_FOLLOWUP=yes
    status=0
    timeout --kill-after=15s 1800s sh "$O/run.sh" || status=$?
    printf 'FOLLOWUP_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
    exit "$status"
fi
B="$HOME/work/bench-incremental-pilot"
M="$HOME/work/BLAKE3"
C=2c8676842feab053fa7855d4cb3393bdea26ed4a
LIB=f62bc6ac0bc1c86861659d61ffbf4e9546bc8aec
test "$(git -C "$B" rev-parse HEAD)" = "$C"
test -z "$(git -C "$B" status --porcelain)"
cd "$B"
P='64 B,4 KiB,continuous 1 MiB,receive saturated,lent 64 B,lent 4 KiB,continuous collection git objects'
for name in samecode-common harness-repeat; do
    old=$C
    [ "$name" != harness-repeat ] || old=8d9eb92ada887ed57b4d2102d3f913344067f84a
    printf 'ARM %s START %s\n' "$name" "$(date -u +%FT%TZ)"
    ./target/release/bench-hashes check --fork "$M" --against "$LIB" --new "$LIB" \
        --old-bench "$old" --probe "$P" --layouts 4 --when-quiet --keep "$O/kept-$name" \
        > "$O/$name.stdout.txt" 2> "$O/$name.stderr.txt"
    printf 'ARM %s DONE %s\n' "$name" "$(date -u +%FT%TZ)"
done
