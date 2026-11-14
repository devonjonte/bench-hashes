# Same-code comparison: preserve meaningful data

`check` can skip measurements when its two builds compare as unchanged. Two
fixed-input counterexamples show that its exclusions could erase meaningful
data. Candidate **fb6f00b1a70d9b777c1e35e09943b79e4dc2d5f0** keeps those data.
Within sections marked to occupy memory, only declared source labels and the
generated build identifier may differ.

## Counterexamples and correction

Each executable pair prints independently fixed outputs, **111 and 222**.
Function bytes and sizes remain unchanged according to the comparison.
ELF notes are small records in the executable format Linux uses. A note can
identify a build or hold application data.

| Where the limit lives | Earlier reader | Earlier result | Final reader |
|---|---|---|---|
| Ordinary record naming `input.rs` | `60e0f720` | **Same** | Differs: `.data.rel.ro` |
| Matched record naming `input.bin` | `60e0f720` | Differs: `.data.rel.ro` | Differs: `.data.rel.ro` |
| Valid allocated application note | `efe3dac3` | **Same** | Differs: `.note.file-limit` |

The first reader recognizes a presumed panic location by its byte pattern: a
filename pointer/length followed by two words. An ordinary file-limit record
has that shape. Removing that recognizer fixes the first case. Reviewing the
remaining exclusions then found the note case: ELF notes can also contain
program-readable values. The final reader excludes only the named build-ID note,
with the note section type, while other allocated notes participate.

**Trade:** changes that only move panic source locations or alter other notes
may now proceed to measurement. Identical contents and allowed provenance-only
changes still permit early exits. The timed workloads and sampled statistical
rule stay unchanged. These are finite correctness controls; the frequency of
historical false-Same results in BLAKE3 builds remains unmeasured.

## Tests

The permanent Rust file-limit test binds its record by its symbol, independently
of the discarded recognizer, and changes its stored 111 to 222. It fails on the
old implementation. A second test supplies a fixed, valid ELF object with an
application note and a GNU build-ID note. It fails when all notes are excluded.
`readelf` and `nm` independently accept that object's layout; the Rust fixture
matches an independent Python serializer byte for byte.

After correction, **194 release tests pass**, with sixteen machine/ignored tests
skipped. Formatting and diff checks pass. Final C replays detect all three
changed-data pairs. Unchanged executable controls and a build-ID-only change
remain Same. Existing changed-function and declared-provenance tests pass too.
The archive retains both failing Rust controls and every earlier comparison.

## A useful early exit on real builds

One build-only workhorse control compares library
`f62bc6ac0bc1c86861659d61ffbf4e9546bc8aec` with
`9c0ebbbce7cf0102c648b021b2395e7784b9a189`. Their complete diff is AGENTS.md and two
b3sum files; the hashing-library source the benchmark uses stays unchanged.
Both executables are built through the existing `build-against` path, at one
library checkout path, with benchmark
`efe3dac3d74426053371be0c9bcf9c4dc1950ad9` and one recorded toolchain.

**All three readers report Same** for that exact executable pair: original
`60e0f720`, location-only correction `efe3dac3`, and final `fb6f00b1`. The final
reader replay ran locally on the delivered binaries with the same declared
commit masks. Thus the simpler comparison retains a useful early exit for this
real unchanged hashing-library pair. It establishes this case alone.

Two setup attempts stopped before compilation: the first required an unavailable
b3sum command (exit 127); the second assumed a missing base checkout (exit 128).
The final attempt creates both source checkouts explicitly, completes within its
fifteen-minute bound, and delivers its exact inputs for local SHA-256/BLAKE3
fingerprinting. Both hashes were checked. No timing mode ran in any attempt.

## Records and reproduction

- Root `main.c`, `limit.c`, `limit.h`, `run.sh`, `compare.rs`, `samecode.rs` and
  outputs reproduce the original filename case, using source `60e0f720`.
- `corrected/` preserves the first correction's source, failed control and
  193-test run. That reader still excluded all ELF notes.
- `notes/` contains the valid note executable's source, observed outputs,
  original `efe3dac3` reader, ELF dumps and independent fixture serializer.
- `final/` contains the exact final `samecode.rs`, wrappers, the failed note-scope
  control, the 194-test run and final replays. Its `noop-reader/` replays the real builds.
- `build-control/` retains all three job recipes/deliveries, both successful
  builds' provenance, compiler versions, changed-file list and reader outputs.
  `local-executable-*SUMS` bind the delivered binaries, which remain local
  validation artifacts and are excluded from this data branch.

After building the C fixtures with their supplied recipe, replay the final
reader from this directory:

```sh
mkdir -p build
rustc --edition=2024 final/compare.rs -o build/compare-final
build/compare-final PATH_TO_OLD_EXECUTABLE PATH_TO_NEW_EXECUTABLE
```

The original Rust control patch is against `60e0f720`; its tree equals landed
`6b88d24ae8691b7152fe521d5bcdf054da3eff2c`. The note control patch is against the
intermediate `efe3dac3`. Tests run under `cargo nextest run --release --locked`.
Recipes and logs redact home prefixes as `<development-home>` / `<runner-home>`.
Source modules retain their bytes. Published-file SHA-256 and BLAKE3 manifests
bind the complete record separately from the binary fingerprints.

[Keep ordinary data in the same-code comparison](https://github.com/servil-software-factory/bench-hashes/pull/220)
landed as **eb2d8dec91409d58dd26378e6d2ecab14e6b5f4b** on `next`. All six final CI
checks passed (`final/ci.json`), and the landed tree matches reviewed source
`fb6f00b1` exactly. [The same-code data issue](https://github.com/servil-software-factory/bench-hashes/issues/219)
is closed. Dedicated performance collection was skipped because these changes
govern the pre-measurement comparison.
