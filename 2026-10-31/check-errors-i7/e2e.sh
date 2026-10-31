#!/bin/sh
# End to end: check with the 64-pair second stage, known truth x3, under
# the ranking in the working tree (VARIANT names it).
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp; unset RUSTFLAGS
O=/home/agent/bench-hashes-validation/check-errors-i7
cd /home/agent/BLAKE3-aa/bench-hashes
for i in 1 2 3; do
	echo "== $VARIANT-known $i $(date -u +%H:%M)"
	cargo run -q --release -- check --against 4733e5118fbbecc253e6585e249ab30547b43697 --keep $O/$VARIANT-known-$i > $O/$VARIANT-known-$i.stdout.txt 2> $O/$VARIANT-known-$i.stderr.txt; echo "exit $?"
done
