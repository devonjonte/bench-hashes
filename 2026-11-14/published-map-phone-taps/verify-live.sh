#!/bin/sh
set -eu
export NODE_PATH=<development-home>/bench-hashes-validation/node_modules
O=<development-home>/bench-hashes-validation/autonomous-20261114/phone-publication
expected=<development-home>/bench-phone-published/benchmark-results/AppleM6.darwin27/bench-hashes.map.html
url="https://servil-software-factory.github.io/bench-hashes/benchmark-results/AppleM6.darwin27/bench-hashes.map.html?phone-repair=$1"
matched=no
for attempt in $(seq 1 20); do
    curl --fail --location --silent --show-error --max-time 15 -H 'Cache-Control: no-cache' "$url" -o "$O/live-attempt-$attempt.html"
    printf '%s attempt=%s\n' "$(date -u +%FT%TZ)" "$attempt"
    if cmp -s "$expected" "$O/live-attempt-$attempt.html"; then
        cp "$O/live-attempt-$attempt.html" "$O/live-after.html"
        matched=yes
        break
    fi
    sleep 10
done
if [ "$matched" != yes ]; then
    printf 'Deployment still differs after twenty bounded polls; live verification remains pending.\n' >&2
    exit 2
fi
node "$O/live-phone.js" "$url"
(cd "$O" && sha256sum live-after.html > live-SHA256SUMS && b3sum live-after.html > live-BLAKE3SUMS && sha256sum --check --quiet live-SHA256SUMS && b3sum --check --quiet live-BLAKE3SUMS >/dev/null)
printf 'Published HTML matches candidate byte for byte; live phone targets pass.\n'
