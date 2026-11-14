#!/bin/sh
# The declared pilot is pipeline-cells/pilot-plan.md. Execute under bench-turn.
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O="$HOME/runs/pipeline-pilot-55436819"
export O
if [ "${BOUNDED_PIPELINE_JOB:-}" != yes ]; then
    export BOUNDED_PIPELINE_JOB=yes
    status=0
    timeout --kill-after=15s 2700s sh "$O/run.sh" || status=$?
    printf 'PILOT_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
    exit "$status"
fi
C=55436819e59a20eaa47a79f81e6594872ea40ff4
BASE=d1c20fdfcf75918e5a144f235a27484a3de1dc32
LIB=f62bc6ac0bc1c86861659d61ffbf4e9546bc8aec
B="$HOME/work/bench-pipeline-pilot"
M="$HOME/work/BLAKE3"
printf 'START %s\n' "$(date -u +%FT%TZ)"
git -C "$HOME/work/bench-hashes" fetch --all --tags
git -C "$M" fetch --all --tags
if [ ! -d "$B" ]; then git -C "$HOME/work/bench-hashes" worktree add --detach "$B" "$C"; fi
test -z "$(git -C "$B" status --porcelain)"
git -C "$B" checkout --detach "$C"
test "$(git -C "$B" rev-parse HEAD)" = "$C"
cd "$B"
cargo build --release --locked > "$O/build.txt" 2>&1
./target/release/bench-hashes provenance > "$O/provenance.txt"
printf 'bench %s\nbaseline %s\nlibrary %s\n' "$C" "$BASE" "$LIB" > "$O/pins.txt"
P='continuous 64 B,continuous 4 KiB,continuous 64 KiB,continuous 1 MiB,lent 64 B,lent 4 KiB,lent 64 KiB,lent 1 MiB,continuous batch 16,continuous batch 256,continuous batch 4096,lent batch 16,lent batch 256,lent batch 4096,continuous collection git objects,continuous collection Nix files,receive saturated,receive 2 μs,receive 20 μs'
printf '%s\n' "$P" > "$O/scope.txt"
for arm in samecode api-change; do
    old=$C
    [ "$arm" != api-change ] || old=$BASE
    printf 'ARM %s START %s\n' "$arm" "$(date -u +%FT%TZ)"
    status=0
    ./target/release/bench-hashes check --fork "$M" --against "$LIB" --new "$LIB" \
        --old-bench "$old" --contenders blake3-servil-mt --probe "$P" --layouts 4 \
        --keep "$O/kept-$arm" --when-quiet > "$O/$arm.stdout.txt" 2> "$O/$arm.stderr.txt" || status=$?
    printf 'ARM %s EXIT %s END %s\n' "$arm" "$status" "$(date -u +%FT%TZ)"
    [ "$status" -eq 0 ] || exit "$status"
done
