#!/bin/sh
set -eu
export NODE_PATH=<development-home>/bench-hashes-validation/node_modules
V=<development-home>/bench-hashes-validation/ode-adler-fast
mkdir -p "$V/m6-render-control/original"
cp <development-home>/bench-m6-record/benchmark-results/AppleM6.darwin27/*.samples.tsv "$V/m6-render-control/original/"
<development-home>/bench-021tag/target/release/bench-hashes map "$V/m6-render-control/original" > "$V/m6-render-control/original-render.txt"
python3 - <<'PY'
from pathlib import Path
import json,re
v=Path('<development-home>/bench-hashes-validation/ode-adler-fast')
def sections(p):
 t=p.read_text();return json.loads(re.search(r'^const SECTIONS = (.*);$',t,re.M)[1])
a=sections(v/'m6-render-control/original/bench-hashes.map.html')
b=sections(Path('<development-home>/bench-m6-record/benchmark-results/AppleM6.darwin27/bench-hashes.map.html'))
assert len(a)==len(b)==2
for old,new in zip(a,b):
 assert old.pop('about') != new.pop('about')
 assert old==new
print('both map sections unchanged except load wording, against pristine historical renderer')
PY
node "$V/m6-load-browser.cjs"
node <development-home>/bench-m6-load/tools/graph-check/map.js <development-home>/bench-m6-record/benchmark-results/AppleM6.darwin27/bench-hashes.map.html <development-home>/.cache/ms-playwright/chromium-1193/chrome-linux/chrome
