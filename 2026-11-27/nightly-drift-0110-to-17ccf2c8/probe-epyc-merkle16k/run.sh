#!/bin/sh
set -eu
WORK="$HOME/tmp-probe/probe-epyc-merkle16k"
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
    --cells "blake3-servil-mt|merkle 16384" \
    --layouts 32 \
    --when-quiet \
    --keep "$WORK/$label"
  rc=$?
  set -e
  echo "LEG $label EXIT=$rc"
}

run_leg "leg1_0997_to_6677" "0997700f35b06db27b70dc4659964561ae500038" "66772d540dbaadfe46175975f6ea3518803decc0"
run_leg "leg2_6677_to_17cc" "66772d540dbaadfe46175975f6ea3518803decc0" "17ccf2c8f5bb689ec552be1c976b54311da0c29f"
run_leg "leg3_e196_to_17cc" "e1966b498bc769db3d51451a4ddc8188a19ed593" "17ccf2c8f5bb689ec552be1c976b54311da0c29f"
