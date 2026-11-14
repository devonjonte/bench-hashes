#!/bin/sh
set -eu
export PATH=<development-home>/.cargo/bin:<development-home>/bin:$PATH
cd <development-home>/bench-hashes-validation/autonomous-20261114/samecode-note-counterexample
mkdir -p build
git -C <development-home>/bench-samecode-data show efe3dac3d74426053371be0c9bcf9c4dc1950ad9:src/samecode.rs > samecode.rs
cc -O2 -fPIE -c main.c -o build/main.o
rustc --edition=2024 compare.rs -o build/compare
for limit in 111 222; do
    cc -DLIMIT="$limit" -c note.S -o build/note.o
    cc -pie build/main.o build/note.o -o build/program
    cp build/program "build/limit-$limit"
    "build/limit-$limit" > "$limit.stdout.txt"
    test "$(tr -d '\n' < "$limit.stdout.txt")" = "$limit"
    readelf -n "build/limit-$limit" > "$limit.notes.txt"
done
build/compare build/limit-111 build/limit-222 > compare.txt
sha256sum build/limit-111 build/limit-222 > executable-SHA256SUMS
b3sum build/limit-111 build/limit-222 > executable-BLAKE3SUMS
sha256sum --check --quiet executable-SHA256SUMS
b3sum --check --quiet executable-BLAKE3SUMS >/dev/null
cc --version
rustc --version
