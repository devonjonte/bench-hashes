#!/bin/sh
set -eu
WORK="$HOME/tmp-probe/probe-epyc-many1-64b-v3"
rm -rf "$WORK"
mkdir -p "$WORK"
BENCH_REPO="$HOME/bench-hashes"
BLAKE3_REPO="$HOME/BLAKE3"

if [ ! -d "$BENCH_REPO/.git" ]; then
  git clone --quiet https://github.com/servil-software-factory/bench-hashes.git "$BENCH_REPO"
fi
git -C "$BENCH_REPO" fetch origin --quiet
git -C "$BENCH_REPO" checkout --detach 3f119a507807078649d8700112994fce24666868 --quiet
cargo build --release --manifest-path "$BENCH_REPO/Cargo.toml" --quiet
BIN="$BENCH_REPO/target/release/bench-hashes"

if [ ! -d "$BLAKE3_REPO/.git" ]; then
  git clone --quiet https://github.com/servil-software-factory/BLAKE3.git "$BLAKE3_REPO"
fi
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
    --cells "blake3-servil-st|1;blake3-servil-st|continuous lent 64 B;blake3-servil-st|continuous keyed 64 B;blake3-servil-st|continuous 64 B" \
    --layouts 16 \
    --when-quiet \
    --keep "$WORK/$label"
  rc=$?
  set -e
  echo "LEG $label EXIT=$rc"
}

run_leg "leg1_7f39_to_255f" "7f392fdebc90aa362c7115cceb1824df2319102b" "255f61228773801c758aa1d1aac02be9ad3ba8ca"
run_leg "leg2_255f_to_0097" "255f61228773801c758aa1d1aac02be9ad3ba8ca" "0097c93f5d3baa95d79dcce65380cdc2336d2d3a"
run_leg "leg3_0097_to_0997" "0097c93f5d3baa95d79dcce65380cdc2336d2d3a" "0997700f35b06db27b70dc4659964561ae500038"
run_leg "leg4_e196_to_0997_confirm" "e1966b498bc769db3d51451a4ddc8188a19ed593" "0997700f35b06db27b70dc4659964561ae500038"
