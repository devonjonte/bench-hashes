#!/bin/sh
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O="$HOME/runs/provenance-door-9418b5b5"
export O
if [ "${BOUNDED_PROVENANCE:-}" != yes ]; then
  export BOUNDED_PROVENANCE=yes
  status=0
  timeout --kill-after=15s 1200s sh "$O/run.sh" || status=$?
  printf 'PROVENANCE_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
  exit "$status"
fi
export CARGO_BUILD_JOBS=4 CARGO_INCREMENTAL=0
unset CARGO_TARGET_DIR RUSTFLAGS CARGO_ENCODED_RUSTFLAGS
C=9418b5b5866c022244ae3cb7fe144fe4f9d047b5
B="$HOME/work/bench-devon-provenance-adf9fc85"
export C B
test "$(git -C "$B" rev-parse HEAD)" = 9e831b8f6cad5985ec7a2b599ce665c392c1d8ca
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
for control in truncated-version wrong-file-record old-header-formatter; do
  export control
  python3 - <<'PY'
import os,pathlib,subprocess
kind=os.environ['control']
p=pathlib.Path('src/overview.rs' if kind=='wrong-file-record' else 'src/map.rs')
s=p.read_text()
if kind=='old-header-formatter':
 old_source=subprocess.check_output(['git','show','9e831b8f6:src/map.rs'],text=True)
 start='pub(super) fn details(';end='fn hashing(path:'
 old=s[s.index(start):s.index(end,s.index(start))]
 new=old_source[old_source.index(start):old_source.index(end,old_source.index(start))]
elif kind=='truncated-version':
 old='add("bench-hashes", version.to_owned(), String::new());'
 new='add("bench-hashes", version.split(\'+\').next().unwrap_or("").to_owned(), String::new());'
else:
 old='("File-tool run", "b3sum.samples.tsv", b3sum.as_ref()),'
 new='("File-tool run", "b3sum.samples.tsv", hashing.as_ref()),'
assert s.count(old)==1,(kind,old)
p.write_text(s.replace(old,new))
PY
  filter='test(provenance_keeps_the_library_file_and_earlier_records_separate)'
  [ "$control" != old-header-formatter ] || filter='test(recorded_software_precedes_conditions_and_keeps_identity_fields)'
  set +e
  cargo nextest run --release --locked -j 2 -E "$filter" > "$O/$control.txt" 2>&1
  status=$?
  set -e
  git restore -- src/map.rs src/overview.rs
  printf '%s exit=%s (expected test failure100)\n' "$control" "$status" >> "$O/controls.txt"
  test "$status" = 100
done
cargo nextest run --release --locked -j 2 -E 'test(provenance_keeps_the_library_file_and_earlier_records_separate) | test(recorded_software_precedes_conditions_and_keeps_identity_fields)' > "$O/restored.txt" 2>&1
test "$(git diff --name-only)" = index.html
printf 'DONE: source restored; overview generated; no performance collection\n'
