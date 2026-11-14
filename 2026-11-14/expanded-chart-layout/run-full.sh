#!/bin/sh
set -eu
export NODE_PATH=<development-home>/bench-hashes-validation/node_modules
browser=$(node -p "require('playwright').chromium.executablePath()")
exec node <development-home>/bench-zoom-layout/tools/graph-check/map.js "$1" "$browser"
