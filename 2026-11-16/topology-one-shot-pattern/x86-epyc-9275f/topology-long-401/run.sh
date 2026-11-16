#!/bin/sh
# BLAKE3 #401: what do calls after the 24th meet? One process per library commit taking
# many more samples of the 128 MiB one-shot on every core (a plain run, more rounds).
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O="$HOME/runs/topology-long-401"
if [ "${BOUNDED_LONG:-}" != yes ]; then
  export BOUNDED_LONG=yes
  status=0
  timeout --kill-after=30s 3600s sh "$O/run.sh" || status=$?
  printf 'LONG_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
  exit "$status"
fi
export CARGO_BUILD_JOBS=8 CARGO_INCREMENTAL=0
unset CARGO_TARGET_DIR RUSTFLAGS CARGO_ENCODED_RUSTFLAGS
B="$HOME/work/bench-release-023"
M="$HOME/work/lib-release-023"
test "$(git -C "$B" rev-parse HEAD)" = cade30fdb71682719f5fa3e586ff96146ae9fc25
W="$HOME/work/topology-long-401"
rm -rf "$W"; mkdir -p "$W"
for pair in new:3ec37f0e9d72ace57a3e094abbb5759c3f91395f old:6e498a963c5a8a2a7ddb01a86727317e277c32ec; do
  side=${pair%%:*}; rev=${pair#*:}
  git -C "$M" worktree add --detach "$W/lib-$side" "$rev" > "$O/worktree-$side.log" 2>&1
  cd "$B"
  ./target/release/bench-hashes build-against "$W/lib-$side" > "$O/build-$side.stdout.txt" 2> "$O/build-$side.stderr.txt"
  exe=$(tail -1 "$O/build-$side.stdout.txt")
  test -x "$exe"
  cp "$exe" "$W/bench-$side"
  for rounds in 960 96; do
    mkdir -p "$W/run-$side-$rounds"; cd "$W/run-$side-$rounds"
    status=0
    "$W/bench-$side" --contenders blake3-servil-mt --points '128 MiB' --rounds "$rounds" --for-regression-check --expect-servil "$rev" \
        > "$O/run-$side-$rounds.stdout.txt" 2> "$O/run-$side-$rounds.stderr.txt" || status=$?
    printf '%s rounds %s: exit %s\n' "$side" "$rounds" "$status" >> "$O/runs.txt"
    find . -name '*.samples.tsv' -exec cp {} "$O/run-$side-$rounds.samples.tsv" \;
  done
  git -C "$M" worktree remove --force "$W/lib-$side" >> "$O/worktree-$side.log" 2>&1 || true
done
rm -rf "$W"
printf 'DONE %s\n' "$(date -u +%FT%TZ)"
