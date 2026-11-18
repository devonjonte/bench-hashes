#!/bin/sh
# Declared before running (November 18, 2026, UTC): bench-hashes with `check`'s layouts linked from one kept
# link a side a stage (candidate/devon-relink-kept-link, bfa51544) on a measurement host. Two questions:
# does its byte check pass here (check stops with "gave other bytes" if the kept link fails to reproduce
# Cargo's executable), and how long does a probe with 16 layouts a side take beside today's bench (0.23,
# cade30fd), whose every layout is a compile? Libraries: 4483281c against 27eacce3, one point (64 B).
# On aarch64 the old way is skipped (the VM is slow, and its question is the first).
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
if [ "${BOUNDED_RELINK:-}" != yes ]; then
  export BOUNDED_RELINK=yes
  status=0
  timeout --kill-after=30s 5400s sh "$0" || status=$?
  printf 'RELINK_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
  exit "$status"
fi
export CARGO_BUILD_JOBS=8 CARGO_INCREMENTAL=0
unset CARGO_TARGET_DIR RUSTFLAGS CARGO_ENCODED_RUSTFLAGS
R="$HOME/work/bench-release-023"
M="$HOME/work/lib-release-023"
NEW_BENCH=bfa51544906cdec548de06c3afcd005bf35f2baa
OLD_BENCH=cade30fdb71682719f5fa3e586ff96146ae9fc25
NEW=27eacce3a5c2e03043f4fcd347c178a80f9d911c
OLD=4483281c45eab341ca6f829de508e91d6c381e85
stamp() { printf '%s %s\n' "$(date -u +%T)" "$*" | tee -a "$O/progress.txt"; }
git -C "$R" cat-file -e "$NEW_BENCH^{commit}" 2> /dev/null || git -C "$R" fetch -q origin candidate/devon-relink-kept-link
git -C "$M" cat-file -e "$OLD^{commit}" 2> /dev/null || git -C "$M" fetch -q origin
git -C "$M" cat-file -e "$OLD^{commit}"; git -C "$M" cat-file -e "$NEW^{commit}"
run() { # name, bench commit
  B="$HOME/work/bench-relink-$1"
  [ -d "$B" ] || git -C "$R" worktree add -q --detach "$B" "$2"
  git -C "$B" checkout -q --detach "$2"
  stamp "$1: build the bench ($2)"
  (cd "$B" && cargo build --release --quiet) > "$O/$1.bench-build.txt" 2>&1
  stamp "$1: probe, 16 layouts a side: start"
  status=0
  (cd "$B" && ./target/release/bench-hashes check --fork "$M" --new "$NEW" --against "$OLD" --probe '64 B' --layouts 16 \
     --when-quiet --keep "$O/kept-$1") > "$O/$1.stdout.txt" 2> "$O/$1.stderr.txt" || status=$?
  stamp "$1: probe exit $status"
  echo "$1: probe exit $status" >> "$O/exit.txt"
  ls "$M/target/check/old" > "$O/$1.old-side.listing.txt" 2>&1 || true
}
[ "$(uname -m)" = aarch64 ] || run compiles "$OLD_BENCH"
run relinks "$NEW_BENCH"
{ uname -srm; rustc --version; cc --version | head -1; } > "$O/machine.txt" 2>&1
git -C "$R" worktree remove --force "$HOME/work/bench-relink-relinks" 2> /dev/null || true
git -C "$R" worktree remove --force "$HOME/work/bench-relink-compiles" 2> /dev/null || true
stamp "done"
