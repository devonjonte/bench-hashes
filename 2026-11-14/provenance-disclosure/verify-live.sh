#!/bin/sh
set -eu
O=<development-home>/bench-hashes-validation/provenance-visibility
R=<development-home>/bench-provenance-door
P=<development-home>/bench-hashes-validation/autonomous-20261114/grid-input/current
export NODE_PATH="$P/node_modules" PLAYWRIGHT_BROWSERS_PATH="$P/browsers"
mkdir "$O/live"
url=https://servil-software-factory.github.io/bench-hashes/
map=benchmark-results/AppleM6.darwin27/bench-hashes.map.html
ready=no
for n in $(seq 1 24); do
  curl -fsSL --max-time 20 "$url" -o "$O/live/index-attempt-$n.html"
  curl -fsSL --max-time 20 "$url$map" -o "$O/live/map-attempt-$n.html"
  if cmp -s "$R/index.html" "$O/live/index-attempt-$n.html" && cmp -s "$R/$map" "$O/live/map-attempt-$n.html"; then
    cp "$O/live/index-attempt-$n.html" "$O/live/index.html"
    cp "$O/live/map-attempt-$n.html" "$O/live/map.html"
    printf 'Published bodies match on attempt%s at%s\n' "$n" "$(date -u +%FT%TZ)"
    ready=yes
    break
  fi
  sleep 10
done
test "$ready" = yes
browser=$(cd "$P" && node -p "require('playwright').chromium.executablePath()")
node "$R/tools/graph-check/overview.js" "$url" "$browser" > "$O/live/browser.txt" 2>&1
node "$O/live-capture.cjs" "$url" "$O/live" > "$O/live/capture.txt" 2>&1
cd "$O/live"
sha256sum index.html map.html > SHA256SUMS
b3sum index.html map.html > BLAKE3SUMS
sha256sum --check --quiet SHA256SUMS
b3sum --check --quiet BLAKE3SUMS
printf 'Live provenance checks pass; both HTML digests checked\n'
