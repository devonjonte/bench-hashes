#!/bin/sh
set -eu
export NODE_PATH=<development-home>/bench-hashes-validation/node_modules
O=<development-home>/bench-hashes-validation/autonomous-20261114/phone-publication
python3 - <<'PY'
from pathlib import Path
p=Path('<development-home>/bench-phone-published/benchmark-results/AppleM6.darwin27/bench-hashes.map.html')
data=p.read_bytes(); rule=b'@media (pointer: coarse) { .cell a.doc { pointer-events: none; } }'
assert data.count(rule)==1
Path('<development-home>/bench-hashes-validation/autonomous-20261114/phone-publication/overbroad-m6.html').write_bytes(data.replace(rule, b'@media (pointer: coarse) { a.doc { pointer-events: none; } }'))
PY
browser=$(node -p "require('playwright').chromium.executablePath()")
set +e
node <development-home>/bench-phone-published/tools/graph-check/map.js "$O/overbroad-m6.html" "$browser" > "$O/overbroad-browser.stdout.txt" 2> "$O/overbroad-browser.stderr.txt"
status=$?
set -e
printf 'Deliberately overbroad repair browser exit: %s\n' "$status"
test "$status" = 1
grep -F 'the open chart keeps its documentation link active' "$O/overbroad-browser.stderr.txt"
