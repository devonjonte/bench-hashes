#!/bin/sh
set -eu
O=<development-home>/bench-hashes-validation/progress-failfast
cd "$O/ring-control"
C="$O/nextest.toml"
cargo nextest run --release --config-file "$C" -P mutants > "$O/baseline.txt" 2>&1
cp src/lib.rs "$O/baseline.rs"
python3 - <<'PY'
from pathlib import Path
p=Path('src/lib.rs');s=p.read_text();old='self.len -= 1;';assert s.count(old)==1
p.write_text(s.replace(old,'self.len /= 1;'))
PY
set +e
cargo nextest run --release --config-file "$C" -P mutants -E 'test(ordinary_cleanup)' > "$O/ordinary-mutant.txt" 2>&1
ordinary=$?
cargo nextest run --release --config-file "$C" -P mutants -E 'test(protected_cleanup)' > "$O/protected-mutant.txt" 2>&1
protected=$?
set -e
cp "$O/baseline.rs" src/lib.rs
printf 'ordinary=%s protected=%s\n' "$ordinary" "$protected"
test "$ordinary" = 100
test "$protected" = 100
grep -E 'TIMEOUT|TIME-OUT' "$O/ordinary-mutant.txt"
grep -F 'FAIL' "$O/protected-mutant.txt"
if grep -Eq 'TIMEOUT|TIME-OUT' "$O/protected-mutant.txt"; then exit 1; fi
cargo nextest run --release --config-file "$C" -P mutants > "$O/restored.txt" 2>&1
printf 'PASS: normal sources restored; existing timeout and direct assertion distinguished\n'
