#!/bin/sh
set -eu
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH
export TMPDIR=/home/agent/tmp
export CARGO_BUILD_JOBS=2
cd /home/agent/bench-layout-repeat-assessment
test "$(git rev-parse HEAD)" = 186cea4b37807488f10d81651c62aa9823585c80
git diff --exit-code 2c8676842feab053fa7855d4cb3393bdea26ed4a -- clocks/src
cargo run --release --locked -p clocks --example layout_repeat_control
