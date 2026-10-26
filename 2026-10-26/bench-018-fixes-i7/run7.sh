#!/bin/sh
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp
unset RUSTFLAGS
cd /home/agent/bench-hashes-validation/bench-mutants
TESTS_TSV=/home/agent/BLAKE3-widerows/tmp/mutants-last/run/tests.tsv python3 - <<'PY'
import subprocess
names=[l.rstrip('\n') for l in open('names7.txt') if l.strip()]
subprocess.run(['python3','bench_mutants.py','/home/agent/BLAKE3-mbase','8c34ead4','/home/agent/bench-hashes-validation/bench-mutants/run7',*names])
PY
