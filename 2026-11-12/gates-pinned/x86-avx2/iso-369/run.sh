#!/bin/sh
# BLAKE3 #369: single-threaded batches of 2 and 4 after a brief pause read 4.4% and 3.2% slower than 0.8 on this
# machine in 0.21's release check, which ran unpinned. The same cells, pinned (bench next 77d4a7650c1bf97f0e05954089af6ccda743e3ed), by name:
# the 0.21 pin (2037118c) against 0.8, as then; and next (c10d6804) against 0.8.
set -eu
export PATH=$HOME/.cargo/bin:$PATH
O=$HOME/runs/iso-369
cd $HOME/work/bench-hashes; git fetch -q origin; git -C $HOME/work/BLAKE3 fetch -q origin; git checkout -q --detach 77d4a7650c1bf97f0e05954089af6ccda743e3ed; test "$(git rev-parse HEAD)" = 77d4a7650c1bf97f0e05954089af6ccda743e3ed
cargo build --release 2>&1 | tail -1
P="brief idle 2,brief idle 4,brief idle 3,brief idle 8,brief idle 1"
set +e
echo "== 1: the 0.21 pin against 0.8"
./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new 2037118ca1da85710aef55d7f13b3abd9095b485 --against b5b988d8 --old-bench 3363bee8 --contenders blake3-servil-st --points "$P" --when-quiet --keep $O/kept-pin
echo "check exit $? $(date -u +%H:%M)"
echo "== 2: next against 0.8"
./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new c10d6804f246767a79025332704f9843b3d96351 --against b5b988d8 --old-bench 3363bee8 --contenders blake3-servil-st --points "$P" --when-quiet --keep $O/kept-next
echo "check exit $? $(date -u +%H:%M)"
echo "== done"
