#!/bin/sh
set -eu
WORK="$HOME/tmp-probe/probe-epyc-many1-bisect"
rm -rf "$WORK"
mkdir -p "$WORK"
BENCH_REPO="$HOME/bench-hashes"
BLAKE3_REPO="$HOME/BLAKE3"

git -C "$BENCH_REPO" fetch origin --quiet
git -C "$BENCH_REPO" checkout --detach 3f119a507807078649d8700112994fce24666868 --quiet
cargo build --release --manifest-path "$BENCH_REPO/Cargo.toml" --quiet
BIN="$BENCH_REPO/target/release/bench-hashes"

git -C "$BLAKE3_REPO" fetch origin --quiet
cd "$BENCH_REPO"

run_leg() {
  label="$1"
  old="$2"
  new="$3"
  echo "=== LEG $label ($old -> $new) ==="
  set +e
  "$BIN" check \
    --fork "$BLAKE3_REPO" \
    --against "$old" \
    --new "$new" \
    --cells "blake3-servil-st|1" \
    --layouts 32 \
    --when-quiet \
    --keep "$WORK/$label"
  rc=$?
  set -e
  echo "LEG $label EXIT=$rc"
}

run_leg "leg1_e196_to_f5c5" "e1966b498bc769db3d51451a4ddc8188a19ed593" "f5c52f5e464eb675cbf9ea4f138b9698f91e1cb9"
run_leg "leg2_f5c5_to_def5" "f5c52f5e464eb675cbf9ea4f138b9698f91e1cb9" "def5e11eff984a4be4249fbdd10ff3901c5df648"
run_leg "leg3_def5_to_7f39" "def5e11eff984a4be4249fbdd10ff3901c5df648" "7f392fdebc90aa362c7115cceb1824df2319102b"
run_leg "leg4_e196_to_7f39" "e1966b498bc769db3d51451a4ddc8188a19ed593" "7f392fdebc90aa362c7115cceb1824df2319102b"
