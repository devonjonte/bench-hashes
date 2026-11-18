#!/bin/sh
# bench-hashes #237 pilot, declared before it ran (November 18, 2026): the same pilot on the pull
# request rebased onto next (5de0629e), whose report now says why a cache state is missing.
# Purpose: exercise the new end-to-end outboard cells at the 0.10.0 candidate,
# not to make a release acceptance claim. Expected: the warm run contains only
# 1 MiB, the mixed 1000-file tree and 1 GiB; the cold run contains only 1 GiB;
# every contender exits successfully; each Servil outboard form leaves one
# 1 GiB outboard of exactly 64 * (65536 - 1) = 4,194,240 bytes at the final cell.
# The five requested cells are the three warm inputs at their named thread
# budgets plus the large cold cell. Five rounds are a pilot, not the default 15.
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
if [ "${BOUNDED_B:-}" != yes ]; then
  export BOUNDED_B=yes
  status=0
  timeout --kill-after=30s 5400s sh "$0" || status=$?
  printf 'OUTBOARD_PILOT_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
  exit "$status"
fi
export CARGO_BUILD_JOBS=8 CARGO_INCREMENTAL=0
unset CARGO_TARGET_DIR RUSTFLAGS CARGO_ENCODED_RUSTFLAGS
BASE="$HOME/work/bench-release-023"
M="$HOME/work/lib-release-023"
BC=5de0629e2500278c58918e05d9acfff202932f54
C10=27eacce3a5c2e03043f4fcd347c178a80f9d911c
git -C "$BASE" fetch --quiet origin probe/devon-bao-outboard
test "$(git -C "$BASE" rev-parse FETCH_HEAD)" = "$BC"
B="$HOME/work/bench-outboard-pilot"
if [ ! -d "$B" ]; then git -C "$BASE" worktree add --quiet --detach "$B" "$BC"; fi
git -C "$B" checkout -q --detach "$BC"; test "$(git -C "$B" rev-parse HEAD)" = "$BC"
git -C "$M" cat-file -e "$C10^{commit}"
printf 'bench %s\nb3sum %s\n' "$BC" "$C10" > "$O/versions.txt"
cd "$B"
cargo build --locked --release > "$O/bench-build.stdout.txt" 2> "$O/bench-build.stderr.txt"
BIN="$B/target/release/bench-hashes"
BINS="$HOME/b3sum-contenders-outboard-gate"
LAYOUTS=4 python3 tools/b3sum-contenders.py --outboard "$M" "$BINS" "$C10" > "$O/contenders-raw.txt" 2> "$O/contenders.log"
{ grep '^official=' "$O/contenders-raw.txt"; grep '^b3sum' "$O/contenders-raw.txt"; } > "$O/contenders.txt"
RUNS="$HOME/work/bao-outboard-gate-scratch"
rm -rf "$RUNS"; mkdir -p "$RUNS/warm" "$RUNS/cold"
"$BIN" quiet --wait > "$O/quiet.txt"
cd "$RUNS/warm"
tr '\n' '\0' < "$O/contenders.txt" | xargs -0 "$BIN" b3sum --files "$HOME/b3sum-bench-files" --rounds 5 --cache warm --input '1 MiB' --input 'mixed tree, 1000 files, 74 MiB' --input '1 GiB' > "$O/warm.stdout.txt" 2> "$O/warm.stderr.txt"
cp -r benchmark-results "$O/warm-results"
for name in b3sum-outboard b3sum-outboard-1-thread; do
  count=$(find "b3sum-out/$name" -type f -name '*.obao4' | wc -l)
  bytes=$(find "b3sum-out/$name" -type f -name '*.obao4' -printf '%s\n')
  printf 'warm %s files=%s bytes=%s\n' "$name" "$count" "$bytes" >> "$O/outboard-checks.txt"
  test "$count" -eq 1; test "$bytes" -eq 4194240
done
"$BIN" quiet --wait >> "$O/quiet.txt"
cd "$RUNS/cold"
tr '\n' '\0' < "$O/contenders.txt" | xargs -0 "$BIN" b3sum --files "$HOME/b3sum-bench-files" --rounds 5 --cache cold --input '1 GiB' > "$O/cold.stdout.txt" 2> "$O/cold.stderr.txt"
cp -r benchmark-results "$O/cold-results"
for name in b3sum-outboard b3sum-outboard-1-thread; do
  count=$(find "b3sum-out/$name" -type f -name '*.obao4' | wc -l)
  bytes=$(find "b3sum-out/$name" -type f -name '*.obao4' -printf '%s\n')
  printf 'cold %s files=%s bytes=%s\n' "$name" "$count" "$bytes" >> "$O/outboard-checks.txt"
  test "$count" -eq 1; test "$bytes" -eq 4194240
done
rm -rf "$RUNS"
