#!/bin/sh
# wake_probe: after a pause of 0 (steady), 20, 200, 1000 or 5000 us, one call of each size 64 KiB-4 MiB, mt and st; servil at f6f9db16 (0.8 + docs).
set -u
O=/home/agent/bench-hashes-validation/wake-i7
for p in 0 20 200 1000 5000; do /home/agent/BLAKE3-fair/target/release/examples/wake_probe $p 200 > $O/pause-$p.tsv; done
