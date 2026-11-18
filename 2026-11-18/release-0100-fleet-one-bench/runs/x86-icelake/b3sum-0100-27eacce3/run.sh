#!/bin/sh
# b3sum at BLAKE3-Servil's 0.10.0 release commit (ad163558, branch release/0.10.0) beside
# 0.9.0, 0.8.0 and official 1.8.7 in the same rounds: the full inputs, then the quick
# inputs (which hold the hundred-file run that 9de026af changed).
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O="$HOME/runs/b3sum-0100-27eacce3"
if [ "${BOUNDED_R:-}" != yes ]; then
  export BOUNDED_R=yes
  status=0
  timeout --kill-after=30s 10800s sh "$O/run.sh" || status=$?
  printf 'RELEASE_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
  exit "$status"
fi
export CARGO_BUILD_JOBS=8 CARGO_INCREMENTAL=0
unset CARGO_TARGET_DIR RUSTFLAGS CARGO_ENCODED_RUSTFLAGS
B="$HOME/work/bench-release-023"
M="$HOME/work/lib-release-023"
test "$(git -C "$B" rev-parse HEAD)" = cade30fdb71682719f5fa3e586ff96146ae9fc25
C10=27eacce3a5c2e03043f4fcd347c178a80f9d911c
git -C "$M" fetch --quiet https://github.com/servil-software-factory/BLAKE3 release/0.10.0 > "$O/fetch.log" 2>&1
test "$(git -C "$M" rev-parse FETCH_HEAD)" = "$C10"
C08=$(git -C "$M" rev-parse 'v0.8.0+b3c5efc7c975d903762dea809066f7c0a0603861^{commit}')
C09=$(git -C "$M" rev-parse 'v0.9.0+73ee859efce085d28f1c2b22c35a5703403476f7^{commit}')
printf 'bench cade30fdb716\n0.8 %s\n0.9 %s\n0.10.0 %s\n' "$C08" "$C09" "$C10" > "$O/versions.txt"
cd "$B"
BINS="$HOME/b3sum-contenders-evolution"
LAYOUTS=4 python3 tools/b3sum-contenders.py "$M" "$BINS" "$C09" "$C08" "$C10" > "$O/contenders-raw.txt" 2> "$O/contenders.log"
s8=$(printf %s "$C08" | cut -c1-7); s9=$(printf %s "$C09" | cut -c1-7); s10=$(printf %s "$C10" | cut -c1-7)
{ grep "^b3sum-$s9=" "$O/contenders-raw.txt" | sed "s/^b3sum-$s9=/b3sum-0.9.0=/"
  grep "^b3sum-$s8=" "$O/contenders-raw.txt" | sed "s/^b3sum-$s8=/b3sum-0.8.0=/"
  grep "^b3sum-$s10=" "$O/contenders-raw.txt" | sed "s/^b3sum-$s10=/b3sum-0.10.0=/"
  grep '^official=' "$O/contenders-raw.txt"; } > "$O/contenders.txt"
test "$(wc -l < "$O/contenders.txt")" -eq 16
for mode in full quick; do
  RUNS="$HOME/work/b3sum-0100-scratch-$mode"; rm -rf "$RUNS"; mkdir "$RUNS"; cd "$RUNS"
  flag=""; [ "$mode" = quick ] && flag="--quick"
  tr '\n' '\0' < "$O/contenders.txt" | xargs -0 "$B/target/release/bench-hashes" b3sum --files "$HOME/b3sum-bench-files" $flag > "$O/b3sum-$mode.stdout.txt" 2> "$O/b3sum-$mode.stderr.txt"
  cp -r benchmark-results "$O/b3sum-$mode-results"; cd /; rm -rf "$RUNS"
  printf '%s done %s\n' "$mode" "$(date -u +%FT%TZ)"
done
