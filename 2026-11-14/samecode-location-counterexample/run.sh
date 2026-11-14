#!/bin/sh
set -eu
export PATH=<development-home>/.cargo/bin:<development-home>/bin:$PATH
cd <development-home>/bench-hashes-validation/autonomous-20261114/samecode-counterexample
mkdir -p build
git -C <development-home>/bench-kept-comparisons show 60e0f7206902a8be45b27754643d447ddc2a0553:src/samecode.rs > samecode.rs
cc -O2 -fPIE -fno-lto -c main.c -o build/main.o
rustc --edition=2024 compare.rs -o build/compare
for suffix in rs bin; do
    for limit in 111 222; do
        cc -O2 -fPIE -fno-lto -DNAME="\"input.$suffix\"" -DLIMIT="$limit" -c limit.c -o build/limit.o
        cc -pie build/main.o build/limit.o -o build/program
        cp build/program "build/$suffix-$limit"
        "build/$suffix-$limit" > "$suffix-$limit.stdout.txt"
        test "$(tr -d '\n' < "$suffix-$limit.stdout.txt")" = "$limit"
        objdump -s -j .data.rel.ro "build/$suffix-$limit" > "$suffix-$limit.data.txt"
    done
    build/compare "build/$suffix-111" "build/$suffix-222" > "$suffix-compare.txt"
done
sha256sum build/rs-111 build/rs-222 build/bin-111 build/bin-222 > executable-SHA256SUMS
b3sum build/rs-111 build/rs-222 build/bin-111 build/bin-222 > executable-BLAKE3SUMS
printf 'samecode source '; git -C <development-home>/bench-kept-comparisons rev-parse HEAD
cc --version
rustc --version
