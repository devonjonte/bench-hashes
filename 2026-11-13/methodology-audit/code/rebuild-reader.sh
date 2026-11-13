#!/bin/sh
set -eu
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH
export TMPDIR=/home/agent/tmp
cd /home/agent/bench-022
cargo build --release
cargo nextest run --release
cargo fmt --check
