#!/bin/sh
set -eu
export PATH=<development-home>/.cargo/bin:<development-home>/bin:$PATH
export TMPDIR=<development-home>/tmp
export CARGO_BUILD_JOBS=2
export CARGO_TARGET_DIR=<development-home>/bench-repeat-report/target
cd <development-home>/bench-samecode-data
cargo fmt
set +e
cargo nextest run --release --locked -E 'test(ordinary_data_with_a_rust_filename)'
status=$?
set -e
printf 'original location-mask control exit: %s\n' "$status"
test "$status" = 100
