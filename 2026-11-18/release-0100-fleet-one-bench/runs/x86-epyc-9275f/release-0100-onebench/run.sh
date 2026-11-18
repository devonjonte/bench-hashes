#!/bin/sh
# BLAKE3 #402 and #447, declared before running (November 18, 2026, UTC): the release's speed check with
# one bench-hashes on both sides, on the x86-64 fleet, for the release page's library evidence.
# bench-hashes 0.22 (97c0fbcb) builds both libraries: 0.10.0's version commit 477d479e against 0.9.0
# (bf2da8b9), every cell that bench has, check's own rule (margin 3% in that bench; the page reads the
# marks beyond 5%, the margin since November 18). On a machine with two memory nodes the whole check
# runs under numactl's bind to node 0 (bench 0.22 does not keep itself to one node); without numactl
# there, the run stops and says so.
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
export CARGO_BUILD_JOBS=16 CARGO_INCREMENTAL=0
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
PREFIX=
if [ -d /sys/devices/system/node/node1 ]; then
  command -v numactl > /dev/null 2>&1 || { echo "two memory nodes and no numactl: not run" | tee "$O/exit.txt"; exit 4; }
  PREFIX="numactl --cpunodebind=0 --membind=0"
fi
{ ls /sys/devices/system/node | tr '\n' ' '; echo; echo "prefix: $PREFIX"; uname -srm; } > "$O/machine.txt"
status=0
$PREFIX ./target/release/bench-hashes check --fork "$M" --new "$NEW" --against "$OLD" --cells all --when-quiet \
  --keep "$O/kept-release" > "$O/release.stdout.txt" 2> "$O/release.stderr.txt" || status=$?
printf 'check exit %s\n' "$status" > "$O/exit.txt"
date -u +%FT%TZ > "$O/finished.txt"
tail -40 "$O/release.stdout.txt"
