#!/bin/sh
# The whole mutation check on x86-64 at candidate/devon-mutants-lanes-cuts, writing the list: which of lanes.rs's speed mutants the exact-cut tests now catch.
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp; unset RUSTFLAGS
cd /home/agent/BLAKE3-head
s=$(date +%s); python3 tools/mutants/check.py --write > /home/agent/bench-hashes-validation/mutants-lanes/check.stdout.txt 2> /home/agent/bench-hashes-validation/mutants-lanes/check.stderr.txt; echo "== check --write exit $? in $(( $(date +%s) - s )) s"
