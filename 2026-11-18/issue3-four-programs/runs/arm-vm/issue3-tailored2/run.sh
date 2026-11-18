#!/bin/sh
# devonjonte/bench-hashes #3 control, declared before running (November 17, 2026).
# Same library (27eacce3) both sides; old bench d7723f11 vs current cade30fd.
# Expectation if instruments agree: no cell slower.
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
if [ "${BOUNDED_I3:-}" != yes ]; then
  export BOUNDED_I3=yes
  status=0
  timeout --kill-after=30s 7200s sh "$O/run.sh" || status=$?
  printf 'ISSUE3_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
  exit "$status"
fi
export CARGO_BUILD_JOBS=8 CARGO_INCREMENTAL=0
unset CARGO_TARGET_DIR RUSTFLAGS CARGO_ENCODED_RUSTFLAGS
B="$HOME/work/bench-release-023"; [ -d "$B" ] || { git clone -q https://github.com/servil-software-factory/bench-hashes "$B"; git -C "$B" checkout -q cade30fdb71682719f5fa3e586ff96146ae9fc25; cargo build --release --quiet --manifest-path "$B/Cargo.toml"; }
M="$HOME/work/lib-release-023"; [ -d "$M" ] || git clone -q https://github.com/servil-software-factory/BLAKE3 "$M"
test "$(git -C "$B" rev-parse HEAD)" = cade30fdb71682719f5fa3e586ff96146ae9fc25
printf 'bench cade30fdb716\nold-bench d7723f110a6f\nlibrary 27eacce3a5c2e03043f4fcd347c178a80f9d911c both sides\n' > "$O/versions.txt"
cd "$B"
status=0
./target/release/bench-hashes check --fork "$M" --new 27eacce3a5c2e03043f4fcd347c178a80f9d911c --against 27eacce3a5c2e03043f4fcd347c178a80f9d911c --old-bench d7723f110a6f519cccb2e4ab8f2a18be7a4f4d41 \
  --points '1536 B,2 KiB,3 KiB' --when-quiet --keep "$O/kept-control" \
  > "$O/control.stdout.txt" 2> "$O/control.stderr.txt" || status=$?
printf 'check exit %s\n' "$status" > "$O/exit.txt"
cat "$O/control.stdout.txt"
