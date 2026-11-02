#!/bin/sh
# Does the bench's pre-call work hide part of the after-pause wake cost? (#106)
# Two benches (0.19.7) against the fork at 0.8: A = clocks as on servil (ac9e6b7d-era, the pin), B = clocks with the reads after the call (5a32cddc).
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp; unset RUSTFLAGS
O=/home/agent/bench-hashes-validation/readafter-i7
F=/home/agent/BLAKE3-rel019
cd /home/agent/bench-0194 && git checkout -q --detach john/main
A=$(cargo run -q --release -- build-against $F 2>/dev/null | tail -1); cp "$A" $O/bench-A; echo "A: $A"
git checkout -q -- Cargo.lock 2>/dev/null
# B: the same bench with clocks patched to the experiment's checkout.
rm -rf /home/agent/bench-readafter && git worktree add -q --detach /home/agent/bench-readafter john/main
cd /home/agent/bench-readafter
printf '\n[patch."https://github.com/johnservil/BLAKE3"]\nclocks = { path = "/home/agent/BLAKE3-readafter/clocks" }\n' >> Cargo.toml
export BENCH_CLOCKS_CHECKOUT=/home/agent/BLAKE3-readafter/clocks
B=$(cargo run -q --release -- build-against $F 2>/dev/null | tail -1); cp "$B" $O/bench-B; echo "B: $B"
unset BENCH_CLOCKS_CHECKOUT
cd /home/agent/bench-0194
P="idle 64 B,idle 1 KiB,idle 3839 B,idle 16 KiB,idle 1 MiB,idle 2,idle 16,idle 48,idle 1024,64 B,1 KiB,16 KiB,2,16,1024"
OLD=""; NEW=""; for i in 1 2 3 4 5 6 7 8; do OLD="$OLD $O/bench-A"; NEW="$NEW $O/bench-B"; done
s=$(date +%s); $O/bench-A regress --pairs 8 --contenders blake3-servil-st,blake3-servil-mt --points "$P" --keep $O/regress $OLD -- $NEW > $O/regress.stdout.txt 2> $O/regress.stderr.txt; echo "regress exit $? in $(( $(date +%s) - s )) s"
