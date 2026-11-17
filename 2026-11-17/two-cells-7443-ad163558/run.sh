#!/bin/sh
# BLAKE3 #402, declared before it ran (November 17, 2026). On the EPYC 7443 pair the release check
# 0.9.0 -> ad163558 read "no cell slower". Two cells that its second look measured beside its suspects
# read slower over 64 pairs, where its first look (4 pairs, the whole benchmark) read them level:
#   blake3-servil-st|solo|MerkleTree|1048576 x 32 B   first x0.987, second x1.050 (8 of 64 pairs faster)
#   blake3-servil-mt|solo|IdleOneMessage|3839 B       first x0.986, second x1.082 (20 of 64 pairs faster)
# The check judges its suspects alone on the second look, so its verdict leaves these two out.
# Here, by name (the points "1048576 x 32 B" and "3839 B"): the release arm, the same library under
# both benches (the bench's own share), and the release arm again, as small-405 did for #405.
# What each reading would say: both release arms slower and the control level, the library's; the
# control slower alike, the bench's or the selected cells' context; the arms disagreeing, link layout.
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O="$HOME/runs/two-cells-7443-v3"
if [ "${BOUNDED_S:-}" != yes ]; then
  export BOUNDED_S=yes
  status=0
  timeout --kill-after=30s 9000s sh "$O/run.sh" || status=$?
  printf 'TWO_CELLS_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
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
      --points 'merkle 1048576 x 32 B,idle 3839 B' --when-quiet --keep "$O/kept-$1" > "$O/$1.stdout.txt" 2> "$O/$1.stderr.txt" || status=$?
  printf '%s: exit %s\n' "$1" "$status" >> "$O/arms.txt"
}
arm release bf2da8b957f5e0c80babb57952de3e53f95c921a
arm control "$NEW"
arm release-again bf2da8b957f5e0c80babb57952de3e53f95c921a
