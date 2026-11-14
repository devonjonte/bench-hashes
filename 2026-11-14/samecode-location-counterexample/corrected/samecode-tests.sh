#!/bin/sh
set -eu
export PATH=<development-home>/.cargo/bin:<development-home>/bin:$PATH
export TMPDIR=<development-home>/tmp
export CARGO_BUILD_JOBS=2
export CARGO_TARGET_DIR=<development-home>/bench-repeat-report/target
cd <development-home>/bench-samecode-data
cargo fmt
cargo nextest run --release --locked
cargo fmt --check
git diff --check
out=<development-home>/bench-hashes-validation/autonomous-20261114/samecode-corrected
inputs=<development-home>/bench-hashes-validation/autonomous-20261114/samecode-counterexample/build
cp src/samecode.rs "$out/samecode.rs"
rustc --version
rustc --edition=2024 "$out/compare.rs" -o "$out/compare"
for suffix in rs bin; do
    "$out/compare" "$inputs/$suffix-111" "$inputs/$suffix-111" > "$out/$suffix-unchanged.txt"
    "$out/compare" "$inputs/$suffix-111" "$inputs/$suffix-222" > "$out/$suffix-changed.txt"
    grep -Fx 'Some(Same)' "$out/$suffix-unchanged.txt"
    grep -Fx 'Some(Differs { sections: [".data.rel.ro"], resized: [], changed: [] })' "$out/$suffix-changed.txt"
done
printf 'Corrected comparator detects both changed-data pairs and retains both unchanged exits.\n'
