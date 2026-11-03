#!/bin/sh
# The whole mutation check on x86-64 at candidate/devon-mutants-arrangement (four families stacked), writing the list.
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp; unset RUSTFLAGS
cd /home/agent/BLAKE3-m3
s=$(date +%s); python3 tools/mutants/check.py --write > /home/agent/bench-hashes-validation/mutants-lanes/check4.stdout.txt 2> /home/agent/bench-hashes-validation/mutants-lanes/check4.stderr.txt; echo "== check --write exit $? in $(( $(date +%s) - s )) s"
