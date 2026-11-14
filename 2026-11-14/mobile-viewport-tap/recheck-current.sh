#!/bin/sh
set -eu
O=<development-home>/bench-hashes-validation/autonomous-20261114/grid-input/current
export PLAYWRIGHT_BROWSERS_PATH="$O/browsers" NODE_PATH="$O/node_modules"
cp <development-home>/bench-hashes-validation/autonomous-20261114/grid-input/trace.js "$O/trace.js"
node "$O/trace.js" "$O/results"
browser=$(cd "$O" && node -p "require('playwright').chromium.executablePath()")
node <development-home>/bench-zoom-layout/tools/graph-check/map.js <development-home>/bench-zoom-layout/benchmark-results/AppleM6.darwin27/bench-hashes.map.html "$browser"
