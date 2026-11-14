#!/bin/sh
set -eu
export NODE_PATH=<development-home>/bench-hashes-validation/node_modules
O=<development-home>/bench-hashes-validation/autonomous-20261114/phone-publication
browser=$(node -p "require('playwright').chromium.executablePath()")
test -x "$browser"
set +e
node <development-home>/bench-phone-published/tools/graph-check/map.js "$O/published-m6-before.html" "$browser" > "$O/before-browser.stdout.txt" 2> "$O/before-browser.stderr.txt"
status=$?
set -e
printf 'Unpatched published map browser exit: %s\n' "$status"
test "$status" = 1
grep -F 'a phone tap opens its chart' "$O/before-browser.stderr.txt"
