#!/bin/sh
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp
unset RUSTFLAGS
cd /home/agent/BLAKE3-budget/bench-hashes
echo "== check $(date -u +%H:%M)"
cargo run -q --release -- check --against 351c679 --cells all --keep /home/agent/bench-hashes-validation/budget-i7/check
echo "== check exit $? $(date -u +%H:%M)"
C=/home/agent/BLAKE3-budget/target/check
O=$(ls $C/old/bench-hashes-* | sort -t- -k3 -n | head -16 | tr '\n' ' ')
N=$(ls -t $C/new/bench-hashes-* | head -16 | tr '\n' ' ')
echo "== regress $(date -u +%H:%M)"
./target/release/bench-hashes regress --contenders blake3-servil-mt --points "512 KiB,1 MiB,2 MiB,3 MiB,4 MiB,8 MiB,idle 512 KiB,idle 1 MiB,idle 2 MiB,idle 3 MiB,idle 4 MiB,idle 8 MiB,lent 1 MiB,lent 4 MiB,merkle 4096,merkle 16384" --pairs 16 --keep /home/agent/bench-hashes-validation/budget-i7/regress $O -- $N
echo "== regress exit $? $(date -u +%H:%M)"
