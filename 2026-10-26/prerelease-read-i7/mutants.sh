#!/bin/sh
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp
cd /home/agent/BLAKE3-prerel
python3 tools/mutants/check.py --since e7c5ef48
echo "== exit $?"
