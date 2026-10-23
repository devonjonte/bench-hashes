#!/bin/sh
# For each of the last N commits of servil that touch Rust: map the parent,
# then select against the child. Prints one line per commit.
set -e
export PATH=/home/agent/bin:$PATH TMPDIR=/home/agent/tmp
cd "$1"; N=$2
for c in $(git rev-list --no-merges -n "$N" HEAD -- src tests clocks c build.rs Cargo.toml); do
  p=$(git rev-parse "$c^")
  git checkout -q "$p" && cp /home/agent/BLAKE3-line/tools/tests/reach.py /tmp/select.py 2>/dev/null || true
  mkdir -p tools/tests && cp /home/agent/BLAKE3-line/tools/tests/reach.py tools/tests/reach.py
  python3 tools/tests/reach.py map > /dev/null 2>&1 || { echo "$c map-failed"; git checkout -q -- . ; continue; }
  git checkout -q "$c" && cp /home/agent/BLAKE3-line/tools/tests/reach.py tools/tests/reach.py
  out=$(python3 tools/tests/reach.py check --dry-run 2>&1 | grep -E 'tests,|every test runs' | tr '\n' ' ')
  echo "$c $(git log -1 --format=%s "$c" | cut -c1-50) :: $out"
  rm -f tools/tests/reach.py; rmdir tools/tests 2>/dev/null || true; git checkout -q -- .
done
