#!/bin/sh
# devonjonte/bench-hashes #3, declared before running (November 17, 2026).
# One bench (0.22, d7723f11) on both sides: candidate 27eacce3 against 0.9.0 bf2da8b9,
# the small one-message points where the two-bench release check reported marks.
# Expectation: if those marks were the bench difference, no cell slower here.
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
if [ "${BOUNDED_I3:-}" != yes ]; then
  export BOUNDED_I3=yes
  status=0
  timeout --kill-after=30s 7200s sh "$O/run.sh" || status=$?
  printf 'ONEBENCH_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
  exit "$status"
fi
export CARGO_BUILD_JOBS=8 CARGO_INCREMENTAL=0
unset CARGO_TARGET_DIR RUSTFLAGS CARGO_ENCODED_RUSTFLAGS
B="$HOME/work/bench-022"
M="$HOME/work/lib-release-023"
test "$(git -C "$B" rev-parse HEAD)" = 97c0fbcbedb8fe8f8395115647684dfde75d67a3
printf 'one bench d7723f110a6f both sides\nold library bf2da8b957f5e0c80babb57952de3e53f95c921a\nnew library 27eacce3a5c2e03043f4fcd347c178a80f9d911c\n' > "$O/versions.txt"
cd "$B"
status=0
./target/release/bench-hashes check --fork "$M" --new 27eacce3a5c2e03043f4fcd347c178a80f9d911c --against bf2da8b957f5e0c80babb57952de3e53f95c921a \
  --points 'idle 64 B,idle 128 B,idle 256 B,64 B,128 B' --when-quiet --keep "$O/kept-onebench" \
  > "$O/onebench.stdout.txt" 2> "$O/onebench.stderr.txt" || status=$?
printf 'check exit %s\n' "$status" > "$O/exit.txt"
cat "$O/onebench.stdout.txt"
