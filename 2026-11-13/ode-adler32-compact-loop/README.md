# Adler-32: a compact 16-turn raw kernel

These November 13 measurements are archived on November 14. The optimized
checksum remains **UNVERIFIED**. Only the [original scalar implementation](../ode-adler32-proof/)
has a whole-checksum machine theorem. This archive completes publication of the
already-collected studies; further speed exploration stays paused.

## Question and result

Can a fixed 16-turn loop reduce the raw kernel's code footprint and improve its
complete caller? The candidate replaces sixteen expanded turns with a loop,
keeping the arithmetic, per-block cleanup, C caller, reductions, tails and
alignment policy. It changes instruction-cache footprint and branch scheduling
together; these timings leave their individual contributions unresolved.

The kernel shrinks from **1,901 bytes / 309 static instructions to 419 / 73**.
The caller object's sections match the baseline; its callee relocation is the
sole change. These are static counts, separate from execution-work evidence.

| Comparison, wall time | Before | After | Paired verdict |
|---|---:|---:|---|
| EPYC old raw caller → loop, aligned 64 KiB | 426.45 ns | 303.13 ns | Faster |
| EPYC old raw caller → loop, offset-one 64 KiB | 428.53 ns | 304.42 ns | Faster |
| EPYC existing libdeflate 512-bit → loop, aligned 64 KiB | 292.70 ns | 303.49 ns | Slower |
| EPYC existing libdeflate 512-bit → loop, offset-one 64 KiB | 284.71 ns | 304.71 ns | Slower |
| Xeon old raw caller → loop, offset-one 64 KiB | 1938.21 ns | 2025.44 ns | Slower |

Values are the original reader's medians of per-run means; its paired-ratio
judgments use shared `clocks` rules. All sixteen cells appear in every full table.
The loop improves four EPYC raw-caller cells (both 64 KiB and 1 MiB alignments);
the other twelve are Level. Xeon has fifteen Level cells and the offset-one
64 KiB slowdown above. Level means insufficient evidence, including where the
four-pair estimates vary substantially.

Against libdeflate's existing 512-bit kernel, the loop also loses at 16/64/256 B
on both hosts and at zero bytes on EPYC. It wins at one byte. The candidate
retains the old raw caller's tiny-input design. Its EPYC bulk improvement leaves
costs against the existing library implementation, and its machine proof remains
open. These results give no basis for resuming a broad optimization campaign.

## Scope and source

- EPYC 9275F and dual Xeon 6330 (`x86-icelake-2`), under their measurement locks.
  All **80 process runs were quiet**, with no busy retry.
- Five questions per host, four paired linked layouts each (padding
  0/256/1024/2048), alternating sides and rotating questions.
- Each run measures sixteen cells: fixed pseudorandom data at lengths
  0/1/16/64/256/4096/65536/1048576 bytes, aligned to 64 bytes or offset by one.
  Warm calls include the indirect adapter and result consumption. Twelve batches
  per cell request 20 ms each; calibration makes tiny-call batches shorter.
- Same-code controls compare the raw caller with itself and the existing
  libdeflate 512-bit kernel with itself. Both controls were all Level.
- Experiment: `devonjonte/BLAKE3`
  `555e2c09d79d05d93dbe3e6f812dd10003dbe3c7`.
- Measurement/comparison: `devonjonte/bench-hashes` clocks
  `5f99f456951ab36f7201decd8aa5e0249ec67bd1`.
- libdeflate 1.26: `92e6a0db9fa848d742f9eb286c92afc60f2c3dda`.
  Its default dispatcher selects the 512-bit kernel on EPYC and 256-bit on Xeon;
  `libdeflate512` calls the existing 512-bit implementation directly.
- Raw samples retain wall and process CPU time. Hardware cycles, instructions
  and energy were unavailable. Tables judge wall time with 5% false-discovery
  rate and 3% margin over all sixteen cells in each question.

Before collection, all nineteen engines passed execution/reference/guard checks.
The deliberately shortened fifteen-turn kernel failed a fixed anchor; restoring
sixteen turns passed. Earlier native objects retained their sections, headers
and relocations. Those executable checks establish their stated scope; the wide
kernel, runtime loop, image/table binding and complete caller still need their
machine theorem.

## Reproduce and inspect

[`code/run8.sh`](code/run8.sh) pins the entire build and collection recipe.
Collection uses `runner-PADDING --probe ENGINE`, through the locked team queue.
`code/` contains the source-matched experiment and its original plan. The previous
[cleanup/shared-bulk archive](../ode-adler32-cleanup-shared-bulk/) gives the
question that led to this study.

Each host directory contains accepted `QUESTION.pairs` lists, original samples,
logs, five `comparison-QUESTION.tsv` reports, linked images/tables, disassembly,
validation and build provenance. From that directory, the source-matched Rust
reader reproduces a report with:

```sh
ode-adler-observer --compare $(tr '\n' ' ' < QUESTION.pairs)
```

All **ten reports reproduced byte for byte** during archival; `replayed-*.tsv`
retains the outputs. Samples and code stay exact. Logs replace home-directory
prefixes with `<runner-home>` or `<development-home>`. Binary build products are
excluded. SHA-256 and BLAKE3 manifests bind the published files. `validation/`
retains the original local checks and fault/restoration controls.

Published with the [Adler experiment tracker](https://github.com/servil-software-factory/BLAKE3/issues/377).
Devon's next move is to cost one complete proof after the requested review of its
model and image-contract needs. Optimization stays paused.
