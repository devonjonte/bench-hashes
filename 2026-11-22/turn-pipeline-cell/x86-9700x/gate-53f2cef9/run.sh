#!/bin/sh
# Declared before running (November 22, 2026): bench-hashes #258, the gate. Every cell, one library under bench next and the candidate. Expected: the mt turn cells at 1024 x 1 KiB faster (the Pipeline); the st turn cells at 256 after idling 4% to 8% slower (the neighbour effect the probes found: st alone in the process reads level); every other cell level, and no level cell's instructions moved. Anything else is a defect of the change. Original header: One library (BLAKE3-Servil 0.10.0, 2fd4ff6f)
# under two benches: next (ed3688ca), whose mt turn cells call update_each_multithreaded, and the candidate
# (53f2cef9), whose mt turn cells go through a Pipeline with a Room per open message. check --probe prints each
# named cell's ratio (three fresh pairs), no verdict. The question: what does the Pipeline give a turn after
# a gap, at both turn points, and does the single-threaded contender stay level (it must: its code is unchanged)?
set -eu
export PATH="$HOME/.cargo/bin:$PATH" CARGO_BUILD_JOBS=16 CARGO_INCREMENTAL=0
unset CARGO_TARGET_DIR RUSTFLAGS CARGO_ENCODED_RUSTFLAGS
V=53f2cef9a34ace5c6140b6a547f549e5da22a435
OLDBENCH=ed3688caff37d28d8519aab9b125001b26e5402e
NEW=2fd4ff6f643ef04f98f7a2e5f8ca0f096298827a
O=$PWD
B="$HOME/work/bench-pipeline-turn"; M="$HOME/work/lib-pipeline-turn"
rm -rf "$B" "$M"
git clone -q --filter=blob:none --no-checkout https://github.com/servil-software-factory/bench-hashes "$B"
git -C "$B" fetch -q origin '+refs/heads/*:refs/remotes/origin/*'
git -C "$B" checkout -q --detach "$V"
git clone -q --filter=blob:none --no-checkout https://github.com/servil-software-factory/BLAKE3 "$M"
git -C "$M" fetch -q origin '+refs/heads/*:refs/remotes/origin/*'
git -C "$M" checkout -q --detach "$NEW"
cd "$B"
cargo build --release --locked > "$O/build.txt" 2>&1
./target/release/bench-hashes check --fork "$M" --new "$NEW" --against "$NEW" --old-bench "$OLDBENCH" \
    --cells all \
    --when-quiet --keep "$O/kept-gate" > "$O/gate.stdout.txt" 2> "$O/gate.stderr.txt" || printf 'gate exit %s\n' "$?" > "$O/exit.txt"
cat "$O/gate.stdout.txt"
