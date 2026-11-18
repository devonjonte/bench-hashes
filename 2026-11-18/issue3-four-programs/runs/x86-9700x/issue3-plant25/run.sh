#!/bin/sh
# Predeclared detection test, November 18, 2026 (UTC). A planted cost of
# ITER dependent multiply-adds (about 4 cycles each) on every one-shot call
# of 256 bytes or less, in a scratch clone's working tree, against its HEAD
# (candidate 27eacce3): the standard gate, released bench cade30fd both
# sides, runs kept. Question: which cells do wall time and the thread's
# user-mode cycles each convict, and with how many pairs?
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
if [ "${BOUNDED_PLANT:-}" != yes ]; then
  export BOUNDED_PLANT=yes
  status=0
  timeout --kill-after=30s 3600s sh "$O/run.sh" || status=$?
  printf 'PLANT_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
  exit "$status"
fi
ITER=25
export CARGO_BUILD_JOBS=8 CARGO_INCREMENTAL=0
unset CARGO_TARGET_DIR RUSTFLAGS CARGO_ENCODED_RUSTFLAGS
B="$HOME/work/bench-release-023"
M="$HOME/work/lib-release-023"
P="$HOME/work/${O##*/}-lib"
test "$(git -C "$B" rev-parse HEAD)" = cade30fdb71682719f5fa3e586ff96146ae9fc25
rm -rf "$P"
git clone -q "$M" "$P"
git -C "$P" checkout -q --detach 27eacce3a5c2e03043f4fcd347c178a80f9d911c
ITER=$ITER python3 - "$P/src/lib.rs" <<'PY'
import os, sys
p = sys.argv[1]
s = open(p).read()
anchor = "    let turn = platform::Sme2Turn::take(platform, input.len() >= SME2_SIZED_LEN);\n"
assert s.count(anchor) == 1
plant = anchor + f"""    if input.len() <= 256 {{
        let m = core::hint::black_box(0x9E37_79B9_7F4A_7C15u64);
        let mut x = input.len() as u64 | 1;
        for _ in 0..{int(os.environ['ITER'])} {{
            x = x.wrapping_mul(m).wrapping_add(x >> 7);
        }}
        core::hint::black_box(x);
    }}
"""
open(p, "w").write(s.replace(anchor, plant))
PY
git -C "$P" diff > "$O/plant.diff"
test -s "$O/plant.diff"
printf 'bench cade30fdb716 both sides\nold: library 27eacce3 (HEAD)\nnew: its working tree with the plant, %s iterations\n' "$ITER" > "$O/versions.txt"
cd "$B"
status=0
./target/release/bench-hashes check --fork "$P" --points 'idle 64 B,idle 128 B,idle 256 B,64 B,128 B' --when-quiet --keep "$O/kept-plant" > "$O/plant.stdout.txt" 2> "$O/plant.stderr.txt" || status=$?
printf 'check exit %s\n' "$status" > "$O/exit.txt"
cat "$O/plant.stdout.txt"
rm -rf "$P"
