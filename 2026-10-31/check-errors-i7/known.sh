#!/bin/sh
# Known truth: new = servil (ships #119's cold cost), old = its fix (#210).
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp; unset RUSTFLAGS
O=/home/agent/bench-hashes-validation/check-errors-i7
cd /home/agent/BLAKE3-aa/bench-hashes
for i in 1 2; do
	cargo run -q --release -- check --against f108640d0b5240ae2e146d99e77027a0d262412c --keep $O/known-$i > $O/known-$i.stdout.txt 2> $O/known-$i.stderr.txt; echo "known $i exit $?"
	git checkout -q -- Cargo.lock 2>/dev/null
done
