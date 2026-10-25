#!/bin/sh
# FANOUT 8, 4 and 64 against the release integration's wakes-8 (ee4c0d7),
# each a check of the cells the change touches, 8 pairs.
set -u
cd /home/agent/BLAKE3-fanout
for f in 8 4 64; do
  sed -i "s/^pub(crate) const FANOUT: usize = [0-9]*;/pub(crate) const FANOUT: usize = $f;/" src/park.rs
  grep -n '^pub(crate) const FANOUT' src/park.rs
  echo "== FANOUT $f, $(date -u +%H:%M:%S)"
  (cd bench-hashes && cargo run --release -q -- check --against ee4c0d7 --pairs 8 --keep /home/agent/bench-hashes-validation/fanout-i7/f$f)
  echo "exit $?"
done
sed -i "s/^pub(crate) const FANOUT: usize = [0-9]*;/pub(crate) const FANOUT: usize = 8;/" src/park.rs
