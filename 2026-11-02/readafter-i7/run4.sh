#!/bin/sh
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp; unset RUSTFLAGS
O=/home/agent/bench-hashes-validation/readafter-i7
cd /home/agent/bench-readafter; export BENCH_CLOCKS_CHECKOUT=/home/agent/BLAKE3-readafter/clocks
C=$(cargo run -q --release -- build-against /home/agent/BLAKE3-rel019 2>/dev/null | tail -1); cp "$C" $O/bench-D; echo "D: $C"
OLD=""; NEW=""; for i in 1 2 3 4 5 6; do OLD="$OLD $O/bench-A"; NEW="$NEW $O/bench-D"; done
s=$(date +%s); PRECALL=warm $O/bench-A regress --pairs 6 --contenders blake3-servil-st --points "64 B,1 KiB,16 KiB,2,16" --keep $O/regress4-warm $OLD -- $NEW > $O/regress4-warm.stdout.txt 2> $O/regress4-warm.stderr.txt; echo "warm exit $? in $(( $(date +%s) - s )) s"
