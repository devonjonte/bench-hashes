#!/bin/sh
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O="$HOME/runs/outboard-tests-5de0629e"
export O
if [ "${BOUNDED_PIPELINE_TEST:-}" != yes ]; then
    export BOUNDED_PIPELINE_TEST=yes
    status=0
    timeout --kill-after=15s 1800s sh "$O/run.sh" || status=$?
    printf 'TEST_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
    exit "$status"
fi
C=5de0629e2500278c58918e05d9acfff202932f54
B="$HOME/work/bench-outboard-tests"
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
python3 -m unittest discover -s tools -p "test_*.py" > "$O/python-tests.txt" 2>&1; echo "python tests exit $?"
(cd tools/bao-reference && cargo nextest run --locked > "$O/bao-reference-tests.txt" 2>&1; echo "bao-reference tests exit $?")
printf 'DONE %s\n' "$(date -u +%FT%TZ)"
