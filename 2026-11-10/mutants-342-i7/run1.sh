#!/bin/sh
# BLAKE3 #342, item 1: the composition's change-scoped mutation check on the i7, fresh and then with the worktrees kept.
set -u
export PATH=/home/agent/.cargo/bin:$PATH TMPDIR=/home/agent/tmp
cd /home/agent/BLAKE3-sam342
for round in fresh kept; do
  echo "== $round"
  python3 tools/mutants/check.py --since 0b5bf7b71cb5f850067fa4182d9a3c724d7e5710
  echo "exit $?"
done
