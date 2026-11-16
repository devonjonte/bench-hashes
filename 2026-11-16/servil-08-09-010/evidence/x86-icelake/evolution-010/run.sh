#!/bin/sh
# BLAKE3-Servil 0.8 -> 0.9 -> 0.10 candidate on one machine: b3sum's three versions
# side by side in one run, then the library's 0.8 -> candidate check.
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O="$HOME/runs/evolution-010"
export O
if [ "${BOUNDED_EVOLUTION:-}" != yes ]; then
  export BOUNDED_EVOLUTION=yes
  status=0
  timeout --kill-after=30s 14400s sh "$O/run.sh" || status=$?
  printf 'EVOLUTION_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
  exit "$status"
fi
export CARGO_BUILD_JOBS=8 CARGO_INCREMENTAL=0
unset CARGO_TARGET_DIR RUSTFLAGS CARGO_ENCODED_RUSTFLAGS
B="$HOME/work/bench-release-023"
M="$HOME/work/lib-release-023"
test "$(git -C "$B" rev-parse HEAD)" = cade30fdb71682719f5fa3e586ff96146ae9fc25
C08=$(git -C "$M" rev-parse 'v0.8.0+b3c5efc7c975d903762dea809066f7c0a0603861^{commit}')
C09=$(git -C "$M" rev-parse 'v0.9.0+73ee859efce085d28f1c2b22c35a5703403476f7^{commit}')
C10=7048303103c69b8609ffe9ca0361197ba318107c
printf 'bench cade30fdb716\n0.8 %s\n0.9 %s\n0.10-candidate %s\n' "$C08" "$C09" "$C10" > "$O/versions.txt"
{ uname -srm; rustc -Vv; cc --version; } > "$O/toolchain.txt"
cd "$B"
BINS="$HOME/b3sum-contenders-evolution"
layouts=4
if ! LAYOUTS=4 python3 tools/b3sum-contenders.py "$M" "$BINS" "$C09" "$C08" "$C10" > "$O/contenders-raw.txt" 2> "$O/contenders.log"; then
  cp "$O/contenders.log" "$O/contenders-layouts4-failed.log"
  layouts=1
  LAYOUTS=1 python3 tools/b3sum-contenders.py "$M" "$BINS" "$C09" "$C08" "$C10" > "$O/contenders-raw.txt" 2> "$O/contenders.log"
fi
printf 'layouts %s\n' "$layouts" >> "$O/versions.txt"
s8=$(printf %s "$C08" | cut -c1-7); s9=$(printf %s "$C09" | cut -c1-7); s10=$(printf %s "$C10" | cut -c1-7)
# 0.9 first: the report's ratios are against the first contender.
{ grep "^b3sum-$s9=" "$O/contenders-raw.txt" | sed "s/^b3sum-$s9=/b3sum-0.9.0=/"
  grep "^b3sum-$s8=" "$O/contenders-raw.txt" | sed "s/^b3sum-$s8=/b3sum-0.8.0=/"
  grep "^b3sum-$s10=" "$O/contenders-raw.txt" | sed "s/^b3sum-$s10=/b3sum-0.10-candidate=/"
  grep '^official=' "$O/contenders-raw.txt"; } > "$O/contenders.txt"
test "$(wc -l < "$O/contenders.txt")" -eq $((4 * layouts))
RUNS="$HOME/work/evolution-010-scratch"
mkdir "$RUNS"
cd "$RUNS"
tr '\n' '\0' < "$O/contenders.txt" | xargs -0 "$B/target/release/bench-hashes" b3sum --files "$HOME/b3sum-bench-files" > "$O/b3sum.stdout.txt" 2> "$O/b3sum.stderr.txt"
cp -r benchmark-results "$O/b3sum-results"
printf 'B3SUM_DONE %s\n' "$(date -u +%FT%TZ)"
cd "$B"
./target/release/bench-hashes check --fork "$M" --new "$C10" --against "$C08" --old-bench 3363bee8 \
    --contenders blake3-servil-st --cells all --when-quiet --keep "$O/kept-08-to-010" \
    > "$O/check-08-to-010.stdout.txt" 2> "$O/check-08-to-010.stderr.txt" || printf 'check exit %s\n' "$?" >> "$O/verdicts.txt"
printf 'DONE %s\n' "$(date -u +%FT%TZ)"
