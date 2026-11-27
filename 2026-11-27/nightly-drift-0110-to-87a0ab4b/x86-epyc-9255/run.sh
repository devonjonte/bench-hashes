#!/usr/bin/env bash
set -euo pipefail
export PATH="$HOME/.cargo/bin:$PATH"

WORK="$HOME/work"
BENCH="$WORK/bench-drift"
FORK="$WORK/lib-drift"
mkdir -p "$WORK"

if [ ! -d "$BENCH/.git" ]; then
  git clone https://github.com/servil-software-factory/bench-hashes.git "$BENCH"
fi
git -C "$BENCH" fetch --quiet origin 3f119a507807078649d8700112994fce24666868
git -C "$BENCH" checkout --quiet --force --detach 3f119a507807078649d8700112994fce24666868
git -C "$BENCH" clean -fdq
ACTUAL_BENCH="$(git -C "$BENCH" rev-parse HEAD)"
if [ "$ACTUAL_BENCH" != "3f119a507807078649d8700112994fce24666868" ]; then
  echo "nightly-drift: expected bench 3f119a507807078649d8700112994fce24666868, got $ACTUAL_BENCH" >&2
  exit 1
fi

if [ ! -d "$FORK/.git" ]; then
  git clone https://github.com/servil-software-factory/BLAKE3.git "$FORK"
fi
git -C "$FORK" fetch --quiet origin e1966b498bc769db3d51451a4ddc8188a19ed593 87a0ab4b9f3cebfa30a791993573bfb4b128ae4e
git -C "$FORK" checkout --quiet --force --detach 87a0ab4b9f3cebfa30a791993573bfb4b128ae4e
git -C "$FORK" clean -fdq
ACTUAL_TARGET="$(git -C "$FORK" rev-parse HEAD)"
if [ "$ACTUAL_TARGET" != "87a0ab4b9f3cebfa30a791993573bfb4b128ae4e" ]; then
  echo "nightly-drift: expected target 87a0ab4b9f3cebfa30a791993573bfb4b128ae4e, got $ACTUAL_TARGET" >&2
  exit 1
fi

echo "nightly-drift: host=$(hostname) bench=3f119a507807078649d8700112994fce24666868 base=e1966b498bc769db3d51451a4ddc8188a19ed593 target=87a0ab4b9f3cebfa30a791993573bfb4b128ae4e"

(cd "$BENCH" && cargo build --release --locked --quiet)
EXE="$BENCH/target/release/bench-hashes"
KEEP="$PWD/kept-drift"
rm -rf "$KEEP"

set +e
(cd "$BENCH" && "$EXE" check --fork "$FORK" --against e1966b498bc769db3d51451a4ddc8188a19ed593 --new 87a0ab4b9f3cebfa30a791993573bfb4b128ae4e --cells all --when-quiet --keep "$KEEP")
RC=$?
set -e

case "$RC" in
  0) VERDICT="no regression" ;;
  1) VERDICT="REGRESSION" ;;
  2) VERDICT="abstained (busy or unobserved load)" ;;
  *) VERDICT="stopped (exit $RC)" ;;
esac

if ls "$KEEP"/second/run-*-old.tsv >/dev/null 2>&1 && ls "$KEEP"/second/run-*-new.tsv >/dev/null 2>&1; then
  DECIDING_STAGE="stage 2 (kept-drift/second)"
  HAS_STAGE2=1
else
  DECIDING_STAGE="stage 1 (kept-drift)"
  HAS_STAGE2=0
fi

{
  echo "# Nightly drift check: e1966b498bc7 -> 87a0ab4b9f3c"
  echo ""
  echo "- Host: $(hostname)"
  echo "- Experiment: \`bench=3f119a507807078649d8700112994fce24666868|base=e1966b498bc769db3d51451a4ddc8188a19ed593|target=87a0ab4b9f3cebfa30a791993573bfb4b128ae4e|cells=all|layouts=default\`"
  echo "- bench-hashes: \`3f119a507807078649d8700112994fce24666868\`"
  echo "- BLAKE3-Servil base: \`e1966b498bc769db3d51451a4ddc8188a19ed593\`"
  echo "- BLAKE3-Servil target: \`87a0ab4b9f3cebfa30a791993573bfb4b128ae4e\`"
  echo "- Scope: \`--cells all\` (layouts: default)"
  echo "- Deciding stage: $DECIDING_STAGE"
  echo "- Verdict: **$VERDICT** (exit \`$RC\`)"
  echo ""
  if [ "$HAS_STAGE2" -eq 1 ]; then
    echo "## Stage 2 (deciding, kept-drift/second)"
    echo ""
    "$EXE" compare --markdown "$KEEP"/second/run-*-old.tsv -- "$KEEP"/second/run-*-new.tsv
    echo ""
    echo "## Stage 1 (initial screen, kept-drift)"
    echo ""
  fi
  if ls "$KEEP"/run-*-old.tsv >/dev/null 2>&1 && ls "$KEEP"/run-*-new.tsv >/dev/null 2>&1; then
    "$EXE" compare --markdown "$KEEP"/run-*-old.tsv -- "$KEEP"/run-*-new.tsv
  fi
} > summary.md

echo "nightly-drift: stage=$DECIDING_STAGE verdict=$VERDICT (exit $RC)"
exit "$RC"
