#!/bin/sh
# BLAKE3 #357 step 3: the one cell outside the stream's that the every-cell check flagged on this machine
# (single-threaded one message of 4 MiB after a pause, +4.0% at four pairs), by name with its neighbours,
# so the second stage gives it 64 pairs. next c10d6804 against 0.8.
set -eu
export PATH=$HOME/.cargo/bin:$PATH
O=$HOME/runs/next-vs-08; cd $HOME/work/bench-hashes
test "$(git rev-parse HEAD)" = 774a6b63d5b3b6781754d4e1f65c89e44ba2273b
set +e
./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new c10d6804f246767a79025332704f9843b3d96351 --against b5b988d8 --old-bench 3363bee8 --points "idle 4 MiB,idle 1 MiB,idle 256 KiB" --when-quiet --keep $O/kept-idle
echo "check exit $? $(date -u +%H:%M)"
