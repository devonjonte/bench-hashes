#!/bin/sh
# BLAKE3-Servil 0.11.0 (b9aefc11) full records run on an x86-64 timing host
# using bench-hashes 303fff16 (matching M6 rel011v2 runs in bench-hashes #281).
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
V=303fff16dfcd7a7de6d5d3c3595285359ba32d84
NEW=b9aefc11e1e422edf483f9b68cec57aaf04de560
O="$HOME/runs/release-0110-b9aefc11"
export O V NEW
if [ "${BOUNDED_RELEASE_0110:-}" != yes ]; then
  export BOUNDED_RELEASE_0110=yes
  status=0
  timeout --kill-after=30s 10800s sh "$O/run.sh" || status=$?
  printf 'RELEASE_0110_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
  exit "$status"
fi
export CARGO_BUILD_JOBS=8 CARGO_INCREMENTAL=0 LAYOUTS=4
unset CARGO_TARGET_DIR RUSTFLAGS CARGO_ENCODED_RUSTFLAGS
B="$HOME/work/bench-rel0110"
M="$HOME/work/lib-rel0110"
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
{ uname -srm; rustc -Vv; cc --version; cat /proc/sys/kernel/perf_event_paranoid; printf 'bench %s\nnew %s\n' "$V" "$NEW"; } > "$O/toolchain.txt"
cargo build --release --locked > "$O/build.txt" 2>&1
EXE=$(./target/release/bench-hashes build-against "$M" | tail -n 1)
RUNS="$HOME/work/rel0110-scratch"
rm -rf "$RUNS"
mkdir "$RUNS"
cd "$RUNS"
"$EXE" --all --expect-servil "$NEW" > "$O/full-run.stdout.txt" 2> "$O/full-run.stderr.txt"
cd "$B"
python3 tools/b3sum-contenders.py "$M" "$HOME/b3sum-contenders-0110" "$NEW" > "$O/b3sum-contenders.txt" 2> "$O/b3sum-contenders.log"
cd "$RUNS"
tr '\n' '\0' < "$O/b3sum-contenders.txt" | xargs -0 "$EXE" b3sum --files "$HOME/b3sum-bench-files" > "$O/b3sum.stdout.txt" 2> "$O/b3sum.stderr.txt"
"$EXE" crowd > "$O/crowd.stdout.txt" 2> "$O/crowd.stderr.txt"
cp -r "$RUNS/benchmark-results" "$O/benchmark-results"
rm -rf "$RUNS"
printf 'RECORDS DONE %s\n' "$(date -u +%FT%TZ)"
