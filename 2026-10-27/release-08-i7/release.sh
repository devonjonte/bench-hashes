#!/bin/sh
# The i7's release items for 0.8 at the commit John posted on BLAKE3 #125
# (October 27, 17:36): library 0.8.0+f7ce4e4e at 934dee89, bench 0.18 at
# 67bae864 nested in it. In John's order: the x86 suites; the release check;
# the same-library check (option a); the full --all run with the servil pin
# patched to the enclosing checkout; the b3sum run; then the x86 mutation
# run (mine at 356e4ead predates a31dbf73, so it runs again here).
set -u
export PATH=/home/agent/.cargo/bin:/home/agent/bin:$PATH TMPDIR=/home/agent/tmp
unset RUSTFLAGS
OUT=/home/agent/bench-hashes-validation/release-08-i7
W=/home/agent/BLAKE3-rel08
PATCH='patch."https://github.com/johnservil/BLAKE3".blake3-servil.path=".."'
cd $W
[ "$(git rev-parse HEAD)" = 934dee8902889186e3da9b62edf43699dd1c6305 ] || { echo "fork not at 934dee89"; exit 1; }
[ "$(git -C bench-hashes rev-parse HEAD)" = 67bae864751ae766f170be94ac38a9b3723fc181 ] || { echo "bench not at 67bae864"; exit 1; }
[ -z "$(git status --short)" ] && [ -z "$(git -C bench-hashes status --short)" ] || { echo "a checkout is not clean"; exit 1; }
echo "== fork $(git rev-parse HEAD), bench $(git -C bench-hashes rev-parse HEAD) $(date -u +%H:%M)"

echo "== suites $(date -u +%H:%M)"
(export RUSTFLAGS="-D warnings"
 cargo nextest run --features=serde,zeroize; echo "STEP features rc=$?"
 cargo test --doc --features=serde,zeroize; echo "STEP doc rc=$?"
 cargo nextest run --no-default-features; echo "STEP nostd rc=$?"
 cargo nextest run --features=; echo "STEP default-features-off rc=$?"
 cargo nextest run --features= --release; echo "STEP release rc=$?"
 CFLAGS=-flto cargo build --tests; echo "STEP lto rc=$?"
 (cd test_vectors && cargo nextest run); echo "STEP vectors rc=$?"
 (cd capi && cargo nextest run --release); echo "STEP capi rc=$?"
 (cd b3sum && cargo nextest run); echo "STEP b3sum rc=$?"
 sh tools/check-builds.sh; echo "STEP check-builds rc=$?") > $OUT/suites.stdout.txt 2> $OUT/suites.stderr.txt
grep STEP $OUT/suites.stdout.txt

cd bench-hashes
echo "== release check $(date -u +%H:%M)"
cargo run -q --release -- check --against bfbda1920283335ff3802723db11c209159f47fc --old-bench 5be5f23699ee7146ada56a08777173a4ee1c7bde --cells all --keep $OUT/release-check
echo "== release check exit $? $(date -u +%H:%M)"
echo "== same-library check $(date -u +%H:%M)"
cargo run -q --release -- check --against 934dee8902889186e3da9b62edf43699dd1c6305 --old-bench 3f9edd139b2b1388c762ab82b4584cd09f3c53a7 --cells all --keep $OUT/same-library
echo "== same-library check exit $? $(date -u +%H:%M)"

echo "== full run $(date -u +%H:%M)"
cargo build -q --release --config "$PATCH"
cargo run -q --release --config "$PATCH" -- --all > $OUT/full.stdout.txt 2> $OUT/full.stderr.txt
echo "== full exit $? $(date -u +%H:%M)"
echo "== b3sum run $(date -u +%H:%M)"
LAYOUTS=4 python3 tools/b3sum-contenders.py $W /home/agent/b3c-rel08 > $OUT/b3sum-contenders.txt 2> $OUT/b3sum-contenders.stderr.txt
tr '\n' '\0' < $OUT/b3sum-contenders.txt | xargs -0 cargo run -q --release --config "$PATCH" -- b3sum --files /home/agent/bench-hashes-validation/b3sum-linux/files > $OUT/b3sum.stdout.txt 2> $OUT/b3sum.stderr.txt
echo "== b3sum exit $? $(date -u +%H:%M)"

cd $W
echo "== mutants $(date -u +%H:%M)"
python3 tools/mutants/check.py > $OUT/mutants.stdout.txt 2> $OUT/mutants.stderr.txt
echo "== mutants exit $? $(date -u +%H:%M)"
