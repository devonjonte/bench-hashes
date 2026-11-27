#!/bin/sh
set -eu
NAME=probe-578-avx2-v2
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
git -C "$BASE/BLAKE3" fetch origin e1966b498bc769db3d51451a4ddc8188a19ed593 2557d53c772edfa2f3eeb28b8c8827919a27d608 9bd673fadcc4ff08097763a44f9e93170906489a

cd "$BASE/bench-hashes"
cargo build --release --locked --bin bench-hashes
BIN="$BASE/bench-hashes/target/release/bench-hashes"
CELLS="blake3-servil-mt|continuous 64 B;blake3-servil-mt|continuous 128 B;blake3-servil-mt|continuous 256 B"

run_leg() {
  leg="$1"
  old="$2"
  new="$3"
  echo "=== LEG $leg: $old -> $new ==="
  out="$BASE/$leg"
  rm -rf "$out"
  mkdir -p "$out"
  set +e
  "$BIN" check --fork "$BASE/BLAKE3" --against "$old" --new "$new" \
    --cells "$CELLS" \
    --layouts 16 \
    --when-quiet \
    --keep "$out"
  rc=$?
  set -e
  echo "LEG $leg EXIT=$rc"
  echo ""
}

run_leg leg1_next_to_probe 2557d53c772edfa2f3eeb28b8c8827919a27d608 9bd673fadcc4ff08097763a44f9e93170906489a
run_leg leg2_0110_to_probe e1966b498bc769db3d51451a4ddc8188a19ed593 9bd673fadcc4ff08097763a44f9e93170906489a
