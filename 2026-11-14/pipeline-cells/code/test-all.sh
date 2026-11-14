#!/bin/sh
set -eu
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH
export TMPDIR=/home/agent/tmp
cd /home/agent/bench-pipeline
cargo fmt
cargo nextest run --release
cargo fmt --check
cargo build --release
