#!/bin/sh
set -eu
export PATH=<development-home>/.cargo/bin:<development-home>/bin:$PATH
export TMPDIR=<development-home>/tmp
export CARGO_BUILD_JOBS=2
export CARGO_TARGET_DIR=<development-home>/bench-repeat-report/target
cd <development-home>/bench-kept-comparisons
cargo fmt
cargo nextest run --release --locked
cargo fmt --check
git diff --check
