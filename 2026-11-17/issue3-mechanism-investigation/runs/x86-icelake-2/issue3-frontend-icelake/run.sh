#!/bin/sh
# bench-hashes #3 front-end counter experiment, declared before running (Nov 17, 2026).
# Layout executables from the avx2 control's check cache, identified by their kept
# second-stage layout means for st IdleOneMessage 256 B: old seed15, new seed32 fast,
# new seed36 slow (layout means 4.50 vs 5.15 ns/B).
# Each runs the same cell under perf stat. Expectation: if code delivery carries
# the slow state, L1-icache misses and/or op-cache misses per timed byte are
# higher in the slow layouts at equal instructions; if neither moves, the
# penalty is predictor aliasing or elsewhere.
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O="$HOME/runs/issue3-frontend-icelake"
if [ "${BOUNDED_F:-}" != yes ]; then
  export BOUNDED_F=yes
  status=0
  timeout --kill-after=30s 3600s sh "$O/run.sh" || status=$?
  printf 'FRONTEND_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
  exit "$status"
fi
C="$HOME/work/lib-release-023/target/check"
S="$HOME/work/frontend-scratch"; rm -rf "$S"; mkdir -p "$S"; cd "$S"
EVENTS='cycles,instructions,dsb2mite_switches.count,dsb2mite_switches.penalty_cycles,frontend_retired.dsb_miss,branch-misses'
for spec in new-fast:new/bench-hashes-32 new-slow:new/bench-hashes-36; do
  name=${spec%%:*}; exe="$C/${spec#*:}"
  i=1
  while [ $i -le 3 ]; do
    rm -rf benchmark-results
    BENCH_HASHES_PIN_CPU=0 perf stat -x, -e "$EVENTS" "$exe" --contenders blake3-servil-st --points 'idle 256 B' --for-regression-check --rounds 24 > "$O/run-$name-$i.txt" 2> "$O/perf-$name-$i.txt"
    cp benchmark-results/*/bench-hashes.samples.tsv "$O/samples-$name-$i.tsv"
    i=$((i+1))
  done
done
cat "$O"/perf-*.txt | head -20
