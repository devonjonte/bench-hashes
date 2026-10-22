#!/usr/bin/env bash
# Finish the fixed-source matrix. Each command owns one bounded job group.
# Launch in its own session; stopping its process group also signals the
# current supervisor, which kills its owned proof group. No measurements.
set -euo pipefail
cd /home/agent/BLAKE3-x86-counts
export PYTHONPATH=/home/agent/.local/z3py/usr/lib/python3/dist-packages
ulimit -v 6291456
root=/home/agent/bench-hashes-validation/x86-kernels-20261022
run() {
    test "$(git rev-parse HEAD)" = 14a716f35cbdf430fa845cc3dd9f5ee2c7b676cb
    test -z "$(git status --porcelain)"
    test ! -e "$root/$2.stdout.txt"
    printf '%s starting %s\n' "$(date -u +%FT%TZ)" "$2"
    python3 /home/agent/bench-hashes-validation/run-bounded.py "$1" "$root/$2" \
      python3 -u "$root/run-count-proofs.py" "$3" > "$root/$2-supervisor.txt" 2>&1
    printf '%s completed %s\n' "$(date -u +%FT%TZ)" "$2"
}
run 1800 counts-fixed-15-avx512 "[('avx512', False, 15, False), ('avx512', True, 15, False)]"
run 850 counts-fixed-16-light "[('sse41', False, 16, False), ('sse41', True, 16, False), ('avx2', False, 16, False), ('avx2', True, 16, False)]"
run 1800 counts-fixed-16-avx512 "[('avx512', False, 16, False), ('avx512', True, 16, False)]"
run 850 counts-increment-16-light "[('sse41', False, 16, True), ('sse41', True, 16, True), ('avx2', False, 16, True), ('avx2', True, 16, True)]"
run 1800 counts-increment-16-avx512 "[('avx512', False, 16, True), ('avx512', True, 16, True)]"
printf '%s all remaining matrix jobs completed\n' "$(date -u +%FT%TZ)"
