#!/bin/sh
# Declared before running (November 22, 2026): a probe of one question. Many messages open at once, their
# pieces arriving interleaved: how do the Hashers' turn call (update_each, single- and multithreaded) and the
# Pipeline compare, in wall time and CPU time per byte, on BLAKE3-Servil 0.10.0 (2fd4ff6f) plus one example
# file (devonjonte/BLAKE3 99d44b41, never to land; a fourth arm: the Pipeline with a Room per open message whatever its length, the caller that knows no lengths)? Two workloads: 1024 open x 1 KiB in 256 B pieces (the
# bench's turn point), and 64 open x 1 MiB in 16 KiB pieces. 31 rounds, arms in rotating order.
set -eu
export PATH="$HOME/.cargo/bin:$PATH" CARGO_BUILD_JOBS=16 CARGO_INCREMENTAL=0
unset CARGO_TARGET_DIR RUSTFLAGS CARGO_ENCODED_RUSTFLAGS
C=99d44b41d52de0a8a2f9f87d13a309fd1094e570
W="$HOME/work/turn-pipeline-probe"
rm -rf "$W"
git clone -q --filter=blob:none --no-checkout https://github.com/devonjonte/BLAKE3 "$W"
git -C "$W" fetch -q origin "$C"
git -C "$W" checkout -q --detach "$C"
cd "$W/threads"
{ uname -srm; rustc -V; nproc; lscpu | grep -m1 'Model name'; git -C "$W" rev-parse HEAD; } > "$OLDPWD/toolchain.txt"
cargo build --release --example turn_pipeline_probe > "$OLDPWD/build.txt" 2>&1
cd "$OLDPWD"
"$W/threads/target/release/examples/turn_pipeline_probe" 31 > probe-1.txt
"$W/threads/target/release/examples/turn_pipeline_probe" 31 > probe-2.txt
cat probe-1.txt probe-2.txt
rm -rf "$W"
