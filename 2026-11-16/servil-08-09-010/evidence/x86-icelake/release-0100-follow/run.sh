#!/bin/sh
# After b3sum-0100-ad163558: (1) b3sum again with the 0.10.0 release commit as the base,
# so official 1.8.7 and 0.9.0 are judged against it; (2) the library's release check,
# 0.9.0 to the release commit, every cell, as bench-hashes 0.23's release check ran it.
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O="$HOME/runs/release-0100-follow"
if [ "${BOUNDED_F:-}" != yes ]; then
  export BOUNDED_F=yes
  status=0
  timeout --kill-after=30s 18000s sh "$O/run.sh" || status=$?
  printf 'FOLLOW_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
  exit "$status"
fi
export CARGO_BUILD_JOBS=8 CARGO_INCREMENTAL=0
unset CARGO_TARGET_DIR RUSTFLAGS CARGO_ENCODED_RUSTFLAGS
B="$HOME/work/bench-release-023"
M="$HOME/work/lib-release-023"
BINS="$HOME/b3sum-contenders-evolution"
NEW=ad163558bd882ca7768e59764c6588fce0f285f9
test "$(git -C "$B" rev-parse HEAD)" = cade30fdb71682719f5fa3e586ff96146ae9fc25
git -C "$M" fetch --quiet https://github.com/servil-software-factory/BLAKE3 release/0.10.0
for pair in b3sum-0.10.0:ad16355 official:official-1.8.7 b3sum-0.9.0:bf2da8b; do
  for l in 0 1 2 3; do
    bin="$BINS/b3sum-${pair#*:}-L$l"; test -x "$bin"; printf '%s=%s\n' "${pair%%:*}" "$bin"
  done
done > "$O/contenders.txt"
RUNS="$HOME/work/release-0100-follow-scratch"; rm -rf "$RUNS"; mkdir "$RUNS"; cd "$RUNS"
tr '\n' '\0' < "$O/contenders.txt" | xargs -0 "$B/target/release/bench-hashes" b3sum --files "$HOME/b3sum-bench-files" > "$O/b3sum-base-0100.stdout.txt" 2> "$O/b3sum-base-0100.stderr.txt"
cp -r benchmark-results "$O/b3sum-base-0100-results"; cd /; rm -rf "$RUNS"
printf 'B3SUM_DONE %s\n' "$(date -u +%FT%TZ)"
cd "$B"
status=0
./target/release/bench-hashes check --fork "$M" --new "$NEW" --against bf2da8b957f5e0c80babb57952de3e53f95c921a \
    --old-bench d7723f110a6f519cccb2e4ab8f2a18be7a4f4d41 --cells all --when-quiet --keep "$O/kept-release" \
    > "$O/release-check.stdout.txt" 2> "$O/release-check.stderr.txt" || status=$?
printf 'release check exit %s\n' "$status" > "$O/verdict.txt"
