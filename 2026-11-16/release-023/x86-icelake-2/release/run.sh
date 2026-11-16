#!/bin/sh
# One machine's 0.23 release run (bench-hashes CONTRIBUTING, "Releases", step 4).
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O="$HOME/runs/release-023-cade30fd"
export O
if [ "${BOUNDED_RELEASE_023:-}" != yes ]; then
  export BOUNDED_RELEASE_023=yes
  status=0
  timeout --kill-after=30s 21600s sh "$O/run.sh" || status=$?
  printf 'RELEASE_023_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
  exit "$status"
fi
export CARGO_BUILD_JOBS=8 CARGO_INCREMENTAL=0 LAYOUTS=4
unset CARGO_TARGET_DIR RUSTFLAGS CARGO_ENCODED_RUSTFLAGS
V=cade30fdb71682719f5fa3e586ff96146ae9fc25
NEW=7048303103c69b8609ffe9ca0361197ba318107c
OLDLIB=bf2da8b957f5e0c80babb57952de3e53f95c921a
OLDBENCH=d7723f110a6f519cccb2e4ab8f2a18be7a4f4d41
B="$HOME/work/bench-release-023"
M="$HOME/work/lib-release-023"
export V NEW OLDLIB OLDBENCH B M
git clone --filter=blob:none --no-checkout https://github.com/servil-software-factory/bench-hashes "$B"
git -C "$B" checkout --detach "$V"
git clone --filter=blob:none --no-checkout https://github.com/servil-software-factory/BLAKE3 "$M"
git -C "$M" checkout --detach "$NEW"
test -z "$(git -C "$B" status --porcelain)"
test -z "$(git -C "$M" status --porcelain)"
cd "$B"
{ uname -srm; rustc -Vv; cc --version; cat /proc/sys/kernel/perf_event_paranoid; printf 'bench %s\nnew %s\nold-lib %s\nold-bench %s\n' "$V" "$NEW" "$OLDLIB" "$OLDBENCH"; } > "$O/toolchain.txt"
cargo build --release --locked > "$O/build.txt" 2>&1
cargo nextest run --release --locked -j 8 -P machine > "$O/machine-profile.txt" 2>&1
# The release comparison: the previous release's library under its own bench.
./target/release/bench-hashes check --fork "$M" --new "$NEW" --against "$OLDLIB" \
    --old-bench "$OLDBENCH" --cells all --when-quiet --keep "$O/kept-release" \
    > "$O/release-check.stdout.txt" 2> "$O/release-check.stderr.txt" || printf 'release-check exit %s\n' "$?" >> "$O/verdicts.txt"
# The control beside it: one library, two benches.
./target/release/bench-hashes check --fork "$M" --new "$NEW" --against "$NEW" \
    --old-bench "$OLDBENCH" --cells all --when-quiet --keep "$O/kept-control" \
    > "$O/control-check.stdout.txt" 2> "$O/control-check.stderr.txt" || printf 'control-check exit %s\n' "$?" >> "$O/verdicts.txt"
# The full run, built against the checkout, from a scratch directory.
EXE=$(./target/release/bench-hashes build-against "$M" | tail -n 1)
RUNS="$HOME/work/release-023-scratch"
mkdir "$RUNS"
cd "$RUNS"
"$EXE" --all --expect-servil "$NEW" > "$O/full-run.stdout.txt" 2> "$O/full-run.stderr.txt"
# b3sum, the contenders built as their projects recommend, files on this storage.
cd "$B"
python3 tools/b3sum-contenders.py "$M" "$HOME/b3sum-contenders-023" > "$O/b3sum-contenders.txt" 2> "$O/b3sum-contenders.log"
cd "$RUNS"
tr '\n' '\0' < "$O/b3sum-contenders.txt" | xargs -0 "$EXE" b3sum --files "$HOME/b3sum-bench-files" > "$O/b3sum.stdout.txt" 2> "$O/b3sum.stderr.txt"
# The crowd: one program a CPU.
"$EXE" crowd > "$O/crowd.stdout.txt" 2> "$O/crowd.stderr.txt"
cp -r "$RUNS/benchmark-results" "$O/benchmark-results"
printf 'DONE %s\n' "$(date -u +%FT%TZ)"
