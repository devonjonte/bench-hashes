#!/bin/sh
# Ode's Adler-32 pilot: 4 old/new pairs and 4 same-code controls.
# Setup/builds finish before timing. Nothing compiles while samples run.
set -eu
export PATH=$HOME/.cargo/bin:$HOME/bin:$PATH
R=$HOME/runs/ode-adler-pilot
mkdir -p "$R/observations"
cd "$R"
base64 -d <<'PAYLOAD' | tar xzf - -C observations
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
PAYLOAD
command -v b3sum >/dev/null
C=409c7da2
B=5f99f456951ab36f7201decd8aa5e0249ec67bd1
git -C "$HOME/work/BLAKE3" fetch -q https://github.com/devonjonte/BLAKE3.git experiment/devon-ode-adler
full=$(git -C "$HOME/work/BLAKE3" rev-parse FETCH_HEAD)
test "${full#409c7da2}" != "$full"
git -C "$HOME/work/BLAKE3" worktree add -q --detach "$HOME/work/ode-adler-pilot" "$full"
git -C "$HOME/work/bench-hashes" fetch -q https://github.com/devonjonte/bench-hashes.git "$B"
git -C "$HOME/work/bench-hashes" worktree add -q --detach "$HOME/work/ode-clocks-pilot" "$B"
E=$HOME/work/ode-adler-pilot/tools/verify/machine/experiments/adler32
for side in old new; do
  python3 "$E/prepare_bench.py" "$HOME/work/ode-clocks-pilot" "$R/observations/$side" "$R/build-$side"
  for pad in 0 256 1024 2048; do
    ODE_PADDING=$pad timeout 180 cargo build --release --manifest-path "$R/build-$side/Cargo.toml" > "$R/build-$side-$pad.log" 2>&1
    cp "$R/build-$side/target/release/ode-adler-observer" "$R/runner-$side-$pad"
    "$R/runner-$side-$pad" --validate
  done
done
cpu=$(python3 -c 'import os; print(min(os.sched_getaffinity(0)))')
printf 'source %s
clocks %s
cpu %s
' "$full" "$B" "$cpu" > provenance.txt
uname -a >> provenance.txt
# Both questions' order alternates; each pair has a distinct explicit padding.
i=0
for pad in 0 256 1024 2048; do
  i=$((i+1))
  if [ $((i % 2)) = 1 ]; then order='old new'; else order='new old'; fi
  for side in $order; do
    taskset -c "$cpu" timeout 45 "$R/runner-$side-$pad" --collect > "$R/pair-$i-$side.tsv" 2> "$R/pair-$i-$side.log"
  done
  if [ $((i % 2)) = 1 ]; then order='a b'; else order='b a'; fi
  for side in $order; do
    taskset -c "$cpu" timeout 45 "$R/runner-old-$pad" --collect > "$R/control-$i-$side.tsv" 2> "$R/control-$i-$side.log"
  done
done
"$R/runner-old-0" --compare pair-1-old.tsv pair-1-new.tsv pair-2-old.tsv pair-2-new.tsv pair-3-old.tsv pair-3-new.tsv pair-4-old.tsv pair-4-new.tsv > comparison.txt
"$R/runner-old-0" --compare control-1-a.tsv control-1-b.tsv control-2-a.tsv control-2-b.tsv control-3-a.tsv control-3-b.tsv control-4-a.tsv control-4-b.tsv > samecode.txt
# Preserve samples, generated text and logs; discard regenerable build products.
rm -rf "$R/build-old" "$R/build-new" "$R"/runner-*
find "$R/observations" -name text.bin -delete
git -C "$HOME/work/BLAKE3" worktree remove --force "$HOME/work/ode-adler-pilot"
git -C "$HOME/work/bench-hashes" worktree remove --force "$HOME/work/ode-clocks-pilot"
echo 'pilot done'
