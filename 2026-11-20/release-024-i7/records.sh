#!/bin/sh
# bench-hashes 0.24.0's release run on the i7-12700K at the tag (version commit 3f3ef251),
# BLAKE3-Servil 0.10.0 (2fd4ff6f): machine tests, the full run, b3sum, crowd.
# Zooko asked for this run on November 20, 2026, for this release.
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp CARGO_BUILD_JOBS=6 CARGO_INCREMENTAL=0; unset RUSTFLAGS CARGO_TARGET_DIR CARGO_ENCODED_RUSTFLAGS
O=/home/agent/bench-hashes-validation/release-024/i7
B=/home/agent/bench-024tag; F=/home/agent/BLAKE3-0100
V=3f3ef25130feadb67da742924dd6cfdc4c7886fb
C=2fd4ff6f643ef04f98f7a2e5f8ca0f096298827a
test "$(git -C $B rev-parse HEAD)" = $V || exit 1
test "$(git -C $F rev-parse HEAD)" = $C || exit 1
test -z "$(git -C $B status --porcelain)" || exit 1
test -z "$(git -C $F status --porcelain)" || exit 1
cd $B
{ uname -srm; rustc -Vv; cc --version; cat /proc/sys/kernel/perf_event_paranoid; printf 'bench %s\nlibrary %s\ngovernor %s\n' $V $C "$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)"; } > $O/toolchain.txt
echo "== start $(date -u +%H:%M)"
s=$(date +%s); cargo nextest run --release --locked -j 6 -P machine > $O/machine-profile.txt 2>&1; echo "== machine tests exit $? in $(( $(date +%s) - s )) s"
EXE=$(./target/release/bench-hashes build-against $F 2> $O/build-against.stderr.txt | tail -n 1); echo "built: $EXE"
test -z "$(git -C $B status --porcelain)" || { git -C $B status --short; git -C $B checkout -q -- Cargo.lock; }
s=$(date +%s); LAYOUTS=4 python3 tools/b3sum-contenders.py $F /home/agent/b3c-090 > $O/b3sum-contenders.txt 2> $O/b3sum-contenders.stderr.txt; echo "== contenders exit $? in $(( $(date +%s) - s )) s"
rm -rf $O/scratch; mkdir -p $O/scratch; cd $O/scratch
$B/target/release/bench-hashes quiet --wait > /dev/null 2>&1
s=$(date +%s); "$EXE" --all --expect-servil $C > $O/full-run.stdout.txt 2> $O/full-run.stderr.txt; echo "== full exit $? in $(( $(date +%s) - s )) s $(date -u +%H:%M)"
$B/target/release/bench-hashes quiet --wait > /dev/null 2>&1
s=$(date +%s); tr '\n' '\0' < $O/b3sum-contenders.txt | xargs -0 "$EXE" b3sum --files /home/agent/b3sum-files > $O/b3sum.stdout.txt 2> $O/b3sum.stderr.txt; echo "== b3sum exit $? in $(( $(date +%s) - s )) s $(date -u +%H:%M)"
$B/target/release/bench-hashes quiet --wait > /dev/null 2>&1
s=$(date +%s); "$EXE" crowd > $O/crowd.stdout.txt 2> $O/crowd.stderr.txt; echo "== crowd exit $? in $(( $(date +%s) - s )) s $(date -u +%H:%M)"
ls $O/scratch/benchmark-results/*/ | tr '\n' ' '; echo
echo "== records done $(date -u +%H:%M)"
