#!/bin/sh
# Experiment only; added-work-plan.md declares the scope and interpretation.
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O="$HOME/runs/pipeline-added-work-7090f6b1"
export O
if [ "${BOUNDED_PIPELINE_PLANT:-}" != yes ]; then
    export BOUNDED_PIPELINE_PLANT=yes
    status=0
    timeout --kill-after=15s 1800s sh "$O/run.sh" || status=$?
    printf 'PLANT_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
    exit "$status"
fi
C=7090f6b14bd70471b2236620b856556c61ac4477
BASE=55436819e59a20eaa47a79f81e6594872ea40ff4
LIB=f62bc6ac0bc1c86861659d61ffbf4e9546bc8aec
B="$HOME/work/bench-pipeline-plant"
M="$HOME/work/BLAKE3"
printf 'START %s\n' "$(date -u +%FT%TZ)"
git -C "$HOME/work/bench-hashes" fetch --all --tags
git -C "$M" fetch --all --tags
if [ ! -d "$B" ]; then git -C "$HOME/work/bench-hashes" worktree add --detach "$B" "$C"; fi
test -z "$(git -C "$B" status --porcelain)"
git -C "$B" checkout --detach "$C"
cd "$B"
cargo nextest run --release --locked -E 'test(pipeline::tests::)' > "$O/plant-tests.txt" 2>&1
cargo build --release --locked > "$O/build.txt" 2>&1
./target/release/bench-hashes provenance > "$O/provenance.txt"
printf 'plant %s\nbaseline %s\nlibrary %s\n' "$C" "$BASE" "$LIB" > "$O/pins.txt"
P='continuous 64 B,continuous 4 KiB,continuous 64 KiB,continuous 1 MiB,lent 64 B,lent 4 KiB,lent 64 KiB,lent 1 MiB,continuous batch 16,continuous batch 256,continuous batch 4096,lent batch 16,lent batch 256,lent batch 4096,continuous collection git objects,continuous collection Nix files,receive saturated,receive 2 μs,receive 20 μs'
printf '%s\n' "$P" > "$O/scope.txt"
./target/release/bench-hashes check --fork "$M" --against "$LIB" --new "$LIB" \
    --old-bench "$BASE" --contenders blake3-servil-mt --probe "$P" --layouts 4 \
    --keep "$O/kept" --when-quiet > "$O/check.stdout.txt" 2> "$O/check.stderr.txt"
printf 'DONE %s\n' "$(date -u +%FT%TZ)"
