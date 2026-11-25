#!/bin/sh
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
export CARGO_BUILD_JOBS=8 CARGO_INCREMENTAL=0
unset CARGO_TARGET_DIR RUSTFLAGS CARGO_ENCODED_RUSTFLAGS
B="$HOME/work/bench-rel0110"
M="$HOME/work/lib-rel0110"
O="$HOME/runs/final-9700x-556"
mkdir -p "$O"
git -C "$M" fetch origin next
git -C "$M" fetch https://github.com/devonjonte/BLAKE3.git candidate/devon-issue556-pipeline:refs/heads/final556
CAND=$(git -C "$M" rev-parse final556)
NEXT=$(git -C "$M" rev-parse origin/next)
echo "CAND=$CAND NEXT=$NEXT"
cd "$B"
for pair in "$NEXT:$CAND:next-to-final" "2fd4ff6f:$CAND:010-to-final"; do
  old=$(echo "$pair" | cut -d: -f1)
  new=$(echo "$pair" | cut -d: -f2)
  tag=$(echo "$pair" | cut -d: -f3)
  echo "=== $tag ($old -> $new, 8 pairs) ==="
  ./target/release/bench-hashes check \
    --fork "$M" --against "$old" --new "$new" \
    --points "continuous 64 B,continuous 4 KiB,continuous batch 1024,continuous batch 16384,continuous batch 65536" \
    --contenders blake3-servil-mt --layouts 8 \
    --keep "$O/keep-$tag" --when-quiet > "$O/$tag.txt" 2>&1 || true
  OLDS=$(ls "$O/keep-$tag"/run-*-old.tsv | head -n 8)
  NEWS=$(ls "$O/keep-$tag"/run-*-new.tsv | head -n 8)
  ./target/release/bench-hashes compare $OLDS -- $NEWS || true
done
echo "DONE $(date -u +%FT%TZ)"
