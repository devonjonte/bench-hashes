# Adler-32: alignment helps; the fixed 4 KiB caller still costs bulk speed

November 13, 2026. [Project tracker](https://github.com/servil-software-factory/BLAKE3/issues/377).

The alignment peel fixes the previous probe's large offset-one Xeon cost. The
fixed 4 KiB raw-sums design matches libdeflate's existing 512-bit implementation
at 4 KiB, then slows several bulk cells. Its simpler proposed proof boundary has
yet to earn those costs. Every optimized implementation here is **UNVERIFIED**.
The original scalar checksum remains the only checked whole-checksum machine
theorem in this project.

All **128 runs are quiet**: eight declared questions, four paired layouts, two
runs per pair, on two CPUs. Each CPU's two same-code controls judge all 16 cells
level. All 16 comparison tables reproduce byte-for-byte with the source-matched
Rust reader. **Counters are unavailable; these results supply wall times only.**
A level verdict means this comparison detected no change beyond its rule; it
leaves effects the experiment cannot resolve open.

## What changed

Source: [`dd83b8e4aa54ad85f2baa0b9ed529067f9919b2d`](https://github.com/devonjonte/BLAKE3/commit/dd83b8e4aa54ad85f2baa0b9ed529067f9919b2d).
[Plan declared before collection](https://github.com/devonjonte/BLAKE3/blob/dd83b8e4aa54ad85f2baa0b9ed529067f9919b2d/tools/verify/machine/experiments/adler32/FAST.md).

- `probe512-align` retains the previous 512-bit/four-prefix/16 KiB probe and its
  reductions. One shared helper peels at most 63 bytes to a 64-byte boundary,
  only when the original input length exceeds 65536. Libdeflate uses that
  threshold too. The earlier five probe objects retain their exact section
  contents, headers and relocations in the local control.
- `probe4096` uses the same alignment policy. Its complete 4096-byte blocks call
  `raw4096`, a straight-line kernel written through the existing Ode source
  machinery: 309 instructions, 1901 text bytes, 128 read-only constant bytes.
  It returns packed raw byte/weighted sums in one u64. An UNVERIFIED C caller
  reduces after each block and composes remaining bytes through the existing
  `probe512-r32`. These timings include the whole checksum caller, its calls,
  reductions and tails.
- `libdeflate512` calls libdeflate's existing 512-bit callee directly. The public
  `libdeflate` dispatcher remains another comparator. Its copied archive's
  sections and relocations stay unchanged. Xeon still selects the 256-bit
  default; EPYC selects 512 bits. Pointer records are preserved.

Libdeflate uses its release flags, **-O2**; native probes use **-O3**, without LTO.
The raw kernel assembles exactly as printed; its C caller uses -O3. Matched-width
comparisons still combine algorithm, compilation and caller effects. Actual
flags, pins and image observations accompany each machine's samples.

## Selected findings, with all cells retained below

Times are medians of per-run means in nanoseconds. Verdicts use the existing
paired rule over each question's entire 16-cell family, with 5% FDR and a 3%
margin. The displayed medians and the paired rule's estimate serve distinct
purposes; the tables retain both.

| CPU / question / bytes / offset | Before ns | After ns | Verdict |
|---|---:|---:|---|
| Xeon, old probe → aligned, 1 MiB / 1 | 32981.67 | 15986.12 | Faster |
| Xeon, LF512 → aligned, 64 KiB / 0 | 985.68 | 907.82 | Faster |
| Xeon, LF512 → aligned, 1 MiB / 1 | 17424.50 | 16002.69 | Level |
| EPYC, LF512 → aligned, 1 MiB / 1 | 6801.72 | 6447.42 | Level |
| EPYC, LF512 → aligned, 16 B / 0 | 2.98 | 3.39 | Slower |
| Xeon, LF512 → aligned, 16 B / 0 | 13.59 | 15.70 | Slower |
| EPYC, LF512 → raw caller, 4 KiB / 0 | 16.71 | 16.63 | Level |
| Xeon, LF512 → raw caller, 4 KiB / 0 | 64.25 | 64.75 | Level |
| EPYC, LF512 → raw caller, 64 KiB / 0 | 292.07 | 426.34 | Slower |
| Xeon, LF512 → raw caller, 64 KiB / 0 | 984.89 | 1021.88 | Slower |
| EPYC, LF512 → raw caller, 1 MiB / 1 | 6666.77 | 7184.72 | Slower |

The existing raw C caller saves six registers even on its tiny-input path;
its extra entry cost stays visible. Its bulk path also normalizes four times
as often as the aligned 16 KiB probe. Those are concrete design differences;
their separate contributions still need an experiment. Next move, Devon's:
isolate normalization frequency and tiny entry layout before choosing a wide
kernel to prove. The current fixed-block result supplies a failed performance
hypothesis alongside useful tests and bounds. A fastest-known claim remains open.

## Validation and exact-image scope

All 13 engines pass clockless validation under SDE (one local layout) and on
both CPUs (all four layouts): fixed/reference checks, every small length 0–257
at all 64 alignments, and read-only guard edges. Both new checksum callers add
all-alignment 4095/4096/4097, 8191/8192/8193 and 65535/65536/65537/65600 cases
for all-255/random inputs, plus canonical-zero sums across a block/tail. The raw
kernel has fixed zero/one/255/ramp anchors and direct all-255/random weighted sums
at every alignment.
The deliberate overread faults. A changed raw weighted shift fails a fixed
anchor. Preparation refuses stale generated assembly before building anything.
Eight Rust reader/adapter nextest tests pass.

`raw-image-*.json` records each linked 1901-byte body and both table addresses,
bytes and dual digests. The image observer checks both read-only tables against
the source values; its planted table-byte change fails. It records text bytes
without claiming they meet a machine theorem. Code/data image binding must
ultimately meet the theorem's own image statement. The scalar baseline's linked
171 bytes are checked separately against its proved observation.

`Block_adler32` checks raw sum bounds A≤1044480, B≤2139617280 and u32 update bounds
for canonical entry sums, with standard axioms only. These are mathematical
bounds. Vector execution, the optimized kernel, and its C caller each retain
their own open machine-proof obligation.

## Reproduce and read the complete records

Clocks and the shared reader/statistical rules come from bench-hashes
`5f99f456951ab36f7201decd8aa5e0249ec67bd1`. Dependencies retain the earlier pins:

| implementation | commit |
|---|---|
| libdeflate 1.26 | `92e6a0db9fa848d742f9eb286c92afc60f2c3dda` |
| zlib 1.4 | `99623ef7097352da7993ba614161fd6a311e046e` |
| zlib-ng 2.3.3 | `12731092979c6d07f42da27da673a9f6c7b13586` |
| ISA-L 2.32.1 | `7c3479e0a9dac17f448603ec1ad64c7c625f530c` |

For each machine:

- `bounded-tools/job.sh`: actual finite build/validation/collection command;
  `run.sh` packages it under the ordinary exclusive 1800-second supervisor.
- `report.json`, `provenance.txt`, flags, symbols, code and raw images: sources
  and actual compiled/linked evidence, all captured before timing.
- `*-pair-*-attempt-*-{old,new}.tsv`: every raw v3 sample. Its header declares
  the 16-cell random probe, counts/load evidence and acceptance. No retry was
  needed. No timing, calibration or load rule changed.
- `*.pairs`: corresponding old/new files, alternated across four layouts
  (padding 0/256/1024/2048). Each `comparison-*.tsv` names its two implementations.
- `validation/`: local confirming and fault-control logs and commands. All
  actual executable candidate source files equal the SDE-validated copies.

Build the adapter with the pinned source and clocks checkout using
`prepare_bench.py ... --skip-proof`, then `cargo build --release`. Replay any
question with its eight `.pairs` paths, in order:

```sh
/path/to/ode-adler-observer --compare OLD1 NEW1 OLD2 NEW2 OLD3 NEW3 OLD4 NEW4
```

The same-code questions are `control512` and `control-align`. Other questions
are `align`, `wide-align`, `default-align`, `raw-step`, `wide-raw`, `default-raw`.
Every question retains all cells, including small and unaligned losses.
Home prefixes in delivered text are redacted as `<runner-home>`; local control
prefixes use `<development-home>`. Numeric samples, counts, load windows and
relative pair names remain unchanged. Executables and regenerable remote build
products are excluded; executable dual digests remain as recorded evidence.

Preparation/validation took about 45 minutes of author work after the assembled
kernel checkpoint; controlled collection took about 6–8 minutes per CPU, including
build/validation. This is warmed, one-core exploratory evidence. Full 80-cell,
real libdeflate integration, adverse/cold/after-work behavior and exact proved
linked-byte measurements remain open.

— Devon Jonte
