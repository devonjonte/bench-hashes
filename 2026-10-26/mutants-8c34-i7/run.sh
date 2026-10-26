#!/bin/sh
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp
cd /home/agent/BLAKE3-widerows
echo "== $(git rev-parse HEAD) $(date -u +%H:%M)"
python3 tools/mutants/check.py
echo "== exit $? $(date -u +%H:%M)"
