#!/bin/sh
set -eu
NAME=probe-578-p4-p5-p3
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
git -C "$BASE/BLAKE3" fetch origin e1966b498bc769db3d51451a4ddc8188a19ed593 2557d53c772edfa2f3eeb28b8c8827919a27d608 0ad1ebc79e349b0330b65f828c56dd0c664742b0 b3011810757fa9a3ac7fb1b51e0a57f26d365a68 2b123e0ef1c2d1b5643093430669f8d21ce3d155

cd "$BASE/bench-hashes"
cargo build --release --locked --bin bench-hashes
BIN="$BASE/bench-hashes/target/release/bench-hashes"
CELLS="blake3-servil-mt|continuous 64 B;blake3-servil-mt|continuous 128 B;blake3-servil-mt|continuous 256 B;blake3-servil-mt|continuous lent 64 B"

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
    --layouts 12 \
    --when-quiet \
    --keep "$out"
  rc=$?
  set -e
  echo "LEG $leg EXIT=$rc"
  "$BIN" compare --markdown "$out"/run-*-old.tsv -- "$out"/run-*-new.tsv || true
  echo ""
}

run_leg p4_vecdeque_unwrapped_vs_0110 e1966b498bc769db3d51451a4ddc8188a19ed593 0ad1ebc79e349b0330b65f828c56dd0c664742b0
run_leg p5_compact24_maybeuninit_vs_next 2557d53c772edfa2f3eeb28b8c8827919a27d608 b3011810757fa9a3ac7fb1b51e0a57f26d365a68
run_leg p5_compact24_maybeuninit_vs_0110 e1966b498bc769db3d51451a4ddc8188a19ed593 b3011810757fa9a3ac7fb1b51e0a57f26d365a68
run_leg p3_0110_maybeuninit_vs_0110 e1966b498bc769db3d51451a4ddc8188a19ed593 2b123e0ef1c2d1b5643093430669f8d21ce3d155
