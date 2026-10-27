#!/bin/sh
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp
cd /home/agent/BLAKE3-prerel
export CARGO_TARGET_DIR=/home/agent/BLAKE3-prerel/target/miri
MIRIFLAGS="-Zmiri-num-cpus=4 -Zmiri-ignore-leaks" cargo +nightly miri nextest run --profile miri miri
echo "== miri exit $?"
