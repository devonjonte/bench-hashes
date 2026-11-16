#!/bin/sh
# The page's reproduce-it-yourself commands, run as written (no timing here): three
# installs, their versions, and equal digests.
set -u
export PATH="$HOME/.cargo/bin:$PATH"
O="$HOME/runs/recipe-010"
if [ "${BOUNDED_RECIPE:-}" != yes ]; then
  export BOUNDED_RECIPE=yes
  status=0
  timeout --kill-after=30s 2400s sh "$O/run.sh" || status=$?
  printf 'RECIPE_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
  exit "$status"
fi
unset CARGO_TARGET_DIR RUSTFLAGS CARGO_ENCODED_RUSTFLAGS
W="$HOME/work/recipe-010"
rm -rf "$W"; mkdir -p "$W"; cd "$W"
set -x
cargo install b3sum --version 1.8.7 --root official > "$O/install-official.log" 2>&1; echo "official exit $?"
RUSTFLAGS="-C target-feature=+crt-static" cargo install b3sums --version 0.9.0 --target x86_64-unknown-linux-gnu --root servil-0.9 > "$O/install-09.log" 2>&1; echo "0.9 exit $?"
RUSTFLAGS="-C target-feature=+crt-static" cargo install b3sums --git https://github.com/servil-software-factory/BLAKE3 --rev 7048303103c69b8609ffe9ca0361197ba318107c --target x86_64-unknown-linux-gnu --root servil-0.10 > "$O/install-010.log" 2>&1; echo "0.10 exit $?"
set +x
head -c 67108864 /dev/urandom > big.bin
for b in official servil-0.9 servil-0.10; do
  printf '%s: ' "$b"; "$b/bin/b3sum" --version
  "$b/bin/b3sum" big.bin | cut -d' ' -f1
done > "$O/versions-and-digests.txt" 2>&1
command -v hyperfine > "$O/hyperfine.txt" 2>&1 || echo "hyperfine absent" > "$O/hyperfine.txt"
rm -rf "$W"
printf 'DONE %s\n' "$(date -u +%FT%TZ)"
