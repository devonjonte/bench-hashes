#!/bin/sh
# bench-hashes #3 with icache counts (samples v11), declared Nov 17, 2026.
# Same control as before (candidate both sides, old bench d7723f11 against the
# new bench at de0fc77bd): now each sample also carries L1I demand misses.
# Read: do the slow layouts/cells show more icache misses a call at equal
# instructions?
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O="$HOME/runs/issue3-icache-avx2"
if [ "${BOUNDED_I:-}" != yes ]; then
  export BOUNDED_I=yes
  status=0
  timeout --kill-after=30s 7200s sh "$O/run.sh" || status=$?
  printf 'ICACHE_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
  exit "$status"
fi
export CARGO_BUILD_JOBS=16 CARGO_INCREMENTAL=0
unset CARGO_TARGET_DIR RUSTFLAGS CARGO_ENCODED_RUSTFLAGS
B="$HOME/work/bench-icache"
[ -d "$B" ] || git clone -q https://github.com/devonjonte/bench-hashes "$B"
git -C "$B" fetch -q origin probe/devon-icache-counts
git -C "$B" checkout -q de0fc77bdbabeb65c061d6da8205a2b3a6d7e6c5
test "$(git -C "$B" rev-parse HEAD)" = de0fc77bdbabeb65c061d6da8205a2b3a6d7e6c5
M="$HOME/work/lib-release-023"
printf 'bench de0fc77bdbab (icache counts)\nold-bench d7723f110a6f\nlibrary 27eacce3 both sides\n' > "$O/versions.txt"
cd "$B"
cargo build --release --quiet > "$O/build.log" 2>&1
status=0
./target/release/bench-hashes check --fork "$M" --new 27eacce3a5c2e03043f4fcd347c178a80f9d911c --against 27eacce3a5c2e03043f4fcd347c178a80f9d911c --old-bench d7723f110a6f519cccb2e4ab8f2a18be7a4f4d41 \
  --points 'idle 64 B,idle 128 B,idle 256 B,64 B,128 B' --when-quiet --keep "$O/kept" \
  > "$O/control.stdout.txt" 2> "$O/control.stderr.txt" || status=$?
printf 'check exit %s\n' "$status" > "$O/exit.txt"
cat "$O/control.stdout.txt"
