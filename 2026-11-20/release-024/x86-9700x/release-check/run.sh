#!/bin/sh
# 0.24's release comparison against 0.9.1, again: bench-hashes 0.24 does not build against 0.9.1 (which has no
# throughput::Pipeline), so the old side takes the bench that does, 0.22 (check --old-bench), as CONTRIBUTING's
# release step says for a library whose API changed. Uses the clones the release run left.
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
if [ "${BOUNDED_RC_024:-}" != yes ]; then
  export BOUNDED_RC_024=yes
  status=0
  timeout --kill-after=30s 9000s sh "$O/run.sh" || status=$?
  printf 'RELEASE_CHECK_024_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
  exit "$status"
fi
export CARGO_BUILD_JOBS=8 CARGO_INCREMENTAL=0 LAYOUTS=4
unset CARGO_TARGET_DIR RUSTFLAGS CARGO_ENCODED_RUSTFLAGS
V=3f3ef25130feadb67da742924dd6cfdc4c7886fb
NEW=2fd4ff6f643ef04f98f7a2e5f8ca0f096298827a
OLDLIB=2c60420c2bccbf6073e35e668691d98520f9b096
OLDBENCH=97c0fbcbedb8fe8f8395115647684dfde75d67a3
B="$HOME/work/bench-release-024-3f3ef251"
M="$HOME/work/lib-release-024-3f3ef251"
test "$(git -C "$B" rev-parse HEAD)" = "$V"
cd "$B"
status=0
./target/release/bench-hashes check --fork "$M" --new "$NEW" --against "$OLDLIB" --old-bench "$OLDBENCH" \
    --cells all --when-quiet --keep "$O/kept-release" \
    > "$O/release-check.stdout.txt" 2> "$O/release-check.stderr.txt" || status=$?
printf 'release-check exit %s\n' "$status" > "$O/exit.txt"
printf 'DONE %s\n' "$(date -u +%FT%TZ)"
