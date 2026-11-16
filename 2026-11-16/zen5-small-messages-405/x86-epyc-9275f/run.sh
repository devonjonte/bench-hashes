#!/bin/sh
# BLAKE3 #405: one message of 256 B, 512 B and 1 KiB by name, the 0.10.0 release commit
# against 0.9.0 (each under its own bench, as the release check), then the same library
# under both benches, which shows the bench's own share.
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O="$HOME/runs/small-405"
if [ "${BOUNDED_S:-}" != yes ]; then
  export BOUNDED_S=yes
  status=0
  timeout --kill-after=30s 7200s sh "$O/run.sh" || status=$?
  printf 'SMALL_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
  exit "$status"
fi
export CARGO_BUILD_JOBS=8 CARGO_INCREMENTAL=0
unset CARGO_TARGET_DIR RUSTFLAGS CARGO_ENCODED_RUSTFLAGS
B="$HOME/work/bench-release-023"
M="$HOME/work/lib-release-023"
test "$(git -C "$B" rev-parse HEAD)" = cade30fdb71682719f5fa3e586ff96146ae9fc25
NEW=ad163558bd882ca7768e59764c6588fce0f285f9
git -C "$M" fetch --quiet https://github.com/servil-software-factory/BLAKE3 release/0.10.0
cd "$B"
arm() { # NAME AGAINST
  status=0
  ./target/release/bench-hashes check --fork "$M" --new "$NEW" --against "$2" --old-bench d7723f110a6f519cccb2e4ab8f2a18be7a4f4d41 \
      --points '256 B,512 B,1 KiB' --when-quiet --keep "$O/kept-$1" > "$O/$1.stdout.txt" 2> "$O/$1.stderr.txt" || status=$?
  printf '%s: exit %s\n' "$1" "$status" >> "$O/arms.txt"
}
arm release bf2da8b957f5e0c80babb57952de3e53f95c921a
arm control "$NEW"
arm release-again bf2da8b957f5e0c80babb57952de3e53f95c921a
