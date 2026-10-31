#!/bin/sh
# The 64-pair second stage, the bench's ranking by ratio: known truth x3
# (old: the #119 fix f108640d; new: servil 70ddb676), then A/A x3.
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp; unset RUSTFLAGS
O=/home/agent/bench-hashes-validation/check-errors-i7
cd /home/agent/BLAKE3-aa/bench-hashes
for i in 1 2 3; do
	echo "== reuse-check-known $i $(date -u +%H:%M)"
	cargo run -q --release -- check --against f108640d0b5240ae2e146d99e77027a0d262412c --keep $O/reuse-check-known-$i > $O/reuse-check-known-$i.stdout.txt 2> $O/reuse-check-known-$i.stderr.txt; echo "exit $?"
done
for i in 1 2 3; do
	echo "== reuse-check-aa $i $(date -u +%H:%M)"
	cargo run -q --release -- check --against 70ddb67663c00d25376af82014b5bf6cccf5282c --cells all --keep $O/reuse-check-aa-$i > $O/reuse-check-aa-$i.stdout.txt 2> $O/reuse-check-aa-$i.stderr.txt; echo "exit $?"
done
