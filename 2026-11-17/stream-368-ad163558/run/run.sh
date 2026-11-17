#!/bin/sh
# BLAKE3 #368, declared before it ran (November 17, 2026). On the EPYC 7443 pair (96 threads) the old
# multithreaded stream of 1 MiB and 4 MiB messages read 4% to 74% slower than 0.8 where two programs
# share the machine (64 pairs). The stream is gone; the Pipeline replaces it, and bench-hashes 0.23
# measures it in the same cells. Here: 0.8.0 against `next` a12a4d35, the multithreaded contender, the
# points "continuous 1 MiB" and "continuous 4 MiB", 16 pairs, and the check's own 64 for its suspects.
# Expectation: level or faster in every scenario (the Pipeline is new machinery, and one message of
# 1 MiB reads 45% faster than 0.8 on this machine). A shared cell slower by 10% or more over the
# second stage would say #368 holds for the Pipeline too; level or faster closes its question.
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O="$HOME/runs/stream-368"
if [ "${BOUNDED_S:-}" != yes ]; then
  export BOUNDED_S=yes
  status=0
  timeout --kill-after=30s 7200s sh "$O/run.sh" || status=$?
  printf 'STREAM_368_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
  exit "$status"
fi
export CARGO_BUILD_JOBS=8 CARGO_INCREMENTAL=0
unset CARGO_TARGET_DIR RUSTFLAGS CARGO_ENCODED_RUSTFLAGS
B="$HOME/work/bench-release-023"
M="$HOME/work/lib-release-023"
test "$(git -C "$B" rev-parse HEAD)" = cade30fdb71682719f5fa3e586ff96146ae9fc25
NEW=a12a4d35
git -C "$M" fetch --quiet https://github.com/servil-software-factory/BLAKE3 next
NEW=$(git -C "$M" rev-parse "$NEW^{commit}")
C08=$(git -C "$M" rev-parse 'v0.8.0+b3c5efc7c975d903762dea809066f7c0a0603861^{commit}')
printf 'new %s\n0.8 %s\n' "$NEW" "$C08" > "$O/versions.txt"
cd "$B"
status=0
./target/release/bench-hashes check --fork "$M" --new "$NEW" --against "$C08" --old-bench 3363bee8 \
    --contenders blake3-servil-mt --points 'continuous 1 MiB,continuous 4 MiB' --layouts 16 --when-quiet \
    --keep "$O/kept" > "$O/check.stdout.txt" 2> "$O/check.stderr.txt" || status=$?
printf 'check: exit %s\n' "$status" > "$O/arms.txt"
