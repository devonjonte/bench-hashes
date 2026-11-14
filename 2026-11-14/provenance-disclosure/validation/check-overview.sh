#!/bin/sh
set -eu
P=<development-home>/bench-hashes-validation/autonomous-20261114/grid-input/current
export NODE_PATH="$P/node_modules" PLAYWRIGHT_BROWSERS_PATH="$P/browsers"
browser=$(cd "$P" && node -p "require('playwright').chromium.executablePath()")
node <development-home>/bench-provenance-door/tools/graph-check/overview.js <development-home>/bench-provenance-door/index.html "$browser"
