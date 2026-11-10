#!/bin/sh
# BLAKE3 #342, item 2: the mutants of two x86 files on no list, on the i7 (AVX2, no AVX-512), in a checkout of next.
set -u
export PATH=/home/agent/.cargo/bin:$PATH TMPDIR=/home/agent/tmp
cd /home/agent/BLAKE3-devver
python3 /home/agent/bench-hashes-validation/sam-342/unlisted-run.py . 6 /home/agent/bench-hashes-validation/sam-342/i7-unlisted.json src/ffi_chunk_root.rs src/ffi_avx512_32.rs
echo "exit $?"
