#!/bin/sh
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp PAIRS=23
unset RUSTFLAGS
cd /home/agent/bench-hashes-validation/bench-mutants
python3 bench_mutants.py /home/agent/BLAKE3-mbase f448bb32aff6 /home/agent/bench-hashes-validation/bench-mutants/run2 "src/incremental.rs	replace Hasher::held_group -> Option<(u64, &[u8; STAGE_LEN])> with None"
