#!/bin/sh
# The release's slower cells, by name (CONTRIBUTING, "When a check reads a cell slower"):
# arm A repeats them across the pin jump; arm B asks the topology change alone.
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O="$HOME/runs/slower-cells-023-v2"
export O
if [ "${BOUNDED_SLOWER_CELLS:-}" != yes ]; then
  export BOUNDED_SLOWER_CELLS=yes
  status=0
  timeout --kill-after=30s 10800s sh "$O/run.sh" || status=$?
  printf 'SLOWER_CELLS_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
  exit "$status"
fi
export CARGO_BUILD_JOBS=8 CARGO_INCREMENTAL=0
unset CARGO_TARGET_DIR RUSTFLAGS CARGO_ENCODED_RUSTFLAGS
B="$HOME/work/bench-release-023"
M="$HOME/work/lib-release-023"
NEW=7048303103c69b8609ffe9ca0361197ba318107c
OLDLIB=bf2da8b957f5e0c80babb57952de3e53f95c921a
OLDBENCH=d7723f110a6f519cccb2e4ab8f2a18be7a4f4d41
TOPO=3ec37f0e9d72ace57a3e094abbb5759c3f91395f
PARENT=6e498a963c5a8a2a7ddb01a86727317e277c32ec
export B M NEW OLDLIB OLDBENCH TOPO PARENT
test "$(git -C "$B" rev-parse HEAD)" = cade30fdb71682719f5fa3e586ff96146ae9fc25
cd "$B"
P='256 B,512 B,1 KiB,2304 B,32 MiB,64 MiB,128 MiB,idle 32 MiB,idle 128 MiB,brief idle 32 MiB,brief idle 128 MiB,idle 1,collection Nix files,lent 64 MiB'
printf 'points: %s\n' "$P" > "$O/scope.txt"
./target/release/bench-hashes check --fork "$M" --new "$NEW" --against "$OLDLIB" \
    --old-bench "$OLDBENCH" --points "$P" --when-quiet --keep "$O/kept-repeat" \
    > "$O/repeat.stdout.txt" 2> "$O/repeat.stderr.txt" || printf 'repeat exit %s\n' "$?" >> "$O/verdicts.txt"
./target/release/bench-hashes check --fork "$M" --new "$TOPO" --against "$PARENT" \
    --points "$P" --when-quiet --keep "$O/kept-topology" \
    > "$O/topology.stdout.txt" 2> "$O/topology.stderr.txt" || printf 'topology exit %s\n' "$?" >> "$O/verdicts.txt"
printf 'DONE %s\n' "$(date -u +%FT%TZ)"
