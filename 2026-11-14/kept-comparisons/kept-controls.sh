#!/bin/sh
set -eu
export PATH=<development-home>/.cargo/bin:<development-home>/bin:$PATH
export TMPDIR=<development-home>/tmp
export CARGO_BUILD_JOBS=2
export CARGO_TARGET_DIR=<development-home>/bench-repeat-report/target
cd <development-home>/bench-kept-comparisons
cargo fmt
set +e
cargo nextest run --release --locked -E 'test(kept_results_require) | test(a_probe_compares)'
status=$?
set -e
printf 'uncorrected implementation test exit: %s\n' "$status"
test "$status" = 100
