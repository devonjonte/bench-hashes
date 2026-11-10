#!/bin/sh
# bench-hashes #166's end-to-end control: run `e` again (the November 7 whole-map check, which read "no cell slower"
# with a cell at x1.38), judged by the same bench with #166's repair (scratch/devon-166-replay 0a6323fe).
set -u
export PATH=/home/agent/.cargo/bin:$PATH TMPDIR=/home/agent/tmp
cd /home/agent/bench-ac16
git log --oneline -1 | cut -c1-80
./target/release/bench-hashes check --fork /home/agent/BLAKE3-m3 --new 8d6525c3 --against b5b988d8 --old-bench 3363bee8 --cells all --keep /home/agent/bench-hashes-validation/long-shared/kept-f --when-quiet
echo "check exit $?"
