#!/bin/sh
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp
unset RUSTFLAGS
cd /home/agent/BLAKE3-benchtool
python3 tools/mutants/bench.py --re '^replace Pool::wake_for with \(\)$|^delete match arm 3 in hash_four_at_a_time$'
echo "== exit $?"
