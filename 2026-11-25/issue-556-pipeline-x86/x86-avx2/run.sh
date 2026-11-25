#!/bin/sh
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
export CARGO_BUILD_JOBS=8 CARGO_INCREMENTAL=0
unset CARGO_TARGET_DIR RUSTFLAGS CARGO_ENCODED_RUSTFLAGS
B="$HOME/work/bench-rel0110"
M="$HOME/work/lib-rel0110"
O="$HOME/runs/final-avx2-556"
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
  echo "=== $tag ($old -> $new, 16 pairs continuous 64 B) ==="
  ./target/release/bench-hashes check \
    --fork "$M" --against "$old" --new "$new" \
    --points "continuous 64 B" \
    --contenders blake3-servil-mt --layouts 16 \
    --keep "$O/keep-$tag-64b" --when-quiet > "$O/$tag-64b.txt" 2>&1 || true
  OLDS=$(ls "$O/keep-$tag-64b"/run-*-old.tsv | head -n 16)
  NEWS=$(ls "$O/keep-$tag-64b"/run-*-new.tsv | head -n 16)
  ./target/release/bench-hashes compare $OLDS -- $NEWS || true
  echo "=== $tag ($old -> $new, probe 4 KiB + batches) ==="
  ./target/release/bench-hashes check \
    --fork "$M" --against "$old" --new "$new" \
    --probe "continuous 4 KiB,continuous batch 1024,continuous batch 16384,continuous batch 65536" \
    --contenders blake3-servil-mt --when-quiet > "$O/$tag-rest.txt" 2>&1 || true
  grep -E "Continuous|SLOWER|faster|suspects|level|CPU time" "$O/$tag-rest.txt" | head -n 30 || true
done
echo "DONE $(date -u +%FT%TZ)"
