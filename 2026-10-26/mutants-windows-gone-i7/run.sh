#!/bin/sh
set -eu
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp
cd /home/agent/BLAKE3-rel08
echo "== $(git rev-parse HEAD) $(date -u +%H:%M)"
python3 tools/mutants/check.py
echo "== done $(date -u +%H:%M)"
