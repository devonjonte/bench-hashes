#!/bin/sh
set -eu
NAME=probe-578-lent-vs-msg
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
git -C "$BASE/BLAKE3" fetch origin 2557d53c772edfa2f3eeb28b8c8827919a27d608 2f872aa4144cb0c54cefcd7dd48cc5735ff47167 694774abb829260cec8b703e9faf6d65909b5187 207862df06b07e9c4819d3d90fab5dc21a46205b

cd "$BASE/bench-hashes"
cargo build --release --locked --bin bench-hashes
BIN="$BASE/bench-hashes/target/release/bench-hashes"
CELLS="blake3-servil-mt|continuous 64 B;blake3-servil-mt|continuous 128 B;blake3-servil-mt|continuous lent 64 B"

run_leg() {
  leg="$1"
  new="$2"
  echo "=== LEG $leg: 2557d53c772edfa2f3eeb28b8c8827919a27d608 -> $new ==="
  out="$BASE/$leg"
  rm -rf "$out"
  mkdir -p "$out"
  set +e
  "$BIN" check --fork "$BASE/BLAKE3" --against 2557d53c772edfa2f3eeb28b8c8827919a27d608 --new "$new" \
    --cells "$CELLS" \
    --layouts 12 \
    --when-quiet \
    --keep "$out"
  rc=$?
  set -e
  echo "LEG $leg EXIT=$rc"
  "$BIN" compare --markdown "$out"/run-*-old.tsv -- "$out"/run-*-new.tsv || true
  echo ""
}

run_leg p1_idxring_vecdeque_events 2f872aa4144cb0c54cefcd7dd48cc5735ff47167
run_leg p2_idxring_opt_events 694774abb829260cec8b703e9faf6d65909b5187
run_leg p3_0110_maybeuninit_ring 207862df06b07e9c4819d3d90fab5dc21a46205b
