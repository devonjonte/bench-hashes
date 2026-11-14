#!/bin/sh
set -eu
P=<development-home>/bench-hashes-validation/autonomous-20261114/grid-input/current
export NODE_PATH="$P/node_modules" PLAYWRIGHT_BROWSERS_PATH="$P/browsers"
O=<development-home>/bench-hashes-validation/autonomous-20261114/zoom-layout
expected=<development-home>/bench-zoom-layout/benchmark-results/AppleM6.darwin27/bench-hashes.map.html
url="https://servil-software-factory.github.io/bench-hashes/benchmark-results/AppleM6.darwin27/bench-hashes.map.html?layout=$1"
matched=no
for attempt in $(seq 1 20); do
 curl --fail --location --silent --show-error --max-time 15 -H 'Cache-Control: no-cache' "$url" -o "$O/live-attempt-$attempt.html"
 printf '%s attempt=%s\n' "$(date -u +%FT%TZ)" "$attempt"
 if cmp -s "$expected" "$O/live-attempt-$attempt.html"; then cp "$O/live-attempt-$attempt.html" "$O/live-after.html";matched=yes;break;fi
 sleep 10
done
if [ "$matched" != yes ]; then printf 'Deployment remains pending after twenty bounded polls.\n' >&2;exit 2;fi
cp "$O/live.js" "$P/zoom-live.js"
node "$P/zoom-live.js" "$url" "$O"
(cd "$O" && sha256sum live-after.html > live-SHA256SUMS && b3sum live-after.html > live-BLAKE3SUMS && sha256sum --check --quiet live-SHA256SUMS && b3sum --check --quiet live-BLAKE3SUMS >/dev/null)
