#!/bin/sh
# #113 mechanism: bench-A (as is) against one bench-C built with clocks bc516cf5, run under PRECALL=none|perf|clock|spin; servil st, after-other-work small cells, 6 pairs each.
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp; unset RUSTFLAGS
O=/home/agent/bench-hashes-validation/readafter-i7
cd /home/agent/bench-readafter && sed -i 's|/home/agent/BLAKE3-readafter/clocks|/home/agent/BLAKE3-readafter/clocks|' Cargo.toml
export BENCH_CLOCKS_CHECKOUT=/home/agent/BLAKE3-readafter/clocks
C=$(cargo run -q --release -- build-against /home/agent/BLAKE3-rel019 2>/dev/null | tail -1); cp "$C" $O/bench-C; echo "C: $C"
unset BENCH_CLOCKS_CHECKOUT
P="64 B,1 KiB,16 KiB,2,16"
OLD=""; NEW=""; for i in 1 2 3 4 5 6; do OLD="$OLD $O/bench-A"; NEW="$NEW $O/bench-C"; done
for v in none perf clock spin; do
  s=$(date +%s); PRECALL=$v $O/bench-A regress --pairs 6 --contenders blake3-servil-st --points "$P" --keep $O/regress3-$v $OLD -- $NEW > $O/regress3-$v.stdout.txt 2> $O/regress3-$v.stderr.txt; echo "$v exit $? in $(( $(date +%s) - s )) s"
done
