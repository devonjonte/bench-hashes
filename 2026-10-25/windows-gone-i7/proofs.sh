#!/bin/sh
set -eu
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp PYTHONPATH=/home/agent/pylib
cd /home/agent/BLAKE3-rel08
ulimit -v 6291456
echo "== commit $(git rev-parse HEAD)"
echo "== prove_x86.py --workers 2 (full matrix) $(date -u +%H:%M)"
python3 tools/verify/prove_x86.py --workers 2 > /home/agent/bench-hashes-validation/windows-gone/full.stdout.txt
tail -1 /home/agent/bench-hashes-validation/windows-gone/full.stdout.txt
echo "== prove_x86_loop.py --workers 2 $(date -u +%H:%M)"
python3 tools/verify/prove_x86_loop.py --workers 2 > /home/agent/bench-hashes-validation/windows-gone/loop.stdout.txt
tail -1 /home/agent/bench-hashes-validation/windows-gone/loop.stdout.txt
echo "== cross_check_x86.py $(date -u +%H:%M)"
python3 tools/verify/cross_check_x86.py > /home/agent/bench-hashes-validation/windows-gone/cross.stdout.txt
tail -2 /home/agent/bench-hashes-validation/windows-gone/cross.stdout.txt
echo "== done $(date -u +%H:%M)"
