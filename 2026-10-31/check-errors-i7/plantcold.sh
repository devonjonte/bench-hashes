#!/bin/sh
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp; unset RUSTFLAGS
O=/home/agent/bench-hashes-validation/check-errors-i7
cd /home/agent/BLAKE3-plant/bench-hashes
for i in 1 2; do
	cargo run -q --release -- check --against 70ddb67663c00d25376af82014b5bf6cccf5282c --cells all --keep $O/plantcold-$i > $O/plantcold-$i.stdout.txt 2> $O/plantcold-$i.stderr.txt; echo "plant $i exit $?"
	git checkout -q -- Cargo.lock 2>/dev/null
done
