# Same-code comparison can mistake ordinary data for panic locations

## Fixed-input counterexample

The benchmark's ELF comparison can report **Same** for programs with different
observable behavior. Its panic-location mask recognizes a byte pattern:
a pointer and length for a string ending in `.rs`, followed by two 32-bit words.
An ordinary file-limit record has that same shape.

Two translation units at identical build paths produce a pair of programs. One
record names `input.rs`; its `max_bytes` changes from111 to222. Each program prints
its limit. Their output is independently checked against those constants.

| Record's filename | Program outputs | Comparison without location mask | With location mask |
|---|---|---|---|
| `input.rs` | 111, 222 | Differs: `.data.rel.ro` | **Same** |
| `input.bin` | 111, 222 | Differs: `.data.rel.ro` | Differs: `.data.rel.ro` |

The second row is the matched control. With ordinary data retained, the comparator
finds only `.data.rel.ro` changed. It always excludes ELF notes, including build
IDs, and reports no function-byte or size changes. No performance measurement took place.
This establishes a deterministic limitation of the recognizer. It gives no
estimate of its occurrence in existing BLAKE3 builds.

## Source and reproduction

The unchanged `samecode.rs` is from bench-hashes commit
**60e0f7206902a8be45b27754643d447ddc2a0553**, identical to that file at its parent
**81e4b45a84e60f06b0ad93509403c5c33b2ad2c4**. `check::same_path_verdict` calls this
comparison with location masking enabled. The wrapper calls that production
module directly; it contains no replacement comparison implementation.

On Linux x86-64 with a C compiler, Rust and GNU binutils:

```sh
mkdir -p build
cc -O2 -fPIE -fno-lto -c main.c -o build/main.o
rustc --edition=2024 compare.rs -o build/compare
# For each suffix rs/bin and limit111/222:
cc -O2 -fPIE -fno-lto -DNAME='"input.rs"' -DLIMIT=111 -c limit.c -o build/limit.o
cc -pie build/main.o build/limit.o -o build/program
# Retain each program under its own name, then:
build/compare build/rs-111 build/rs-222
```

`run.sh` gives the exact two-pair recipe. This record includes source, actual
compiler versions, both comparisons, each program's stdout and data-section dump,
and dual binary fingerprints. Binary products are excluded from the archive.
Recipes/logs replace the development home prefix with `<development-home>`.
Published-file SHA-256 and BLAKE3 manifests bind the record separately.

## Decision to make

A conservative comparison would retain these data words. It would also send
changes that only move panic source locations to the normal measurement path.
Removing the recognizer would simplify the tool while giving up those early
exits. Inferring semantic use from more binary patterns would add complexity
and still need its own correctness evidence.

Devon owns the benchmark's next decision. Production code remains unchanged by
this diagnostic. The next move is to weigh that explicit trade and add a
permanent regression test before changing the shortcut.
