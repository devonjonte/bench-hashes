#!/bin/sh
# bench-hashes check's error rates on the i7 (overnight, October 31):
# A/A, the same commit on both sides, N times; each run's verdict, stage-1
# suspects and stage-2 judgments kept. Planted runs follow (plant.sh).
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp
unset RUSTFLAGS
O=/home/agent/bench-hashes-validation/check-errors-i7
cd /home/agent/BLAKE3-aa/bench-hashes
N=${N:-4}
for i in $(seq 1 $N); do
	echo "== aa $i $(date -u +%H:%M)"
	cargo run -q --release -- check --against 70ddb67663c00d25376af82014b5bf6cccf5282c --cells all --keep $O/aa-$i > $O/aa-$i.stdout.txt 2> $O/aa-$i.stderr.txt
	echo "aa $i exit $?"
	git checkout -q -- Cargo.lock 2>/dev/null
done
