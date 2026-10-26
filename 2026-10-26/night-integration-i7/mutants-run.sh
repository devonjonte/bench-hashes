#!/bin/sh
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp
cd /home/agent/BLAKE3-night
echo "== mutation check $(git rev-parse HEAD) $(date -u +%H:%M)"
python3 tools/mutants/check.py
echo "== mutation check exit $? $(date -u +%H:%M)"
echo "== targets gate $(git -C /home/agent/BLAKE3-targets rev-parse --short HEAD) (uncommitted edits)"
sh /home/agent/bench-hashes-validation/targets/gate.sh > /home/agent/bench-hashes-validation/targets/gate.stdout.txt 2> /home/agent/bench-hashes-validation/targets/gate.stderr.txt
echo "== targets gate exit $? $(date -u +%H:%M)"
