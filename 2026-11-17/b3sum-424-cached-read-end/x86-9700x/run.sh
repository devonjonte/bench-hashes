#!/bin/sh
# BLAKE3 #424, declared before it ran (November 17, 2026). The candidate b3sum-fail-stop (a17ad8d1) ends a
# cached file at the size read when it was opened. c1a93ec3 (devonjonte, candidate/devon-424-cached-read-end)
# keeps that shortcut only where the size is no multiple of the page size, so a cached file of whole pages
# costs one more read without waiting. The benchmark's small files are 16 KiB each, whole pages: its warm
# small-file inputs pay that read for every file. What does it cost?
# b3sum at both commits in the same rounds, four layouts a side, the full inputs and then the quick ones
# (the hundred-file run). Expected: the warm thousand and hundred 16 KiB files up to 5% longer, since a
# read that returns 0 is a fraction of a microsecond beside a file's few microseconds; every other input level.
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O="$HOME/runs/b3sum-424"
if [ "${BOUNDED_R:-}" != yes ]; then
  export BOUNDED_R=yes
  status=0
  timeout --kill-after=30s 7200s sh "$O/run.sh" || status=$?
  printf 'B3SUM_424_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
  exit "$status"
fi
export CARGO_BUILD_JOBS=8 CARGO_INCREMENTAL=0
unset CARGO_TARGET_DIR RUSTFLAGS CARGO_ENCODED_RUSTFLAGS
B="$HOME/work/bench-release-023"
M="$HOME/work/lib-release-023"
test "$(git -C "$B" rev-parse HEAD)" = cade30fdb71682719f5fa3e586ff96146ae9fc25
NEW=c1a93ec3a77f602c3c16d5914949a608f768d094
git -C "$M" fetch --quiet https://github.com/devonjonte/BLAKE3 candidate/devon-424-cached-read-end > "$O/fetch.log" 2>&1
test "$(git -C "$M" rev-parse FETCH_HEAD)" = "$NEW"
OLD=$(git -C "$M" rev-parse "$NEW^")
printf 'bench cade30fdb716\nold %s\nnew %s\n' "$OLD" "$NEW" > "$O/versions.txt"
cd "$B"
# The folder of the release runs: official b3sum is built there already, and each commit is built once.
BINS="$HOME/b3sum-contenders-evolution"
LAYOUTS=4 python3 tools/b3sum-contenders.py "$M" "$BINS" "$OLD" "$NEW" > "$O/contenders-raw.txt" 2> "$O/contenders.log"
so=$(printf %s "$OLD" | cut -c1-7); sn=$(printf %s "$NEW" | cut -c1-7)
{ grep "^b3sum-$so=" "$O/contenders-raw.txt" | sed "s/^b3sum-$so=/b3sum-a17ad8d1=/"
  grep "^b3sum-$sn=" "$O/contenders-raw.txt" | sed "s/^b3sum-$sn=/b3sum-c1a93ec3=/"; } > "$O/contenders.txt"
test "$(wc -l < "$O/contenders.txt")" -eq 8
for mode in full quick; do
  RUNS="$HOME/work/b3sum-424-scratch-$mode"; rm -rf "$RUNS"; mkdir "$RUNS"; cd "$RUNS"
  flag=""; [ "$mode" = quick ] && flag="--quick"
  tr '\n' '\0' < "$O/contenders.txt" | xargs -0 "$B/target/release/bench-hashes" b3sum --files "$HOME/b3sum-bench-files" $flag > "$O/b3sum-$mode.stdout.txt" 2> "$O/b3sum-$mode.stderr.txt"
  cp -r benchmark-results "$O/b3sum-$mode-results"; cd /; rm -rf "$RUNS"
  printf '%s done %s\n' "$mode" "$(date -u +%FT%TZ)"
done
