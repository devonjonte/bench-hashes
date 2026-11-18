#!/bin/sh
# BLAKE3 #447, declared before running (November 18, 2026, UTC): the release's speed check with one
# bench-hashes on both sides. bench-hashes 0.22 (97c0fbcb) builds both libraries: 0.10.0's version commit
# 477d479e against 0.9.0 (bf2da8b9), every cell that bench has, check's own rule. Expectation where the
# two-bench marks were the method's: no cell slower.
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
if [ "${BOUNDED_447:-}" != yes ]; then
  export BOUNDED_447=yes
  status=0
  timeout --kill-after=30s 9000s sh "$0" || status=$?
  printf 'ONEBENCH_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
  exit "$status"
fi
export CARGO_BUILD_JOBS=8 CARGO_INCREMENTAL=0
unset CARGO_TARGET_DIR RUSTFLAGS CARGO_ENCODED_RUSTFLAGS
R="$HOME/work/bench-release-023"
B="$HOME/work/bench-022"
M="$HOME/work/lib-release-023"
BENCH=97c0fbcbedb8fe8f8395115647684dfde75d67a3
NEW=477d479e272a869f9480888bbe8db19da1bd1bb4
OLD=bf2da8b957f5e0c80babb57952de3e53f95c921a
date -u +%FT%TZ > "$O/started.txt"
if [ ! -d "$B" ]; then
  git -C "$R" cat-file -e "$BENCH^{commit}" 2> /dev/null || git -C "$R" fetch -q origin
  git -C "$R" worktree add -q --detach "$B" "$BENCH"
fi
git -C "$B" checkout -q --detach "$BENCH" 2> /dev/null || true
test "$(git -C "$B" rev-parse HEAD)" = "$BENCH"
(cd "$B" && cargo build --release --quiet) > "$O/bench-build.txt" 2>&1
git -C "$M" cat-file -e "$NEW^{commit}" 2> /dev/null || git -C "$M" fetch -q origin
git -C "$M" cat-file -e "$NEW^{commit}"
git -C "$M" cat-file -e "$OLD^{commit}"
printf 'bench-hashes %s both sides\nold library %s\nnew library %s\n' "$BENCH" "$OLD" "$NEW" > "$O/versions.txt"
cd "$B"
status=0
./target/release/bench-hashes check --fork "$M" --new "$NEW" --against "$OLD" --cells all --when-quiet \
  --keep "$O/kept-release" > "$O/release.stdout.txt" 2> "$O/release.stderr.txt" || status=$?
printf 'check exit %s\n' "$status" > "$O/exit.txt"
date -u +%FT%TZ > "$O/finished.txt"
tail -40 "$O/release.stdout.txt"
