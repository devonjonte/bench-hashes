#!/bin/sh
# BLAKE3 #248 rebased on next, and #276 stacked on it: suites, builds, mutation checks, then speed.
set -eu
export PATH=/home/agent/.cargo/bin:$PATH TMPDIR=/home/agent/tmp
for d in /home/agent/BLAKE3-248 /home/agent/BLAKE3-276; do
  cd $d; echo "== $d $(git rev-parse --short HEAD)"
  cargo fmt --check
  cargo nextest run --cargo-quiet --release 2>&1 | tail -1
  cargo test -q --release --doc 2>&1 | tail -1
  sh tools/check-builds.sh | tail -1
done
cd /home/agent/BLAKE3-248 && python3 tools/mutants/check.py --since origin/next | grep -E '^NEW|STALE|NO LONGER|CAUGHT|mutants: the change since|took' || true
cd /home/agent/BLAKE3-276 && python3 tools/mutants/check.py --since d3e907a8ef7b7064beb9b640e32d910a200d3439 | grep -E '^NEW|STALE|NO LONGER|CAUGHT|mutants: the change since|took' || true
cd /home/agent/bench-0194
echo "== speed: #248 against next"
./target/release/bench-hashes check --fork /home/agent/BLAKE3-248 --new candidate/devon-round-up-lanes --against origin/next \
  --points "1 KiB,2304 B,3 KiB,3839 B,4470 B,7935 B,16 KiB,idle 3 KiB" --keep /home/agent/bench-hashes-validation/night-1110/kept-248 --when-quiet || echo "check exit $?"
echo "== speed: #276 against #248"
./target/release/bench-hashes check --fork /home/agent/BLAKE3-276 --new candidate/devon-pool-one-pause --against d3e907a8ef7b7064beb9b640e32d910a200d3439 \
  --points "continuous 64 B,continuous 1 KiB,continuous 16 KiB,64 B,1 MiB" --keep /home/agent/bench-hashes-validation/night-1110/kept-276 --when-quiet || echo "check exit $?"
