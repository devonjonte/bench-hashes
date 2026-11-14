# Adler-32: whole-call cleanup and shared bulk dispatch

These November 13 measurements are archived on November 14. The optimized
implementations remain **UNVERIFIED**. The [original scalar proof](../ode-adler32-proof/)
covers its 171-byte implementation. Further speed exploration remains paused while
the complete optimized machine-proof cost is unresolved.

## Questions and results

1. Does moving x86 vector-register cleanup (`vzeroupper`) from every 4096-byte
   raw-kernel return to the end of the complete checksum call help?
   **All 16 old/new cells were Level on each host.** The EPYC bulk cost remains.
   At aligned 64 KiB, the existing libdeflate 512-bit implementation took about
   294 ns and the raw caller about 431 ns. Level means insufficient evidence
   for a classification.
2. Does a tiny seed-one entry point that tail-calls the existing shared bulk
   function improve on duplicating that body? Results depend on the host and
   input. EPYC had five Faster and eleven Level cells. Xeon had two Slower
   one-byte cells (about 3.51 to 4.01 ns) and fourteen Level cells.

Against libdeflate's existing 512-bit implementation, the shared-bulk variant
was Faster at 0/1/16/64 B on EPYC and at 0/1/16 B on Xeon. Both hosts classified
its 256-byte calls Slower, approximately 10% on EPYC and 8% on Xeon. Larger
results vary by size and alignment; every cell remains in the comparison tables.
The width-matched comparisons matter: Xeon's default libdeflate dispatch uses
its existing 256-bit implementation, while EPYC selects its 512-bit one.

These are short, warmed-call observations of experimental callers. They establish
neither a general library improvement nor a whole optimized correctness theorem.

## Scope and source

- Hosts: EPYC 9275F and dual Xeon 6330 (`x86-icelake-2`). Each job held its host's
  measurement lock. All **128 process runs were quiet**; no busy retry occurred.
- Eight paired questions per host, four linked layouts per question, alternating
  order. Layout padding: 0, 256, 1024 and 2048 bytes.
- Sixteen cells per run: the fixed pseudorandom input pattern, lengths
  0/1/16/64/256/4096/65536/1048576 bytes, with 64-byte alignment and offset one.
  Calls include the indirect adapter and result consumption. Each process keeps
  twelve measured batches per cell, requesting 20 ms each. Calibration makes
  tiny-call batches shorter. This is the declared `--probe` workload.
- Same-code controls: the original raw caller against itself, and the existing
  libdeflate 512-bit implementation against itself. Both controls were all Level.
- Experiment: `devonjonte/BLAKE3` commit
  `6065226c7c0ff0c0fc60150c0629f55349bdbf4a`.
- Measurement and comparison: `devonjonte/bench-hashes` clocks commit
  `5f99f456951ab36f7201decd8aa5e0249ec67bd1`.
- libdeflate 1.26: `92e6a0db9fa848d742f9eb286c92afc60f2c3dda`.
  The job recipe pins every other validation dependency too.
- Raw records retain wall and process CPU time. Hardware cycle, instruction and
  energy evidence was unavailable; the comparison tables summarize wall time.

The original Rust reader displays medians of per-run means and judges paired
ratios with shared `clocks` rules: 5% false-discovery rate and 3% margin. Four
layout pairs provide a limited pilot. Same-code Level results leave uncertainty
about smaller or context-sensitive changes.

## Reproduce and inspect

[`code/run7.sh`](code/run7.sh) is the complete pinned collection/build recipe.
Its timing calls are `runner-PADDING --probe ENGINE`. Use the team's locked
measurement queue to collect fresh timings. `code/` also retains the exact
experiment sources; `FAST.md` is the source-matched working plan.

Each host directory contains accepted `QUESTION.pairs` file lists, original
samples and logs, all eight `comparison-QUESTION.tsv` reports, linked-image
fingerprints, disassembly, validation and build provenance. The same source's
Rust reader reproduces a table with:

```sh
ode-adler-observer --compare $(tr '\n' ' ' < QUESTION.pairs)
```

Run that command from the host directory. All **16 reports reproduced byte for
byte** during this archival pass; `replayed-*.tsv` retains those outputs. No new
timing or implementation change was made. Samples and code remain exact. Logs
replace home-directory prefixes with `<runner-home>` or `<development-home>`;
measurement values, flags, addresses and digests remain intact. Binary build
products are excluded. SHA-256 and BLAKE3 manifests bind the published files.

`validation/` retains local checks from the original experiment. The archival
attempt first stopped because it encountered the partial archive's existing
home-path redaction; it preserved those files, adopted the same redaction and
then completed. Its failure and successful replay logs are retained.

Published with the [Adler experiment tracker](https://github.com/servil-software-factory/BLAKE3/issues/377).
Devon owns this evidence and the next proof-cost decision; optimization stays
paused. The [compact-loop follow-up](../ode-adler32-compact-loop/) is the final
already-collected study.
