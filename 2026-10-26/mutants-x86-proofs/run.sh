#!/bin/sh
set -eu
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp PYTHONPATH=/home/agent/pylib
ulimit -v 6291456
cd /home/agent/BLAKE3-oldbench
echo "== $(git rev-parse --short HEAD)"
python3 /home/agent/bench-hashes-validation/mutants-x86-proofs/run.py
