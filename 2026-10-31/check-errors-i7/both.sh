#!/bin/sh
# The 64-pair second stage, the bench's ranking by ratio: known truth x3
# (old: the #119 fix f108640d; new: servil 70ddb676), then A/A x3.
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp; unset RUSTFLAGS
O=/home/agent/bench-hashes-validation/check-errors-i7
cd /home/agent/BLAKE3-aa/bench-hashes
for i in 1 2 3; do
	echo "== both-known $i $(date -u +%H:%M)"
	cargo run -q --release -- check --against 4733e5118fbbecc253e6585e249ab30547b43697 --keep $O/both-known-$i > $O/both-known-$i.stdout.txt 2> $O/both-known-$i.stderr.txt; echo "exit $?"
done
for i in 1 2 3; do
	echo "== both-aa $i $(date -u +%H:%M)"
	cargo run -q --release -- check --against 2702a9995f3b85993a323b643ab054e7a0da2938 --cells all --keep $O/both-aa-$i > $O/both-aa-$i.stdout.txt 2> $O/both-aa-$i.stderr.txt; echo "exit $?"
done
