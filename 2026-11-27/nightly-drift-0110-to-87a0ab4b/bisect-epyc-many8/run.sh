#!/bin/sh
set -eu
export PATH="$HOME/.cargo/bin:$PATH"

BENCH="$HOME/work/bench-drift"
FORK="$HOME/work/lib-drift"
EXE="$BENCH/target/release/bench-hashes"

git -C "$BENCH" fetch --quiet origin 3f119a507807078649d8700112994fce24666868
git -C "$BENCH" checkout --quiet --force --detach 3f119a507807078649d8700112994fce24666868
git -C "$FORK" fetch --quiet origin e1966b498bc769db3d51451a4ddc8188a19ed593 6618a609b1fc018302b0115f269c1e7d7fc68669 def5e11eff984a4be4249fbdd10ff3901c5df648 d332acb52bd38ed2f758087efca2e5d520db7c2d 093de3aedf3ff528f233655358996be9dc11fdc7
(cd "$BENCH" && cargo build --release --locked --quiet)

CELLS="blake3-servil-st|8"

run_leg() {
  label="$1"; old="$2"; new="$3"
  keep="$PWD/kept-$label"
  rm -rf "$keep"
  echo ""
  echo "=== $label: $old -> $new ==="
  set +e
  (cd "$BENCH" && "$EXE" check --fork "$FORK" --against "$old" --new "$new" --cells "$CELLS" --layouts 32 --when-quiet --keep "$keep")
  rc=$?
  set -e
  echo "EXIT=$rc"
  if ls "$keep"/run-*-old.tsv >/dev/null 2>&1; then
    "$EXE" compare --markdown "$keep"/run-*-old.tsv -- "$keep"/run-*-new.tsv
  fi
}

run_leg leg1_011_to_pre_def5   e1966b498bc769db3d51451a4ddc8188a19ed593 6618a609b1fc018302b0115f269c1e7d7fc68669
run_leg leg2_def5e11ef         6618a609b1fc018302b0115f269c1e7d7fc68669 def5e11eff984a4be4249fbdd10ff3901c5df648
run_leg leg3_def5_to_d332      def5e11eff984a4be4249fbdd10ff3901c5df648 d332acb52bd38ed2f758087efca2e5d520db7c2d
run_leg leg4_011_to_next_093d  e1966b498bc769db3d51451a4ddc8188a19ed593 093de3aedf3ff528f233655358996be9dc11fdc7
echo "BISECT DONE"
