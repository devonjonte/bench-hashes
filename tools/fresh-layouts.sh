#!/bin/bash
# Compare two builds of bench-hashes with a fresh link layout for every pair
# (audit/variance-on-unchanged-code.md): each side's binary relinked with
# lld's --shuffle-sections at the pair's seed, the two run back to back in
# alternating order, then `bench-hashes compare` over all the pairs.
#
#   tools/fresh-layouts.sh OLD_DIR NEW_DIR PAIRS OUT_DIR [bench-hashes options]
#
# OLD_DIR and NEW_DIR are bench-hashes checkouts inside the BLAKE3 servil
# checkouts to measure (built against them as ..). Needs ld.lld; PAIRS of
# at least 3 (10 found the changes in the audit). Options after OUT_DIR
# go to every run. Each run's folder in
# OUT_DIR keeps its samples and output; compare.txt the verdicts.
set -eu
old=$(cd "$1" && pwd); new=$(cd "$2" && pwd); pairs=$3; out=$4; shift 4; options=("$@")
here=$(cd "$(dirname "$0")/.." && pwd)
mkdir -p "$out"; out=$(cd "$out" && pwd)
lld=$(command -v ld.lld || ls /usr/bin/ld.lld-* | tail -1)
mkdir -p "$out/lld" && ln -sf "$lld" "$out/lld/ld.lld"
build() { # side dir seed
  (cd "$2" && CARGO_TARGET_DIR="$out/target-$1" RUSTFLAGS="-C link-arg=-fuse-ld=lld -C link-arg=-B$out/lld" \
    cargo rustc -q --release --bin bench-hashes --config 'patch."https://github.com/johnservil/BLAKE3".blake3-servil.path=".."' \
    -- -C "link-arg=-Wl,--shuffle-sections=*=$3" && git checkout -q Cargo.lock)
  cp "$out/target-$1/release/bench-hashes" "$out/bench-$1-$3"
}
run() { # side pair
  mkdir -p "$out/$1-$2" && (cd "$out/$1-$2" && "$out/bench-$1-$2" "${options[@]}" > stdout.txt 2> stderr.txt)
}
for p in $(seq 1 "$pairs"); do
  build old "$old" "$p"; build new "$new" "$p"
  if [ $((p % 2)) = 1 ]; then run old "$p"; run new "$p"; else run new "$p"; run old "$p"; fi
done
samples() { for p in $(seq 1 "$pairs"); do ls "$out/$1-$p"/benchmark-results/*/bench-hashes.samples.tsv; done; }
# This fork's compare (its verdicts: clocks::summary::discoveries).
cargo run -q --release --manifest-path "$here/Cargo.toml" -- compare $(samples old) -- $(samples new) > "$out/compare.txt"
echo "$(grep -c ' faster,' "$out/compare.txt") faster, $(grep -c ' slower,' "$out/compare.txt") slower: $out/compare.txt"
