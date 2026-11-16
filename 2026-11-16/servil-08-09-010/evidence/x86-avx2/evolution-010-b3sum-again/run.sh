#!/bin/sh
# The three-version b3sum run again on this machine, same programs (CONTRIBUTING: a
# slower cell is repeated before it is believed): does "1000 x 16 KiB" cold repeat?
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O="$HOME/runs/evolution-010-b3sum-again"
if [ "${BOUNDED_AGAIN:-}" != yes ]; then
  export BOUNDED_AGAIN=yes
  status=0
  timeout --kill-after=30s 5400s sh "$O/run.sh" || status=$?
  printf 'AGAIN_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
  exit "$status"
fi
B="$HOME/work/bench-release-023"
BINS="$HOME/b3sum-contenders-evolution"
test "$(git -C "$B" rev-parse HEAD)" = cade30fdb71682719f5fa3e586ff96146ae9fc25
for pair in b3sum-0.9.0:bf2da8b b3sum-0.8.0:b5b988d b3sum-0.10-candidate:7048303 official:official-1.8.7; do
  for l in 0 1 2 3; do
    bin="$BINS/b3sum-${pair#*:}-L$l"
    test -x "$bin"
    printf '%s=%s\n' "${pair%%:*}" "$bin"
  done
done > "$O/contenders.txt"
RUNS="$HOME/work/evolution-010-again-scratch"
rm -rf "$RUNS"; mkdir "$RUNS"; cd "$RUNS"
tr '\n' '\0' < "$O/contenders.txt" | xargs -0 "$B/target/release/bench-hashes" b3sum --files "$HOME/b3sum-bench-files" > "$O/b3sum.stdout.txt" 2> "$O/b3sum.stderr.txt"
cp -r benchmark-results "$O/b3sum-results"
rm -rf "$RUNS"
printf 'DONE %s\n' "$(date -u +%FT%TZ)"
