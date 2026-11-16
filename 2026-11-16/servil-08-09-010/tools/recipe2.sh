#!/bin/sh
# The page's timing commands run as written, to check they work (the workhorse's
# numbers are discarded: it is no measurement host).
set -u
export PATH="$HOME/.cargo/bin:$PATH"
O="$HOME/runs/recipe-010-v2"
if [ "${BOUNDED_RECIPE:-}" != yes ]; then
  export BOUNDED_RECIPE=yes
  status=0
  timeout --kill-after=30s 2400s sh "$O/run.sh" || status=$?
  printf 'RECIPE_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
  exit "$status"
fi
unset CARGO_TARGET_DIR RUSTFLAGS CARGO_ENCODED_RUSTFLAGS
W="$HOME/work/recipe-010-v2"
rm -rf "$W"; mkdir -p "$W"; cd "$W"
cargo install hyperfine --root tools > "$O/install-hyperfine.log" 2>&1; echo "hyperfine exit $?"
cargo install b3sum --version 1.8.7 --root official > "$O/install-official.log" 2>&1; echo "official exit $?"
RUSTFLAGS="-C target-feature=+crt-static" cargo install b3sums --version 0.9.0 --target x86_64-unknown-linux-gnu --root servil-0.9 > "$O/install-09.log" 2>&1; echo "0.9 exit $?"
RUSTFLAGS="-C target-feature=+crt-static" cargo install b3sums --git https://github.com/servil-software-factory/BLAKE3 --rev 7048303103c69b8609ffe9ca0361197ba318107c --target x86_64-unknown-linux-gnu --root servil-0.10 > "$O/install-010.log" 2>&1; echo "0.10 exit $?"
PATH="$W/tools/bin:$PATH"
hyperfine --version > "$O/hyperfine-version.txt" 2>&1
head -c 268435456 /dev/urandom > FILE
hyperfine -N --warmup 3 'official/bin/b3sum FILE' 'servil-0.9/bin/b3sum FILE' 'servil-0.10/bin/b3sum FILE' > "$O/warm.txt" 2>&1; echo "warm exit $?"
hyperfine -N --prepare 'dd of=FILE oflag=nocache conv=notrunc,fdatasync count=0' 'official/bin/b3sum FILE' 'servil-0.9/bin/b3sum FILE' 'servil-0.10/bin/b3sum FILE' > "$O/cold.txt" 2>&1; echo "cold exit $?"
# Does the dd line evict the file? Pages of FILE in the cache before and after.
if command -v fincore > /dev/null 2>&1; then
  cat FILE > /dev/null; fincore FILE > "$O/fincore-before.txt" 2>&1
  dd of=FILE oflag=nocache conv=notrunc,fdatasync count=0 2> "$O/dd.txt"; fincore FILE > "$O/fincore-after.txt" 2>&1
else
  echo "fincore absent" > "$O/fincore-after.txt"
fi
grep -c . "$O/warm.txt" "$O/cold.txt"
rm -rf "$W"
printf 'DONE %s\n' "$(date -u +%FT%TZ)"
