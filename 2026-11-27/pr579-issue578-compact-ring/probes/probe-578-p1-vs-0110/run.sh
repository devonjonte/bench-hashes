#!/bin/sh
set -eu
NAME=probe-578-p1-vs-0110
BASE="$HOME/tmp-probe/$NAME"
mkdir -p "$BASE"
if [ ! -d "$BASE/bench-hashes/.git" ]; then
  git clone https://github.com/servil-software-factory/bench-hashes.git "$BASE/bench-hashes"
fi
git -C "$BASE/bench-hashes" fetch origin 3f119a507807078649d8700112994fce24666868
git -C "$BASE/bench-hashes" checkout --detach 3f119a507807078649d8700112994fce24666868

if [ ! -d "$BASE/BLAKE3/.git" ]; then
  git clone https://github.com/servil-software-factory/BLAKE3.git "$BASE/BLAKE3"
fi
git -C "$BASE/BLAKE3" fetch origin e1966b498bc769db3d51451a4ddc8188a19ed593 2f872aa4144cb0c54cefcd7dd48cc5735ff47167

cd "$BASE/bench-hashes"
cargo build --release --locked --bin bench-hashes
BIN="$BASE/bench-hashes/target/release/bench-hashes"
CELLS="blake3-servil-mt|continuous 64 B;blake3-servil-mt|continuous 128 B;blake3-servil-mt|continuous 256 B;blake3-servil-mt|continuous lent 64 B"

out="$BASE/leg"
rm -rf "$out"
mkdir -p "$out"
set +e
"$BIN" check --fork "$BASE/BLAKE3" --against e1966b498bc769db3d51451a4ddc8188a19ed593 --new 2f872aa4144cb0c54cefcd7dd48cc5735ff47167 \
  --cells "$CELLS" \
  --layouts 16 \
  --when-quiet \
  --keep "$out"
rc=$?
set -e
echo "P1_VS_0110 EXIT=$rc"
"$BIN" compare --markdown "$out"/run-*-old.tsv -- "$out"/run-*-new.tsv || true
