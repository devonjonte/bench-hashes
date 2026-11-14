# Same-code comparison can mistake ordinary data for panic locations

## Fixed-input counterexample

The benchmark's ELF comparison can report **Same** for programs with different
observable behavior. Its panic-location mask recognizes a byte pattern:
a pointer and length for a string ending in `.rs`, followed by two 32-bit words.
An ordinary file-limit record has that same shape.

Two translation units at identical build paths produce a pair of programs. One
record names `input.rs`; its `max_bytes` changes from 111 to 222. Each program prints
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
# For each suffix rs/bin and limit 111/222:
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

## Correction under review

Candidate **efe3dac3d74426053371be0c9bcf9c4dc1950ad9**, based on landed
**6b88d24ae8691b7152fe521d5bcdf054da3eff2c**, removes the location recognizer,
its boolean option and its relocation-only state/parser. It keeps these data
words. The explicit cost is that line-only location changes may now proceed
to measurement. Declared provenance masks and ELF-note exclusion remain the
comparison's existing boundaries. The timed calls and sampled statistical rule
stay unchanged.

The permanent Rust test binds an ordinary file-limit record by its symbol,
independently of the recognizer, then changes its stored 111 to 222. It **fails
on the old implementation**. After correction, all **193 release tests pass**
(sixteen machine/ignored tests skipped), formatting/diff checks pass, and the
same C binaries produce these corrected comparisons:

| Inputs | Corrected result |
|---|---|
| `input.rs`, 111→222 | Differs: `.data.rel.ro` |
| `input.bin`, 111→222 | Differs: `.data.rel.ro` |
| Either filename, same executable on both sides | Same |

`corrected/` preserves the original failing Rust control, its patch against
candidate 60e0f720, the corrected tests and C replays, and the exact new source.
Candidate 60e0f720 and landed 6b88d24a have identical trees. The symbol lookup is
shared with the existing changed-function test. One heuristic, option and
relocation map leave production; a fixed-symbol fixture holds the regression.
This is a targeted comparison correction, with no estimate of historical
false-Same frequency.

To replay the corrected reader after building the C fixtures above:

```sh
rustc --edition=2024 corrected/compare.rs -o build/compare-corrected
build/compare-corrected build/rs-111 build/rs-222
```

Tracked in [Same-code shortcut can mask ordinary configuration data](https://github.com/servil-software-factory/bench-hashes/issues/219).
Devon's next move is final CI and landing. Performance collection is skipped:
the changed decision precedes measurement and alters no hashing workload.
