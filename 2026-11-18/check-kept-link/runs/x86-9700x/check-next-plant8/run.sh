#!/bin/sh
# Declared before running (November 18, 2026, UTC): a whole `check` with its second stage on the bench
# as landed on next (428e82a96: layouts from one kept link, 64 second-stage pairs each with its own
# layout, margin 5%). Sides: library 27eacce3 and the same with a small planted slowdown on one-shot
# calls of up to 256 B (8 iterations of a multiply chain, about 40 instructions), small enough that
# the first stage should mark no cell at 5% and name instruction suspects, so the second stage runs.
# Questions: does the second stage complete with 64 layouts a side, and how long does each stage take?
# Every line of check's own output is stamped with the time it appeared.
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
if [ "${BOUNDED_PLANT:-}" != yes ]; then
  export BOUNDED_PLANT=yes
  status=0
  timeout --kill-after=30s 3600s sh "$0" || status=$?
  printf 'PLANT_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
  exit "$status"
fi
ITER=8
export CARGO_BUILD_JOBS=8 CARGO_INCREMENTAL=0
unset CARGO_TARGET_DIR RUSTFLAGS CARGO_ENCODED_RUSTFLAGS
R="$HOME/work/bench-release-023"
BENCH=428e82a96ccab1387adb260979439ad2bea378fe
B="$HOME/work/bench-next-check"
M="$HOME/work/lib-release-023"
P="$HOME/work/${O##*/}-lib"
git -C "$R" cat-file -e "$BENCH^{commit}" 2> /dev/null || git -C "$R" fetch -q origin next
[ -d "$B" ] || git -C "$R" worktree add -q --detach "$B" "$BENCH"
git -C "$B" checkout -q --detach "$BENCH"
test "$(git -C "$B" rev-parse HEAD)" = "$BENCH"
(cd "$B" && cargo build --release --quiet) > "$O/bench-build.txt" 2>&1
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
printf 'bench 428e82a96 (next) both sides\nold: library 27eacce3 (HEAD)\nnew: its working tree with the plant, %s iterations\n' "$ITER" > "$O/versions.txt"
cd "$B"
status=0
stampit() { while IFS= read -r line; do printf '%s %s\n' "$(date -u +%T)" "$line"; done; }
{ ./target/release/bench-hashes check --fork "$P" --points 'idle 64 B,idle 128 B,idle 256 B,64 B,128 B' --when-quiet --keep "$O/kept-plant" 2>&1 > "$O/plant.stdout.txt"; echo "check exit $?" > "$O/exit.txt"; } | stampit > "$O/plant.stderr.stamped.txt"
cat "$O/plant.stdout.txt"
rm -rf "$P"
git -C "$R" worktree remove --force "$B" 2> /dev/null || true
