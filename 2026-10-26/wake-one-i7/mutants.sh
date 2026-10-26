#!/bin/sh
set -eu
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp
cd /home/agent/BLAKE3-wakeone
python3 tools/mutants/check.py --since candidate/devon-list-check
