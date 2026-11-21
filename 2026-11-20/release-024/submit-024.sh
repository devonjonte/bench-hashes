#!/bin/sh
# Submit the 0.24.0 fleet record runs across all 6 x86-64 Linux hosts + Mac.
# Usage: submit-024.sh BENCH_024_COMMIT SERVIL_010_COMMIT
set -eu
V=$1
NEW=$2
test "${#V}" -eq 40
test "${#NEW}" -eq 40
SV=$(printf %s "$V" | cut -c1-8)
SN=$(printf %s "$NEW" | cut -c1-8)
H=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
T=$(mktemp -d)
sed -e "s/@@V@@/$V/g" -e "s/@@NEW@@/$NEW/g" "$H/release-024-linux.sh" > "$T/run.sh"
grep -q "^V=$V\$" "$T/run.sh"
grep -q "^NEW=$NEW\$" "$T/run.sh"
for h in x86-9700x x86-epyc-9255 x86-epyc-9275f x86-icelake x86-icelake-2 x86-avx2; do
  /home/agent/bin/bench-submit "$h" "release-024-$SV" "$T/run.sh" | cut -c1-70
done
cd /home/agent/mac-runner
git pull -q --rebase
n=$(( $(ls jobs | sed 's/-.*//' | sort -n | tail -1) + 1 ))
OLD=2c60420c2bccbf6073e35e668691d98520f9b096
OLDBENCH=cade30fdb71682719f5fa3e586ff96146ae9fc25
# Records first (benchmark, b3sum, crowd), then the release check and its control. The deployed runner caps a job at 7200 s.
printf '{"type": "benchmark", "fork_commit": "%s", "bench_commit": "%s", "flags": ["--all"], "time_limit_seconds": 7200}\n' "$NEW" "$V" > "jobs/$n-release-024-benchmark.json"
printf '{"type": "b3sum", "fork_commit": "%s", "bench_commit": "%s", "time_limit_seconds": 3600}\n' "$NEW" "$V" > "jobs/$((n+1))-release-024-b3sum.json"
printf '{"type": "crowd", "fork_commit": "%s", "bench_commit": "%s", "time_limit_seconds": 3600}\n' "$NEW" "$V" > "jobs/$((n+2))-release-024-crowd.json"
printf '{"type": "check", "old_commit": "%s", "new_commit": "%s", "bench_commit": "%s", "cells": "all", "time_limit_seconds": 7200}\n' "$OLD" "$NEW" "$V" > "jobs/$((n+3))-release-024-check.json"
printf '{"type": "check", "old_commit": "%s", "new_commit": "%s", "bench_commit": "%s", "old_bench_commit": "%s", "cells": "all", "time_limit_seconds": 7200}\n' "$NEW" "$NEW" "$V" "$OLDBENCH" > "jobs/$((n+4))-release-024-control.json"
git add jobs && git commit -q -m "jobs $n-$((n+4)): the Mac's 0.24.0 release run (bench $SV, BLAKE3-Servil $SN)" && git push -q && echo "Mac jobs $n to $((n+4)) pushed"
