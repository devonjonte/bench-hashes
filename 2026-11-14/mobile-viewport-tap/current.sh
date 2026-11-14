#!/bin/sh
set -eu
O=<development-home>/bench-hashes-validation/autonomous-20261114/grid-input/current
mkdir -p "$O"
npm install --prefix "$O" --ignore-scripts --save-exact playwright@1.65.1 > "$O/package-install.txt" 2>&1
export PLAYWRIGHT_BROWSERS_PATH="$O/browsers"
node "$O/node_modules/playwright/cli.js" install chromium > "$O/browser-install.txt" 2>&1
export NODE_PATH="$O/node_modules"
cp <development-home>/bench-hashes-validation/autonomous-20261114/grid-input/trace.js "$O/trace.js"
node "$O/trace.js" "$O/results"
