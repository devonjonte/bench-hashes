#!/bin/sh
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp
unset RUSTFLAGS
cd /home/agent/bench-hashes-validation/bench-mutants
python3 - <<'PY'
import subprocess
names=[l.rstrip('\n') for l in open('names.txt') if l.strip()]
subprocess.run(['python3','bench_mutants.py','/home/agent/BLAKE3-mbase','f448bb32aff6','/home/agent/bench-hashes-validation/bench-mutants/run1',*names])
PY
