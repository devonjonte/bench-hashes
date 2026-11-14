#!/bin/sh
set -eu
P=<development-home>/bench-hashes-validation/autonomous-20261114/grid-input/current
export NODE_PATH="$P/node_modules" PLAYWRIGHT_BROWSERS_PATH="$P/browsers"
browser=$(cd "$P" && node -p "require('playwright').chromium.executablePath()")
O=<development-home>/bench-hashes-validation/provenance-visibility
set +e
node <development-home>/bench-provenance-door/tools/graph-check/overview.js <development-home>/bench-decision-record/index.html "$browser" > "$O/before-check.txt" 2>&1
status=$?
set -e
test "$status" = 1
grep -F 'long version/commit strings stay out of result headers' "$O/before-check.txt"
printf 'PASS: the prior published layout fails the reader contract\n'
