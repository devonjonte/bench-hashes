#!/bin/sh
set -eu
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH
export TMPDIR=/home/agent/tmp
cd /home/agent/bench-incremental-lifetime
cargo fmt
cargo check --tests --release --locked
