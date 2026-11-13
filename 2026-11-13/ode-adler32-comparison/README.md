# Adler-32: Ode versus zlib, zlib-ng and libdeflate

November 13, 2026. Two questions from Zooko: compare the proved Adler-32 fairly
with established implementations, and try reusing its existing Ode project in a
larger compression/decompression codebase.

## Result

**The current scalar Ode loop is substantially slower on bulk inputs.** All three
libraries are faster at every tested length from 16 bytes upward, across all four
patterns and both alignments, on both CPUs. Ode wins some empty/one-byte cases.

Here are the paired results for **4 KiB of seeded-random bytes, aligned to 64
bytes**. Times are medians of four per-run means. Each row's Ode and competitor
were measured back-to-back; each competitor has its own four Ode runs.

| CPU | Competitor | Paired Ode ns | Competitor ns | Ratio of median times | Range of paired speedups |
|---|---|---:|---:|---:|---:|
| EPYC 9275F | zlib 1.4 | 3247.11 | 850.21 | 3.819× | 3.737–4.493× |
| EPYC 9275F | zlib-ng 2.3.3 | 3336.59 | 25.83 | 129.179× | 116.688–129.830× |
| EPYC 9275F | libdeflate 1.26 | 3367.50 | 16.74 | 201.221× | 178.229–202.215× |
| Xeon Gold 6330 | zlib 1.4 | 21016.40 | 2382.96 | 8.819× | 8.681–8.903× |
| Xeon Gold 6330 | zlib-ng 2.3.3 | 20987.28 | 94.74 | 221.518× | 218.428–222.984× |
| Xeon Gold 6330 | libdeflate 1.26 | 21220.01 | 101.15 | 209.790× | 203.788–212.436× |

The advantage persists at 1 MiB of aligned random bytes. On the EPYC, zlib,
zlib-ng and libdeflate have median time ratios of 4.927×, 110.922× and 153.381×
respectively. On the Xeon, those ratios are 9.113×, 219.548× and 207.658×.
`SELECTED.md` shows absolute times and paired ranges for representative sizes.
The complete Rust-generated tables retain every pattern, size and alignment.

These are implementation comparisons. Ode currently processes one byte and two
conditional modular reductions at a time. The established libraries use different
algorithms, including blocked arithmetic and architecture-specific vector code.
This experiment does not isolate compiler quality from algorithm choice.

## What ran

[Declared procedure and workload](https://github.com/devonjonte/BLAKE3/blob/83f2730a338c9684396de3f8a5cf72c885dc6342/tools/verify/machine/experiments/adler32/COMPARISON.md).

| Input | Commit |
|---|---|
| Harness and declared plan | `83f2730a338c9684396de3f8a5cf72c885dc6342` |
| Original Ode implementation and checked proof | `2aa3d245305b494143223b341e564642a4eb2d20` |
| zlib 1.4 | `99623ef7097352da7993ba614161fd6a311e046e` |
| zlib-ng 2.3.3 | `12731092979c6d07f42da27da673a9f6c7b13586` |
| libdeflate 1.26 | `92e6a0db9fa848d742f9eb286c92afc60f2c3dda` |
| clocks / bench-hashes | `5f99f456951ab36f7201decd8aa5e0249ec67bd1` |

The three library tags were their latest stable GitHub releases when selected;
the release metadata is preserved in `local-checks/`. All libraries use the same
GCC 15.2.0 compiler on both hosts, CMake 3.31.8, static linking and no LTO. Actual
release flags are **zlib -O3, zlib-ng -O2, libdeflate -O2**. CPU optimizations and
normal runtime dispatch stay enabled. Rust is 1.99.1. No system library is replaced.

The common Rust adapters take a pointer and length and return u32. Each call goes
through an indirect function pointer. The library adapters supply initial checksum
1. Public entry/dispatch and argument setup costs are included; no overhead is
subtracted. The timed loop consumes every result. No allocation, correctness
checking, Python, I/O, or dynamic loading takes place inside it.

Each binary links all four engines. Before calling any engine it compares Ode's
linked 171-byte body with the proved observation. Each engine passes fixed vectors
and independent scalar reference checks at boundary lengths, patterns and
alignments. Four binaries differ by pre-Ode text padding 0, 256, 1024 and 2048.
Linked addresses and adapter/kernel disassembly are recorded.

## Collection and precision

Both jobs ran under their machines' exclusive bench-turn, pinned to CPU 0.
There are four Ode/competitor pairs per question, alternating order, with competitor
order rotated across rounds. Four Ode/Ode pairs are interleaved as controls.
Each run has 80 cells: ten lengths from 0 through 1 MiB, zero/255/sequential/seeded
random bytes, and 64-byte aligned/one-byte-offset buffers. Each cell has 12 batches
targeted at 5 ms through unchanged `clocks`.

**All 64 runs were quiet, and all succeeded on their first attempt.** All 80
same-code control cells judged level on each machine. Individual pairs still
vary: on the EPYC the aligned-random 4 KiB same-code pair range is 0.767–1.041×
old/new. Level means the test found no qualifying change; it supplies no bound
that excludes smaller effects. The large library advantages appear in every
corresponding pair. We make no general reliability claim from this experiment.

**Thread counters were unavailable in every run.** Raw wall times, call counts,
process CPU times and load windows are retained. There is no cycle, speed-state
or energy claim. The selected dispatch function names were unobserved because
gdb was unavailable on the measurement hosts; the build settings, CPU features,
compiled kernels and normal dispatcher calls are preserved.

Each run's mean is total wall time / total calls. The comparison uses clocks'
paired log-ratio test, 5% false-discovery rate over the 80 cells of one competitor
on one machine, and a 3% practical margin. The three competitors and two CPUs are
separate questions. The judged ratio is the geometric mean of paired competitor/
Ode time ratios. Tables additionally give medians and paired ranges. All eight
comparison tables reproduce byte-for-byte when reread locally with the Rust reader.
Digits are formatting precision, not confidence bounds. Nanoseconds remain unscaled.

This is **warmed, repeated-buffer, one-shot throughput**. In particular, the very
high GB/s values describe cache-hot repeated processing, rather than DRAM or file
I/O bandwidth. Cold calls, streaming updates, concurrent callers, other CPUs and
end-to-end compression throughput remain separate workloads. Each optimized
library was paired against Ode; this does not give a direct paired ranking between
the two optimized libraries.

## Reuse in a real library

[Recipe and source](https://github.com/devonjonte/BLAKE3/blob/a550b05ba28bd1ac2433520842994e6f152732ca/tools/verify/machine/experiments/adler32/REUSE.md).

Libdeflate's zlib encoder and decoder each call Adler-32 with seed 1 on a whole
buffer. Those two sites fit the existing Ode contract. The experiment invokes the
existing Ode project's proof-first build, links its unchanged object into a copied
libdeflate source, and checks the 171 bytes in the final shared library. It keeps
the general incremental Adler API and DEFLATE engine unchanged.

The final recipe uses a private archive link: both Ode assembler aliases are local,
and the consumer's calls bind directly to its checked body. It checks exports and
dynamic relocations as well as bytes. Inspection of the initial recipe exposed
preemptible symbols; `reuse/initial/` preserves it and `reuse/final/` records the
private-binding version. Both are experiments, not proposed performance replacements.

At compression levels 1, 6 and 12, **120 input/level cases pass**. Original and
substituted libdeflate produce byte-identical streams, Python zlib decompresses
both, and both library versions decode those and Python-made streams correctly.
Spare output capacity exercises actual-output-length handling. Changing each of
the four trailer bytes gives **480 bad streams**, all rejected by both decoders.
The incremental public Adler API also retains correct two-part checksums.

Only the Ode callee has the machine-code theorem. The full C consumer receives
executable integration tests. Ode's existing x86 model/lifter and 32 native
bv_decide axioms beside Lean's three remain its trust boundary. This is mixed-
language reuse; a larger Ode caller importing another Ode function is separate.
The integration has no timing or end-to-end speed claim.

## Records and reproduction

Each machine folder contains the exact self-contained `run.sh`, samples, accepted
pair manifests, Rust comparison tables, build/validation logs, configuration,
linked-code text, executable hashes and public environment description. Regenerable
executables, objects, archives and dependency checkouts were removed under the
measurement lock before delivery. The CMake download was checked with SHA-256
`630615d8e98ac33eba7fbe472626dff5c899c85af3c024585ae109166a6909d0` and BLAKE3
`6ff85c4a9f065b4e53a7db100d4c5440f37300759f08ed2563d5f2f798689773`.

`local-checks/` preserves the six passing nextest tests and the initial missing-
CMake setup failure (no timings). The CMake prerequisite was resolved before either
measurement job. `reuse/` holds integration patches, proof/code text, configuration,
build logs and the summary. No binary build products are published.

Normal reproduction uses the pinned harness's `prepare_bench.py` and
`--validate`, `--collect ENGINE`, `--compare OLD NEW ...` commands. Machine `run.sh`
files supply the exact order, layouts and bounded whole-pair retry policy.
