#!/bin/sh
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O="$HOME/runs/provenance-door-adc20bdd"
export O
if [ "${BOUNDED_PROVENANCE:-}" != yes ]; then
  export BOUNDED_PROVENANCE=yes
  status=0
  timeout --kill-after=15s 900s sh "$O/run.sh" || status=$?
  printf 'PROVENANCE_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
  exit "$status"
fi
export CARGO_BUILD_JOBS=4 CARGO_INCREMENTAL=0
unset CARGO_TARGET_DIR RUSTFLAGS CARGO_ENCODED_RUSTFLAGS
C=adc20bdd76f7346e263b4d533afc596c0de383d5
B="$HOME/work/bench-devon-provenance-adf9fc85"
test "$(git -C "$B" rev-parse HEAD)" = 9418b5b5866c022244ae3cb7fe144fe4f9d047b5
test "$(git -C "$B" diff --name-only)" = index.html
git -C "$B" restore -- index.html
git -C "$B" fetch origin candidate/devon-provenance-door
git -C "$B" checkout --detach "$C"
cd "$B"
test -z "$(git status --porcelain)"
{ git rev-parse HEAD; rustc -Vv; cc --version; } > "$O/toolchain.txt"
cargo fmt --check > "$O/fmt.txt" 2>&1
cargo build --release --locked > "$O/build.txt" 2>&1
cp target/release/bench-hashes "$O/renderer"
"$O/renderer" provenance > "$O/renderer-provenance.txt"
"$O/renderer" overview index.html benchmark-results > "$O/render.txt" 2>&1
cp index.html "$O/index.html"
cargo nextest run --release --locked -j 4 --no-fail-fast > "$O/release.txt" 2>&1
python3 - <<'PY'
from pathlib import Path
p=Path('src/map.rs');s=p.read_text();old='        "power",\n        "load",\n';assert s.count(old)==1
p.write_text(s.replace(old,''))
PY
set +e
cargo nextest run --release --locked -j 2 -E 'test(recorded_software_precedes_conditions_and_keeps_identity_fields)' > "$O/duplicated-conditions.txt" 2>&1
status=$?
set -e
git restore -- src/map.rs
printf 'duplicated-conditions exit=%s (expected100)\n' "$status" > "$O/controls.txt"
test "$status" = 100
cargo nextest run --release --locked -j 2 -E 'test(recorded_software_precedes_conditions_and_keeps_identity_fields)' > "$O/restored.txt" 2>&1
test "$(git diff --name-only)" = index.html
printf 'DONE: source restored; overview generated; no performance collection\n'
