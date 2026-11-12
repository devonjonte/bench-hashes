#!/bin/sh
# BLAKE3 #376: a candidate that sends one or two inputs and a count that is a kernel's width straight to their
# kernel (my fork, candidate/devon-exact-lanes-direct 747770a4730711c56e72e63b6e847ce2ff7ee118) against next (73ee859efce085d28f1c2b22c35a5703403476f7), one bench (pinned), the
# single-threaded one-message cells after other work around 4 KiB, 16 layouts a side (16 pairs: the effect looked
# for is 5%, which four pairs do not show).
set -eu
export PATH=$HOME/.cargo/bin:$PATH
O=$HOME/runs/exact-lanes
cd $HOME/work/BLAKE3; git remote | grep -q devon || git remote add devon https://github.com/devonjonte/BLAKE3.git
git fetch -q origin; git fetch -q devon candidate/devon-exact-lanes-direct; test "$(git rev-parse FETCH_HEAD)" = 747770a4730711c56e72e63b6e847ce2ff7ee118
cd $HOME/work/bench-hashes; git fetch -q origin; git checkout -q --detach 5f99f456951ab36f7201decd8aa5e0249ec67bd1
cargo build --release 2>&1 | tail -1
set +e
./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new 747770a4730711c56e72e63b6e847ce2ff7ee118 --against 73ee859efce085d28f1c2b22c35a5703403476f7 --contenders blake3-servil-st --points "4 KiB,4470 B,3 KiB,3839 B,8 KiB,16 KiB,32 KiB,2 KiB,1 KiB" --layouts 16 --when-quiet --keep $O/kept
echo "check exit $? $(date -u +%H:%M)"
