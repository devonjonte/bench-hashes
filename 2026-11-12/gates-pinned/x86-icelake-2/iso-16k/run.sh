#!/bin/sh
# The core's gate on the other Xeon Gold 6330 pair read messages of 16 KiB one after another (single-threaded,
# throughput::hash) +66.9% against 0.8 at four pairs, each pair +63 to +70%. One variable at a time, on this
# pair (the same hardware), bench next 77d4a7650c1bf97f0e05954089af6ccda743e3ed:
# 0. the gate's own comparison, those cells by name: does it repeat here?
# 1. next (c10d6804) against the 0.21 pin (2037118c), one bench: the library's?
# 2. today's bench against the 0.21 tag's, one library (the pin): the bench's?
set -eu
export PATH=$HOME/.cargo/bin:$PATH
O=$HOME/runs/iso-16k
mkdir -p $HOME/work && cd $HOME/work; [ -d bench-hashes ] || git clone -q https://github.com/servil-software-factory/bench-hashes.git; [ -d BLAKE3 ] || git clone -q https://github.com/servil-software-factory/BLAKE3.git; git -C BLAKE3 fetch -q origin; cd bench-hashes; git fetch -q origin; git checkout -q --detach 77d4a7650c1bf97f0e05954089af6ccda743e3ed; test "$(git rev-parse HEAD)" = 77d4a7650c1bf97f0e05954089af6ccda743e3ed; cargo build --release 2>&1 | tail -1
P="continuous 16 KiB,lent 16 KiB,16 KiB,lent 4 KiB,lent 64 KiB,continuous 4 KiB,continuous 64 KiB"
set +e
echo "== 0: next against 0.8, by name"
./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new c10d6804f246767a79025332704f9843b3d96351 --against b5b988d8 --old-bench 3363bee8 --contenders blake3-servil-st --points "$P" --when-quiet --keep $O/kept-gate
echo "check exit $? $(date -u +%H:%M)"
echo "== 1: next against the 0.21 pin, one bench"
./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new c10d6804f246767a79025332704f9843b3d96351 --against 2037118ca1da85710aef55d7f13b3abd9095b485 --contenders blake3-servil-st --points "$P" --when-quiet --keep $O/kept-library
echo "check exit $? $(date -u +%H:%M)"
echo "== 2: today's bench against the 0.21 tag's, one library (the pin)"
./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new 2037118ca1da85710aef55d7f13b3abd9095b485 --against 2037118ca1da85710aef55d7f13b3abd9095b485 --old-bench 9434d50e --contenders blake3-servil-st --points "$P" --when-quiet --keep $O/kept-bench
echo "check exit $? $(date -u +%H:%M)"
echo "== done"
