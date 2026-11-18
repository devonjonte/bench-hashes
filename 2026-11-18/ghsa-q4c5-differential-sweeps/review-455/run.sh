#!/bin/sh
# Declared before running (November 18, 2026, UTC): correctness & soundness checks on daef4ba8 (#455 review):
# locked suites (core, threads, b3sum, test_vectors, doctests), tools/check-builds.sh, Shuttle pipeline model,
# tools/pipeline_model_controls.py, and length_sweep (all 4 parts) on probe/devon-sweep-daef4ba8.
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
if [ "${BOUNDED_455:-}" != yes ]; then
  export BOUNDED_455=yes
  status=0
  timeout --kill-after=30s 5400s sh "$0" || status=$?
  printf 'R455_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
  exit "$status"
fi
export CARGO_BUILD_JOBS=32 CARGO_INCREMENTAL=0
unset CARGO_TARGET_DIR RUSTFLAGS CARGO_ENCODED_RUSTFLAGS
W="$HOME/work/lib-review-455"
C=daef4ba899bc936531e78ce533ed91f1859bfe37
S=c8e8864b5f4d164fb18db74b134b884b52d4266a
[ -d "$W" ] || git clone -q https://github.com/servil-software-factory/BLAKE3 "$W"
git -C "$W" fetch -q origin "$C" "$S"
git -C "$W" checkout -q --force --detach "$C"
git -C "$W" clean -fdq
cd "$W"
echo "=== core nextest ==="
cargo nextest run --release --lib --tests > "$O/core-tests.txt" 2>&1
tail -3 "$O/core-tests.txt"
echo "=== core doc ==="
cargo test --release --doc > "$O/core-doc.txt" 2>&1
grep 'test result:' "$O/core-doc.txt" || true
echo "=== threads nextest ==="
(cd threads && cargo nextest run --release --lib --tests) > "$O/threads-tests.txt" 2>&1
tail -3 "$O/threads-tests.txt"
echo "=== threads doc ==="
(cd threads && cargo test --release --doc) > "$O/threads-doc.txt" 2>&1
grep 'test result:' "$O/threads-doc.txt" || true
echo "=== b3sum nextest ==="
(cd b3sum && cargo nextest run --release --tests) > "$O/b3sum-tests.txt" 2>&1
tail -3 "$O/b3sum-tests.txt"
echo "=== check-builds ==="
sh tools/check-builds.sh > "$O/check-builds.txt" 2>&1
tail -5 "$O/check-builds.txt"
echo "=== pipeline_model_controls ==="
python3 tools/pipeline_model_controls.py > "$O/pipeline-controls.txt" 2>&1
tail -12 "$O/pipeline-controls.txt"
echo "=== length_sweep on $S ==="
git -C "$W" checkout -q --force --detach "$S"
(cd threads && cargo nextest run --release --test length_sweep) > "$O/length-sweep.txt" 2>&1
tail -20 "$O/length-sweep.txt"
git -C "$W" checkout -q --force --detach "$C"
git -C "$W" clean -fdq
