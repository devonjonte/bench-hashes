#!/bin/sh
# bench-hashes 0.19.3 (a48ee6c7) release runs on the i7-12700K, the fork at 0.8 (b5b988d8):
# the full run, the b3sum run, the same-library check (CONTRIBUTING, Releases, step 4).
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp; unset RUSTFLAGS
O=/home/agent/bench-hashes-validation/release-0193-i7
F=/home/agent/BLAKE3-rel019
C=b5b988d8982bea9490c38c79ec4b8c5c2428270c
cd /home/agent/bench-0193
echo "== governor: $(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor) epp: $(cat /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_preference 2>/dev/null) $(date -u +%H:%M)"
EXE=$(cargo run -q --release -- build-against $F 2> $O/build-against.stderr.txt | tail -1); echo "built: $EXE"
git checkout -q -- Cargo.lock 2>/dev/null
rm -rf $O/full; mkdir -p $O/full; cd $O/full
s=$(date +%s); $EXE --all --expect-servil $C > report.txt 2> stderr.txt; echo "== full exit $? in $(( $(date +%s) - s )) s"
cd /home/agent/bench-0193
s=$(date +%s); LAYOUTS=4 python3 tools/b3sum-contenders.py $F /home/agent/b3c-rel019 > $O/b3sum-contenders.txt 2> $O/b3sum-contenders.stderr.txt; echo "== contenders exit $? in $(( $(date +%s) - s )) s"
rm -rf $O/b3sum; mkdir -p $O/b3sum
s=$(date +%s); tr '\n' '\0' < $O/b3sum-contenders.txt | (cd $O/b3sum && xargs -0 /home/agent/bench-0193/target/release/bench-hashes b3sum --files /home/agent/bench-hashes-validation/b3sum-linux/files > report.txt 2> stderr.txt); echo "== b3sum exit $? in $(( $(date +%s) - s )) s"
s=$(date +%s); cargo run -q --release -- check --fork $F --against $C --old-bench 1f4dfd63 --cells all --keep $O/check-same > $O/check-same.stdout.txt 2> $O/check-same.stderr.txt; echo "== same-library check exit $? in $(( $(date +%s) - s )) s"
