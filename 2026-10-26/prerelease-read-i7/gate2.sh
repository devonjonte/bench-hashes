#!/bin/sh
set -eu
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp
cd /home/agent/BLAKE3-prerel
export CARGO_TARGET_DIR=/home/agent/BLAKE3-prerel/target
s() { echo "== $*"; "$@"; }
s cargo fmt --all --check
s cargo nextest run --cargo-quiet --features serde,zeroize
s cargo nextest run --cargo-quiet --no-default-features
s cargo test -q --doc --features serde,zeroize
s cargo nextest run --cargo-quiet --release --manifest-path capi/Cargo.toml
s cargo nextest run --cargo-quiet --manifest-path b3sum/Cargo.toml
s cargo nextest run --cargo-quiet --manifest-path b3sum/Cargo.toml --no-default-features
s cargo nextest run --cargo-quiet --manifest-path clocks/Cargo.toml
RUSTFLAGS="--cfg shuttle" s cargo test -q --release --test shuttle_park --test shuttle_finish
RUSTDOCFLAGS='-D warnings' s cargo doc -q --no-deps
s python3 tools/mutants/test_check.py
PYTHONPATH=/home/agent/pylib s python3 -m unittest discover -s tools/verify -p 'test_*.py'
s python3 tools/qa_coverage.py >/dev/null
CARGO_TARGET_DIR=/home/agent/BLAKE3-prerel/target/check-builds s sh tools/check-builds.sh
echo "GATE PASSED"
