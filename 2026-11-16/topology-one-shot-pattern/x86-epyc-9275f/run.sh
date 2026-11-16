#!/bin/sh
# BLAKE3 #401: do the topology pool's slow one-shot calls follow the other points in the
# schedule, or the call's own position? The topology change against its parent, three
# schedules: one point alone, the three large points, and the large points with small ones.
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O="$HOME/runs/topology-history-401"
if [ "${BOUNDED_HISTORY:-}" != yes ]; then
  export BOUNDED_HISTORY=yes
  status=0
  timeout --kill-after=30s 5400s sh "$O/run.sh" || status=$?
  printf 'HISTORY_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
  exit "$status"
fi
export CARGO_BUILD_JOBS=8 CARGO_INCREMENTAL=0
unset CARGO_TARGET_DIR RUSTFLAGS CARGO_ENCODED_RUSTFLAGS
B="$HOME/work/bench-release-023"
M="$HOME/work/lib-release-023"
TOPO=3ec37f0e9d72ace57a3e094abbb5759c3f91395f
PARENT=6e498a963c5a8a2a7ddb01a86727317e277c32ec
test "$(git -C "$B" rev-parse HEAD)" = cade30fdb71682719f5fa3e586ff96146ae9fc25
cd "$B"
arm() { # NAME POINTS
  status=0
  ./target/release/bench-hashes check --fork "$M" --new "$TOPO" --against "$PARENT" \
      --contenders blake3-servil-mt --points "$2" --when-quiet --keep "$O/kept-$1" \
      > "$O/$1.stdout.txt" 2> "$O/$1.stderr.txt" || status=$?
  printf '%s: points %s: exit %s\n' "$1" "$2" "$status" >> "$O/arms.txt"
}
arm alone '128 MiB'
arm large '32 MiB,64 MiB,128 MiB'
arm mixed '256 B,2304 B,32 MiB,64 MiB,128 MiB'
printf 'DONE %s\n' "$(date -u +%FT%TZ)"
