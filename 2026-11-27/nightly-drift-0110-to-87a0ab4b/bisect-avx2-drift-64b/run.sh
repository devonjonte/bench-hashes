#!/bin/sh
set -eu
export PATH="$HOME/.cargo/bin:$PATH"

BENCH="$HOME/work/bench-drift"
FORK="$HOME/work/lib-drift"
EXE="$BENCH/target/release/bench-hashes"

git -C "$BENCH" fetch --quiet origin 3f119a507807078649d8700112994fce24666868
git -C "$BENCH" checkout --quiet --force --detach 3f119a507807078649d8700112994fce24666868
git -C "$FORK" fetch --quiet origin e1966b498bc769db3d51451a4ddc8188a19ed593 b308ba41dc6cbddb7f259bf847611850485a6fd3 6618a609b1fc018302b0115f269c1e7d7fc68669 9e18fda35a9b992e682516dee2146f51959ff5b0 87a0ab4b9f3cebfa30a791993573bfb4b128ae4e
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

run_leg leg1_011_to_pre567    e1966b498bc769db3d51451a4ddc8188a19ed593 b308ba41dc6cbddb7f259bf847611850485a6fd3
run_leg leg2_pr567_place_wake b308ba41dc6cbddb7f259bf847611850485a6fd3 6618a609b1fc018302b0115f269c1e7d7fc68669
run_leg leg3_pre_to_vecdeque  6618a609b1fc018302b0115f269c1e7d7fc68669 9e18fda35a9b992e682516dee2146f51959ff5b0
run_leg leg4_vecdeque_to_87a0 9e18fda35a9b992e682516dee2146f51959ff5b0 87a0ab4b9f3cebfa30a791993573bfb4b128ae4e
echo "BISECT DONE"
