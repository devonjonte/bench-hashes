#!/bin/sh
# Three convenience-only (cold) variants against #248's branch, the cold columns (after other work, after 5 ms,
# after 20 us) at 1536 B-4 KiB; each a check --probe (3 pairs, no verdict). Quiet machine required (gate inside).
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp; unset RUSTFLAGS
O=/home/agent/bench-hashes-validation/cold-probes-i7
cd /home/agent/bench-0194
P="1536 B,2 KiB,2304 B,3 KiB,4 KiB,idle 1536 B,idle 2 KiB,idle 2304 B,idle 3 KiB,idle 4 KiB,brief idle 2 KiB,brief idle 3 KiB,lent 4 KiB"
for b in cold-serial cold-prefetch cold-two-plus-partial; do
  s=$(date +%s)
  ./target/release/bench-hashes check --fork /home/agent/BLAKE3-m3 --new exp/devon-$b --against candidate/devon-round-up-lanes --probe "$P" --when-quiet > $O/$b.out 2> $O/$b.err
  echo "== $b exit $? in $(( $(date +%s) - s )) s $(date -u +%H:%M)"
  git checkout -q -- Cargo.lock
done
