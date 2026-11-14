#!/bin/sh
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O="$HOME/runs/ring-assertions-8a6c53a7-after"
export O
if [ "${BOUNDED_RING_AFTER:-}" != yes ]; then
  export BOUNDED_RING_AFTER=yes
  status=0
  timeout --kill-after=15s 1200s sh "$O/run.sh" || status=$?
  printf 'RING_AFTER_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
  exit "$status"
fi
B="$HOME/work/lib-devon-ring-assertions-8a6c53a7"
export CARGO_BUILD_JOBS=4 TMPDIR="$HOME/work/ring-assertions-8a6c53a7-scratch"
unset CARGO_TARGET_DIR RUSTFLAGS CARGO_ENCODED_RUSTFLAGS
cd "$B"
test "$(git rev-parse HEAD)" = 8a6c53a790b5a093eccb9e709047f66ddd9b72af
git status --porcelain > "$O/status-start.txt"
test "$(git status --porcelain)" = '?? tmp/'
git diff --exit-code
cp "$HOME/runs/ring-assertions-8a6c53a7-v2/pilot.py" "$O/pilot.py"
export ARM=after
{ rustc -Vv; cargo nextest --version; cargo mutants --version; } > "$O/toolchain.txt"
python3 "$O/pilot.py" > "$O/after.stdout.txt" 2> "$O/after.stderr.txt"
printf 'DONE: candidate arm; prior completed baseline kept separately\n'
