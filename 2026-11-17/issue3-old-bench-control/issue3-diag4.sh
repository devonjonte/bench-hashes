#!/bin/sh
# Mechanism experiment 2 (Nov 17, 2026): the diag3 exes, every process pinned to CPU 0,
# so placement is held and only the allocator variant differs. 12 processes each.
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O="$HOME/runs/issue3-diag4-9255"
if [ "${BOUNDED_D:-}" != yes ]; then
  export BOUNDED_D=yes
  status=0
  timeout --kill-after=30s 3600s sh "$O/run.sh" || status=$?
  printf 'DIAG4_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
  exit "$status"
fi
SRC="$HOME/runs/issue3-diag3-9255"
S="$HOME/work/diag4-scratch"; rm -rf "$S"; mkdir -p "$S"; cd "$S"
taskset -c 0 "$SRC/exe-new-default" quiet --wait > "$O/quiet.txt" 2>&1 || true
for exe in old-default new-default old-align64 new-align64 old-offset48 new-offset48; do
  i=1
  while [ $i -le 12 ]; do
    taskset -c 0 "$SRC/exe-$exe" --contenders blake3-servil-st --points '64 B' --for-regression-check --rounds 24 > "$O/run-$exe-$i.txt" 2>/dev/null
    i=$((i+1))
  done
done
