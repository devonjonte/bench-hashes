#!/bin/sh
# The core's gate, pinned, on the two EPYC 7443 read one cell slower than 0.8 at four pairs, each pair +10.5 to
# +14.4%: single-threaded "many messages at once, in pieces", a turn of 256 (update_each). Bench next 77d4a7650c1bf97f0e05954089af6ccda743e3ed.
# 0. next against 0.8, that cell and its neighbours by name: does it repeat, and at 64 pairs?
# 1. the 0.21 pin (2037118c) against 0.8: there before next?
# 2. next against the pin, one bench: the library's, since the pin?
set -eu
export PATH=$HOME/.cargo/bin:$PATH
O=$HOME/runs/iso-turn
cd $HOME/work/bench-hashes; git fetch -q origin; git -C $HOME/work/BLAKE3 fetch -q origin; git checkout -q --detach 77d4a7650c1bf97f0e05954089af6ccda743e3ed; test "$(git rev-parse HEAD)" = 77d4a7650c1bf97f0e05954089af6ccda743e3ed; cargo build --release 2>&1 | tail -1
P="turn 256,interleaved 256,idle turn 256,brief idle turn 256"
set +e
echo "== 0: next against 0.8, by name"
./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new c10d6804f246767a79025332704f9843b3d96351 --against b5b988d8 --old-bench 3363bee8 --contenders blake3-servil-st --points "$P" --when-quiet --keep $O/kept-next-08
echo "check exit $? $(date -u +%H:%M)"
echo "== 1: the 0.21 pin against 0.8"
./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new 2037118ca1da85710aef55d7f13b3abd9095b485 --against b5b988d8 --old-bench 3363bee8 --contenders blake3-servil-st --points "$P" --when-quiet --keep $O/kept-pin-08
echo "check exit $? $(date -u +%H:%M)"
echo "== 2: next against the 0.21 pin, one bench"
./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new c10d6804f246767a79025332704f9843b3d96351 --against 2037118ca1da85710aef55d7f13b3abd9095b485 --contenders blake3-servil-st --points "$P" --when-quiet --keep $O/kept-library
echo "check exit $? $(date -u +%H:%M)"
echo "== done"
