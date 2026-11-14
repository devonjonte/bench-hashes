#!/bin/sh
set -eu
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH
export TMPDIR=/home/agent/tmp
cd /home/agent/bench-pipeline
cargo fmt --check
cargo nextest run --release
cargo nextest run -E 'test(pipeline::tests::)'
git diff --check
