# AMD EPYC 9255 — released v7 library record

Native Linux x86-64, 24 physical cores / 48 logical CPUs. Full 96-round run completed October 23, 2026, with quiet reported load: other programs used 0.02 CPUs on average, 0.19 in the busiest window. Performance governor and performance EPP, mains power, no battery.

## Exact measurement source

- Benchmark: `ae6301136e1827cff86bf823f024870775b224d5`, version `0.17.0+1b480eed20d11d7cd1417384e4a9d540b0e321be`.
- Clocks: `7f9f1f7f79f4b239bf9b3089afdde83d2333febb`.
- Servil contender: the released manifest's `082afa368f37c050238c0c9a708348f1940aff51`, not Sam's experimental AVX-512 checkpoint.
- Compiler/target/build metadata are retained in `bench-hashes.samples.tsv`.

The native benchmark suite passed 38 tests; clocks passed 34 with 3 skipped, and the explicitly selected homogeneous CPU3 hardware-counter control passed. These controls do not establish general instrument calibration.

```sh
bench-hashes --rounds 96 --contenders \
  blake3-official,blake3-official-mt,blake3-servil-st,blake3-servil-mt,sha256,sha256-ring,sha3-256,sha1dc
```

The explicit official multithreaded contender supplies the machine-wide large-message comparison. Samples use v7's every-sample rule. No earlier v6 observations were converted or mixed into this record.

## Files and limits

Raw samples, printed results and chart are from the run. The map was regenerated with the same pinned executable in a directory containing only these library samples. SHA-256 and BLAKE3 manifests cover those four artifacts and were both verified after transfer.

The separate released-CLI run reported busy windows (26 of 432) and is retained on the measurement server. It is withheld here as clean performance evidence. Consequently this record supplies no new files/CLI overview cell; older CLI samples should not be filled in silently. Sam's separate candidate-vs-baseline CLI comparisons are a different experiment.

Read and render with the compatible v7 tools; timing was performed with the exact pins above. Server work was serialized and no native work ran on the potentially shared local i7.
