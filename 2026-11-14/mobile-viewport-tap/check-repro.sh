#!/bin/sh
set -eu
O=<development-home>/bench-hashes-validation/autonomous-20261114/grid-input
export NODE_PATH="$O/current/node_modules" PLAYWRIGHT_BROWSERS_PATH="$O/current/browsers"
set +e
node <development-home>/playwright-viewport-repro/repro.cjs > "$O/repro.stdout.txt" 2> "$O/repro.stderr.txt"
status=$?
set -e
printf 'Minimal published repro exit: %s\n' "$status"
test "$status" = 1
grep -F 'locator.tap: Timeout 3000ms exceeded' "$O/repro.stderr.txt"
