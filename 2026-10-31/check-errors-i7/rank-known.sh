#!/bin/sh
# The suspects ranked by evidence (clocks Judgment::rank): known truth x3, A/A x3.
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp; unset RUSTFLAGS
O=/home/agent/bench-hashes-validation/check-errors-i7
cd /home/agent/BLAKE3-aa/bench-hashes
for i in 1 2 3; do
	echo "== rank-known $i $(date -u +%H:%M)"
	cargo run -q --release -- check --against 4733e5118fbbecc253e6585e249ab30547b43697 --keep $O/rank-known-$i > $O/rank-known-$i.stdout.txt 2> $O/rank-known-$i.stderr.txt; echo "rank-known $i exit $?"
done
