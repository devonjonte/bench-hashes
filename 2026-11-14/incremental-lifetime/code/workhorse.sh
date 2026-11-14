#!/bin/sh
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O="$HOME/runs/incremental-tests-2c867684"
export O
if [ "${BOUNDED_INCREMENTAL_TEST:-}" != yes ]; then
    export BOUNDED_INCREMENTAL_TEST=yes
    status=0
    timeout --kill-after=15s 1800s sh "$O/run.sh" || status=$?
    printf 'TEST_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
    exit "$status"
fi
C=2c8676842feab053fa7855d4cb3393bdea26ed4a
B="$HOME/work/bench-incremental-tests"
git -C "$HOME/work/bench-hashes" fetch --all --tags
if [ ! -d "$B" ]; then git -C "$HOME/work/bench-hashes" worktree add --detach "$B" "$C"; fi
test -z "$(git -C "$B" status --porcelain)"
git -C "$B" checkout --detach "$C"
cd "$B"
printf 'START %s bench=%s\n' "$(date -u +%FT%TZ)" "$C"
CARGO_BUILD_JOBS=1 CARGO_PROFILE_DEV_DEBUG=0 cargo nextest run --locked -E 'test(incremental::tests::) | test(receive::tests::)' > "$O/debug.txt" 2>&1
CARGO_BUILD_JOBS=2 cargo nextest run --release --locked > "$O/release.txt" 2>&1
cargo fmt --check
printf 'DONE %s\n' "$(date -u +%FT%TZ)"
