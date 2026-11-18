#!/bin/sh
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O="$HOME/runs/one-node-tests-5348e0dd"
export O
if [ "${BOUNDED_PIPELINE_TEST:-}" != yes ]; then
    export BOUNDED_PIPELINE_TEST=yes
    status=0
    timeout --kill-after=15s 1800s sh "$O/run.sh" || status=$?
    printf 'TEST_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
    exit "$status"
fi
C=5348e0dd27a1a2093f0c506df088dda78755ac17
B="$HOME/work/bench-one-node-tests"
git -C "$HOME/work/bench-hashes" fetch --all --tags
if [ ! -d "$B" ]; then git -C "$HOME/work/bench-hashes" worktree add --detach "$B" "$C"; fi
test -z "$(git -C "$B" status --porcelain)"
git -C "$B" checkout --detach "$C"
cd "$B"
printf 'bench %s\nSTART %s\n' "$C" "$(date -u +%FT%TZ)"
# Serial compiler jobs bound memory. Debug assertions stay active, full debug
# symbols are unnecessary for these input/output contract checks.
CARGO_BUILD_JOBS=1 CARGO_PROFILE_DEV_DEBUG=0 cargo nextest run --locked > "$O/debug.txt" 2>&1
cargo nextest run --release --locked > "$O/release.txt" 2>&1
cargo fmt --check
ls /sys/devices/system/node | tr "\n" " "; echo; printf 'DONE %s\n' "$(date -u +%FT%TZ)"
