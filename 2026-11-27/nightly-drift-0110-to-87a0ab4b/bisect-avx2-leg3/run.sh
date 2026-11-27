#!/bin/sh
set -eu
export PATH="$HOME/.cargo/bin:$PATH"

BENCH="$HOME/work/bench-drift"
FORK="$HOME/work/lib-drift"
EXE="$BENCH/target/release/bench-hashes"

git -C "$BENCH" fetch --quiet origin 3f119a507807078649d8700112994fce24666868
git -C "$BENCH" checkout --quiet --force --detach 3f119a507807078649d8700112994fce24666868
git -C "$FORK" fetch --quiet origin 6618a609b1fc018302b0115f269c1e7d7fc68669 def5e11eff984a4be4249fbdd10ff3901c5df648 9e18fda35a9b992e682516dee2146f51959ff5b0
(cd "$BENCH" && cargo build --release --locked --quiet)

CELLS="blake3-servil-mt|continuous 64 B;blake3-servil-mt|continuous 128 B;blake3-servil-mt|continuous 256 B"

run_leg() {
  label="$1"; old="$2"; new="$3"
  keep="$PWD/kept-$label"
  rm -rf "$keep"
  echo ""
  echo "=== $label: $old -> $new ==="
  set +e
  (cd "$BENCH" && "$EXE" check --fork "$FORK" --against "$old" --new "$new" --cells "$CELLS" --layouts 16 --when-quiet --keep "$keep")
  rc=$?
  set -e
  echo "EXIT=$rc"
  if ls "$keep"/run-*-old.tsv >/dev/null 2>&1; then
    "$EXE" compare --markdown "$keep"/run-*-old.tsv -- "$keep"/run-*-new.tsv
  fi
}

run_leg leg3a_def5e11ef  6618a609b1fc018302b0115f269c1e7d7fc68669  def5e11eff984a4be4249fbdd10ff3901c5df648
run_leg leg3b_9e18fda35  def5e11eff984a4be4249fbdd10ff3901c5df648 9e18fda35a9b992e682516dee2146f51959ff5b0
echo "BISECT LEG3 DONE"
