#!/bin/sh
# The thread crate's gate, pinned, on the first Xeon Gold 6330 pair read one cell slower than 0.8 at four pairs,
# each pair +64 to +107%: multithreaded, one message of 3 KiB after a brief pause (20 us); every neighbour reads
# 22 to 51% FASTER. Bench next 77d4a7650c1bf97f0e05954089af6ccda743e3ed.
# 0. next against 0.8, that cell and its neighbours by name, both contenders: does it repeat?
# 1. next against the 0.21 pin (2037118c), one bench: the library's, since the pin?
# 2. the 0.21 pin against 0.8: there before?
set -eu
export PATH=$HOME/.cargo/bin:$PATH
O=$HOME/runs/iso-brief3k
cd $HOME/work/bench-hashes; git fetch -q origin; git -C $HOME/work/BLAKE3 fetch -q origin; git checkout -q --detach 77d4a7650c1bf97f0e05954089af6ccda743e3ed; test "$(git rev-parse HEAD)" = 77d4a7650c1bf97f0e05954089af6ccda743e3ed
cargo build --release 2>&1 | tail -1
P="brief idle 3 KiB,brief idle 2304 B,brief idle 3839 B,brief idle 4 KiB,idle 3 KiB,3 KiB"
set +e
echo "== 0: next against 0.8, by name"
./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new c10d6804f246767a79025332704f9843b3d96351 --against b5b988d8 --old-bench 3363bee8 --points "$P" --when-quiet --keep $O/kept-next-08
echo "check exit $? $(date -u +%H:%M)"
echo "== 1: next against the 0.21 pin, one bench"
./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new c10d6804f246767a79025332704f9843b3d96351 --against 2037118ca1da85710aef55d7f13b3abd9095b485 --points "$P" --when-quiet --keep $O/kept-library
echo "check exit $? $(date -u +%H:%M)"
echo "== 2: the 0.21 pin against 0.8"
./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new 2037118ca1da85710aef55d7f13b3abd9095b485 --against b5b988d8 --old-bench 3363bee8 --points "$P" --when-quiet --keep $O/kept-pin-08
echo "check exit $? $(date -u +%H:%M)"
echo "== done"
