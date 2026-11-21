#!/bin/sh
# One machine's 0.24 release run (bench-hashes CONTRIBUTING, "Releases", step 4).
# Template: replace @@V@@ (bench-hashes 0.24.0 commit) and @@NEW@@ (BLAKE3-Servil 0.10.0 commit).
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
V=@@V@@
NEW=@@NEW@@
OLDLIB=2c60420c2bccbf6073e35e668691d98520f9b096
OLDBENCH=cade30fdb71682719f5fa3e586ff96146ae9fc25
SHORT=$(printf %s "$V" | cut -c1-8)
O="$HOME/runs/release-024-$SHORT"
export O V NEW OLDLIB OLDBENCH
if [ "${BOUNDED_RELEASE_024:-}" != yes ]; then
  export BOUNDED_RELEASE_024=yes
  status=0
  timeout --kill-after=30s 21600s sh "$O/run.sh" || status=$?
  printf 'RELEASE_024_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
  exit "$status"
fi
export CARGO_BUILD_JOBS=8 CARGO_INCREMENTAL=0 LAYOUTS=4
unset CARGO_TARGET_DIR RUSTFLAGS CARGO_ENCODED_RUSTFLAGS
B="$HOME/work/bench-release-024-$SHORT"
M="$HOME/work/lib-release-024-$SHORT"
export B M
rm -rf "$B" "$M"
git clone --filter=blob:none --no-checkout https://github.com/servil-software-factory/bench-hashes "$B"
git -C "$B" fetch origin '+refs/heads/*:refs/remotes/origin/*' '+refs/tags/*:refs/tags/*'
git -C "$B" checkout --detach "$V"
git clone --filter=blob:none --no-checkout https://github.com/servil-software-factory/BLAKE3 "$M"
git -C "$M" fetch origin '+refs/heads/*:refs/remotes/origin/*' '+refs/tags/*:refs/tags/*'
git -C "$M" checkout --detach "$NEW"
test -z "$(git -C "$B" status --porcelain)"
test -z "$(git -C "$M" status --porcelain)"
cd "$B"
{ uname -srm; rustc -Vv; cc --version; cat /proc/sys/kernel/perf_event_paranoid; printf 'bench %s\nnew %s\nold-lib %s\nold-bench %s\n' "$V" "$NEW" "$OLDLIB" "$OLDBENCH"; } > "$O/toolchain.txt"
cargo build --release --locked > "$O/build.txt" 2>&1
cargo nextest run --release --locked -j 8 -P machine > "$O/machine-profile.txt" 2>&1
# The full run, built against the 0.10.0 checkout, from a scratch directory.
EXE=$(./target/release/bench-hashes build-against "$M" | tail -n 1)
RUNS="$HOME/work/release-024-scratch-$SHORT"
rm -rf "$RUNS"
mkdir "$RUNS"
cd "$RUNS"
"$EXE" --all --expect-servil "$NEW" > "$O/full-run.stdout.txt" 2> "$O/full-run.stderr.txt"
# b3sum, the contenders built as their projects recommend, files on this storage.
cd "$B"
python3 tools/b3sum-contenders.py "$M" "$HOME/b3sum-contenders-024-$SHORT" > "$O/b3sum-contenders.txt" 2> "$O/b3sum-contenders.log"
cd "$RUNS"
tr '\n' '\0' < "$O/b3sum-contenders.txt" | xargs -0 "$EXE" b3sum --files "$HOME/b3sum-bench-files" > "$O/b3sum.stdout.txt" 2> "$O/b3sum.stderr.txt"
# The crowd: one program a CPU.
"$EXE" crowd > "$O/crowd.stdout.txt" 2> "$O/crowd.stderr.txt"
cp -r "$RUNS/benchmark-results" "$O/benchmark-results"
printf 'RECORDS DONE %s\n' "$(date -u +%FT%TZ)"
# After the records: the release comparison against 0.9.1, and the control (one library, two benches).
cd "$B"
./target/release/bench-hashes check --fork "$M" --new "$NEW" --against "$OLDLIB" \
    --cells all --when-quiet --keep "$O/kept-release" \
    > "$O/release-check.stdout.txt" 2> "$O/release-check.stderr.txt" || printf 'release-check exit %s\n' "$?" >> "$O/verdicts.txt"
./target/release/bench-hashes check --fork "$M" --new "$NEW" --against "$NEW" \
    --old-bench "$OLDBENCH" --cells all --when-quiet --keep "$O/kept-control" \
    > "$O/control-check.stdout.txt" 2> "$O/control-check.stderr.txt" || printf 'control-check exit %s\n' "$?" >> "$O/verdicts.txt"
printf 'DONE %s\n' "$(date -u +%FT%TZ)"
