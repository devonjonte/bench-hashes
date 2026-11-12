#!/bin/sh
# The core's gate on this machine read five cells slower than 0.8 over 64 pairs: single-threaded one message
# after other work, 2304 B (+3.3%), 4 KiB (+6.5%), 4470 B (+3.6%), 16 KiB (+3.2%), 32 KiB (+4.9%). That check
# crosses two benches, and 0.21's release check here (the pin 2037118c against 0.8) read no cell slower. So:
# 1. next (c10d6804) against the 0.21 pin (2037118c), ONE bench (cb9dc38421279268b20fb91109fba6c7f33af783) on both sides, those cells by name:
#    is it the library's, between the pin and next?
# 2. the 0.21 tag's bench against today's, ONE library (2037118c) on both sides, the same cells: is it the bench's?
set -eu
export PATH=$HOME/.cargo/bin:$PATH
O=$HOME/runs/core-gate-iso
cd $HOME/work/bench-hashes; test "$(git rev-parse HEAD)" = cb9dc38421279268b20fb91109fba6c7f33af783; test -x ./target/release/bench-hashes
P="2304 B,4 KiB,4470 B,16 KiB,32 KiB,3 KiB,8 KiB"
set +e
echo "== 1: next against the 0.21 pin, one bench"
./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new c10d6804f246767a79025332704f9843b3d96351 --against 2037118ca1da85710aef55d7f13b3abd9095b485 --contenders blake3-servil-st --points "$P" --when-quiet --keep $O/kept-library
echo "check exit $? $(date -u +%H:%M)"
echo "== 2: today's bench against the 0.21 tag's, one library (the pin)"
./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new 2037118ca1da85710aef55d7f13b3abd9095b485 --against 2037118ca1da85710aef55d7f13b3abd9095b485 --old-bench 9434d50e --contenders blake3-servil-st --points "$P" --when-quiet --keep $O/kept-bench
echo "check exit $? $(date -u +%H:%M)"
echo "== done"
