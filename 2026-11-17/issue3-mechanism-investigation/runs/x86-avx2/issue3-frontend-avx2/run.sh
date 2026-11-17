#!/bin/sh
# bench-hashes #3 front-end counter experiment, declared before running (Nov 17, 2026).
# Layout executables from the avx2 control's check cache, identified by their kept
# second-stage layout means for st OneMessage 128 B: old seed16 fast (4.7 ns/B),
# old seed18 slow (10.9), new seed33 fast (5.5), new seed31 slow (16.1).
# Each runs the same cell under perf stat. Expectation: if code delivery carries
# the slow state, L1-icache misses and/or op-cache misses per timed byte are
# higher in the slow layouts at equal instructions; if neither moves, the
# penalty is predictor aliasing or elsewhere.
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O="$HOME/runs/issue3-frontend-avx2"
if [ "${BOUNDED_F:-}" != yes ]; then
  export BOUNDED_F=yes
  status=0
  timeout --kill-after=30s 3600s sh "$O/run.sh" || status=$?
  printf 'FRONTEND_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
  exit "$status"
fi
C="$HOME/work/lib-release-023/target/check"
S="$HOME/work/frontend-scratch"; rm -rf "$S"; mkdir -p "$S"; cd "$S"
EVENTS='cycles,instructions,l1-icache-load-misses,op_cache_hit_miss.op_cache_miss,op_cache_hit_miss.all_op_cache_accesses,branch-misses,iTLB-load-misses'
for spec in old-fast:old/bench-hashes-16 old-slow:old/bench-hashes-18 new-fast:new/bench-hashes-33 new-slow:new/bench-hashes-31; do
  name=${spec%%:*}; exe="$C/${spec#*:}"
  i=1
  while [ $i -le 3 ]; do
    rm -rf benchmark-results
    BENCH_HASHES_PIN_CPU=0 perf stat -x, -e "$EVENTS" "$exe" --contenders blake3-servil-st --points '128 B' --for-regression-check --rounds 24 > "$O/run-$name-$i.txt" 2> "$O/perf-$name-$i.txt"
    cp benchmark-results/*/bench-hashes.samples.tsv "$O/samples-$name-$i.tsv"
    i=$((i+1))
  done
done
cat "$O"/perf-*.txt | head -20
