#!/bin/sh
set -eu
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH
export TMPDIR=/home/agent/tmp
export CARGO_BUILD_JOBS=2
cd /home/agent/bench-incremental-lifetime
cargo fmt
cargo nextest run --release --locked
cargo fmt --check
