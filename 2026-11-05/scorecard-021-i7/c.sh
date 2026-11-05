#!/bin/sh
# Scorecard (c): servil's tip against 0.8 on the overview's six cells, 8 pairs of fresh builds through regress.
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp; unset RUSTFLAGS
O=/home/agent/bench-hashes-validation/scorecard-021-i7
B=/home/agent/bench-0194
cd $B; s=$(date +%s)
OLD=$(cargo run -q --release -- build-against /home/agent/BLAKE3-rel019) || exit 1
cd /home/agent/BLAKE3-m3 && git checkout -q 06f6e26d 2>/dev/null; cd $B
NEW=$(cargo run -q --release -- build-against /home/agent/BLAKE3-m3) || exit 1
echo "old $OLD"; echo "new $NEW"
cd $O
$NEW regress --contenders blake3-servil-st,blake3-servil-mt --points "64 B,1 KiB,1 MiB,128 MiB,continuous 64 KiB,1024" --pairs 8 --keep $O/c-runs $OLD -- $NEW > $O/c.stdout.txt 2> $O/c.stderr.txt
echo "== c exit $? in $(( $(date +%s) - s )) s $(date -u +%H:%M)"
cd /home/agent/BLAKE3-m3 && git checkout -q candidate/devon-pool-order; cd $B && git checkout -q -- Cargo.lock
