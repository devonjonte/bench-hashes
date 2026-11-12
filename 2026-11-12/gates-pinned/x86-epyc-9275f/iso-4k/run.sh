#!/bin/sh
# The core's gate, pinned, still read two cells slower than 0.8 here over 64 pairs: single-threaded one message
# after other work, 4 KiB +5.6% and 4470 B +4.1% (pairs from -16% to +28%). Bench next 77d4a7650c1bf97f0e05954089af6ccda743e3ed.
# 1. next against the 0.21 pin (2037118c), one bench, those cells by name, twice: the library's?
# 2. the 0.21 pin against 0.8 (the comparison 0.21's release check made, now pinned), by name: there before next?
# 3. next against 0.8 by name, once more: does it repeat?
set -eu
export PATH=$HOME/.cargo/bin:$PATH
O=$HOME/runs/iso-4k
mkdir -p $HOME/work && cd $HOME/work; [ -d bench-hashes ] || git clone -q https://github.com/servil-software-factory/bench-hashes.git; [ -d BLAKE3 ] || git clone -q https://github.com/servil-software-factory/BLAKE3.git; git -C BLAKE3 fetch -q origin; cd bench-hashes; git fetch -q origin; git checkout -q --detach 77d4a7650c1bf97f0e05954089af6ccda743e3ed; test "$(git rev-parse HEAD)" = 77d4a7650c1bf97f0e05954089af6ccda743e3ed; cargo build --release 2>&1 | tail -1
P="4 KiB,4470 B,3 KiB,3839 B,8 KiB"
set +e
for n in 1 2; do
echo "== 1.$n: next against the 0.21 pin, one bench"
./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new c10d6804f246767a79025332704f9843b3d96351 --against 2037118ca1da85710aef55d7f13b3abd9095b485 --contenders blake3-servil-st --points "$P" --when-quiet --keep $O/kept-library-$n
echo "check exit $? $(date -u +%H:%M)"
done
echo "== 2: the 0.21 pin against 0.8"
./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new 2037118ca1da85710aef55d7f13b3abd9095b485 --against b5b988d8 --old-bench 3363bee8 --contenders blake3-servil-st --points "$P" --when-quiet --keep $O/kept-pin-08
echo "check exit $? $(date -u +%H:%M)"
echo "== 3: next against 0.8"
./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new c10d6804f246767a79025332704f9843b3d96351 --against b5b988d8 --old-bench 3363bee8 --contenders blake3-servil-st --points "$P" --when-quiet --keep $O/kept-next-08
echo "check exit $? $(date -u +%H:%M)"
echo "== done"
