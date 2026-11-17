#!/bin/sh
# BLAKE3 #415, declared before it ran (November 17, 2026). On x86-icelake-2 the check of 9de026af
# against 70483031 (bench-hashes 0.23) marked one cell slower on its second stage:
#   blake3-servil-st|solo|IdleOneMessage|1536 B  +4.5% over 64 pairs (-11.0% to +34.9%)
# Its first stage read none slower. Here, by name (the point "idle 1536 B"), the issue's first box:
# the same pair twice, the same library on both sides between them, then 0.9.0 against `next`
# a12a4d35 (the question the release asks). What each reading would say: both arms slower and the
# control level, the library's change between those two commits; the control slower alike, or the
# arms disagreeing, link layout. Expectation: level in all four (the two commits differ by #403's
# fix, which touches no code this cell runs).
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O="$HOME/runs/idle-415"
if [ "${BOUNDED_S:-}" != yes ]; then
  export BOUNDED_S=yes
  status=0
  timeout --kill-after=30s 10800s sh "$O/run.sh" || status=$?
  printf 'IDLE_415_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
  exit "$status"
fi
export CARGO_BUILD_JOBS=8 CARGO_INCREMENTAL=0
unset CARGO_TARGET_DIR RUSTFLAGS CARGO_ENCODED_RUSTFLAGS
B="$HOME/work/bench-release-023"
M="$HOME/work/lib-release-023"
test "$(git -C "$B" rev-parse HEAD)" = cade30fdb71682719f5fa3e586ff96146ae9fc25
git -C "$M" fetch --quiet https://github.com/servil-software-factory/BLAKE3 next release/0.10.0
OLD=7048303103c69b8609ffe9ca0361197ba318107c
NEW=9de026af33c9c10002e0d99139ff5c921c4185ed
NEXT=$(git -C "$M" rev-parse 'a12a4d35^{commit}')
printf 'old %s\nnew %s\nnext %s\n' "$OLD" "$NEW" "$NEXT" > "$O/versions.txt"
cd "$B"
arm() { # NAME NEW AGAINST [extra...]
  name=$1; new=$2; against=$3; shift 3
  status=0
  ./target/release/bench-hashes check --fork "$M" --new "$new" --against "$against" "$@" \
      --points 'idle 1536 B' --when-quiet --keep "$O/kept-$name" > "$O/$name.stdout.txt" 2> "$O/$name.stderr.txt" || status=$?
  printf '%s: exit %s\n' "$name" "$status" >> "$O/arms.txt"
}
arm pair "$NEW" "$OLD"
arm control "$NEW" "$NEW"
arm pair-again "$NEW" "$OLD"
arm release "$NEXT" bf2da8b957f5e0c80babb57952de3e53f95c921a --old-bench d7723f110a6f519cccb2e4ab8f2a18be7a4f4d41
