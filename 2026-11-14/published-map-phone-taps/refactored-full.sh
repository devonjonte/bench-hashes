#!/bin/sh
set -eu
export NODE_PATH=<development-home>/bench-hashes-validation/node_modules
browser=$(node -p "require('playwright').chromium.executablePath()")
node <development-home>/bench-phone-published/tools/graph-check/map.js <development-home>/bench-phone-published/benchmark-results/AppleM6.darwin27/bench-hashes.map.html "$browser"
