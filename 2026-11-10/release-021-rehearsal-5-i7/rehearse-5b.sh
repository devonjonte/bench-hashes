#!/bin/sh
# Rehearsal 5, the step it still owes: the library's release check, the pin against BLAKE3-Servil 0.8,
# every cell, with bench next 7c1645d4 (check --old-bench compares the contenders both benches know).
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp; unset RUSTFLAGS
O=/home/agent/bench-hashes-validation/release-021-i7/rehearsal-5; B=/home/agent/bench-0194; M=/home/agent/BLAKE3-m3
C=5663b129e2c0ac19897a8d4e148b32abe99bb9c5
cd $B; echo "== bench $(git log --oneline -1 | cut -c1-60); $(git status --short | wc -l) changed files; $(date -u +%H:%M)"
mv $O/check.stdout.txt $O/check-first-try.stdout.txt 2>/dev/null; mv $O/check.stderr.txt $O/check-first-try.stderr.txt 2>/dev/null
s=$(date +%s); ./target/release/bench-hashes check --fork $M --new $C --against b5b988d8 --old-bench 3363bee8 --cells all --when-quiet --keep $O/check > $O/check.stdout.txt 2> $O/check.stderr.txt; echo "== release check (the pin against BLAKE3-Servil 0.8) exit $? in $(( $(date +%s) - s )) s $(date -u +%H:%M)"
