#!/bin/sh
# devonjonte/bench-hashes #3 mechanism experiment, declared before running (Nov 17, 2026).
# Same library (candidate 27eacce3), same bench source per side; only the bench's
# diagnostic allocator changes (src/diag_alloc.rs, #65): default, diag-align64
# (every allocation >=64B on a 64B boundary), diag-line-offset=48.
# Cell: blake3-servil-st OneMessage 64 B (the EPYC 9255 control's +24% first-stage cell).
# Expectation if buffer placement (4 KiB aliasing) carries the effect: align64
# collapses old and new benches to one level; offset48 moves both to the slow
# level. If code layout carries it, the allocator changes nothing.
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O="$HOME/runs/issue3-diag3-9255"
if [ "${BOUNDED_D:-}" != yes ]; then
  export BOUNDED_D=yes
  status=0
  timeout --kill-after=30s 7200s sh "$O/run.sh" || status=$?
  printf 'DIAG_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
  exit "$status"
fi
export CARGO_BUILD_JOBS=16 CARGO_INCREMENTAL=0
unset RUSTFLAGS CARGO_ENCODED_RUSTFLAGS
M="$HOME/work/lib-release-023"
PATCH="patch.\"https://github.com/servil-software-factory/BLAKE3\".blake3-servil.path=\"$M/threads\""
build() { # benchdir name features offset
  d="$HOME/work/diag-$2"; rm -rf "$d"; cp -r "$1" "$d"; cd "$d"
  if [ -n "$4" ]; then export BENCH_DIAG_LINE_OFFSET=$4; else unset BENCH_DIAG_LINE_OFFSET; fi
  BENCH_HASHES_FORK="$M" BENCH_HASHES_CHECKOUT="$d" cargo build --release --quiet --config "$PATCH" ${3:+--features "$3"} --bin bench-hashes 2> "$O/build-$2.log"
  cp target/release/bench-hashes "$O/exe-$2"
}
build "$HOME/work/bench-022" old-default "" ""
build "$HOME/work/bench-022" old-align64 diag-align64 ""
build "$HOME/work/bench-022" old-offset48 diag-line-offset 48
build "$HOME/work/bench-release-023" new-default "" ""
build "$HOME/work/bench-release-023" new-align64 diag-align64 ""
build "$HOME/work/bench-release-023" new-offset48 diag-line-offset 48
S="$HOME/work/diag-scratch"; rm -rf "$S"; mkdir -p "$S"; cd "$S"
"$O/exe-new-default" quiet --wait > "$O/quiet.txt" 2>&1 || true
for exe in old-default new-default old-align64 new-align64 old-offset48 new-offset48; do
  i=1
  while [ $i -le 8 ]; do
    "$O/exe-$exe" --contenders blake3-servil-st --points '64 B' --for-regression-check --rounds 24 > "$O/run-$exe-$i.txt" 2>/dev/null
    i=$((i+1))
  done
done
grep -h 'OneMessage' "$O"/run-*.txt | head -5 || true
