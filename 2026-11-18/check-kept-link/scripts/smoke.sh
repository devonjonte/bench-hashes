#!/bin/sh
# Functional smoke of the kept-link relink inside `check` (local machine; its timings are no evidence).
# 1. the unit test; 2. a probe of one point through the new check; 3. for one later seed on each side,
# today's way of making that layout (a cargo compile with its order file) must give the relinked bytes.
set -u
ulimit -c 0
B=$HOME/bench-relink
L=$HOME/tmp/arms-smoke/lib
O=$HOME/bench-hashes-validation/relink-in-check/out
if [ "${1:-}" != compare ]; then
rm -rf "$O"; mkdir -p "$O"
unset CARGO_TARGET_DIR RUSTFLAGS CARGO_ENCODED_RUSTFLAGS
export CARGO_BUILD_JOBS=6  # the machine has 14 GiB; twenty compilers at once passed its memory floor
cd "$B" || exit 2
# The tests run on the workhorse: compiling the test build here passed the memory floor twice.
cargo build --release --quiet > "$O/build.txt" 2>&1; echo "build exit $?" | tee -a "$O/exit.txt"
start=$(date +%s)
./target/release/bench-hashes check --fork "$L" --new 27eacce3a5c2e03043f4fcd347c178a80f9d911c --against 4483281c45eab341ca6f829de508e91d6c381e85 \
  --probe '64 B' --when-quiet --keep "$O/kept" > "$O/check.stdout.txt" 2> "$O/check.stderr.txt"
echo "check exit $? in $(( $(date +%s) - start )) s" | tee -a "$O/exit.txt"
# The same check again at once: Cargo holds both sides fresh, and the kept link must still be made anew.
start=$(date +%s)
./target/release/bench-hashes check --fork "$L" --new 27eacce3a5c2e03043f4fcd347c178a80f9d911c --against 4483281c45eab341ca6f829de508e91d6c381e85 \
  --probe '64 B' --when-quiet --keep "$O/kept-again" > "$O/check-again.stdout.txt" 2> "$O/check-again.stderr.txt"
echo "the same check again: exit $? in $(( $(date +%s) - start )) s" | tee -a "$O/exit.txt"
fi
C="$L/target/check"
for side in old new; do
  ls "$C/$side" > "$O/$side.listing.txt" 2>&1
  order=$(ls "$C/$side"/order-*.txt | sort -V | sed -n 2p)
  seed=${order##*/order-}; seed=${seed%.txt}
  lld="$C/lld"
  git=$(sed -n '/^\[dependencies.blake3-servil\]/,/^\[/p' "$C/$side/target/bench-src/Cargo.toml" | sed -n 's/^ *git = "\(.*\)"$/\1/p' | head -1)
  crate="$C/$side/src"; grep -q '^name = "blake3-servil"$' "$crate/threads/Cargo.toml" 2> /dev/null && crate="$crate/threads"
  patch="patch.\"$git\".blake3-servil.path=\"$crate\""
  echo "$side: $patch" >> "$O/patch.txt"
  ( cd "$C/$side/target/bench-src" && CARGO_TARGET_DIR="$C/$side/target" BENCH_HASHES_CHECKOUT="$B" BENCH_HASHES_FORK="$C/$side/src" \
      cargo --config "$patch" rustc --release --quiet --bin bench-hashes -- \
      -Clink-arg=-fuse-ld=lld "-Clink-arg=-B$lld" "-Clink-arg=-Wl,--symbol-ordering-file=$order" -Clink-arg=-Wl,--no-warn-symbol-ordering ) > "$O/$side.cargo.txt" 2>&1
  echo "$side: cargo for seed $seed exit $?" | tee -a "$O/exit.txt"
  if cmp -s "$C/$side/target/release/bench-hashes" "$C/$side/bench-hashes-$seed"; then echo "$side seed $seed: the relinked executable equals cargo's compile" | tee -a "$O/exit.txt"; else echo "$side seed $seed: DIFFERENT" | tee -a "$O/exit.txt"; fi
  sha256sum "$C/$side/target/release/bench-hashes" "$C/$side"/bench-hashes-[0-9]* >> "$O/$side.sha256.txt"
done
