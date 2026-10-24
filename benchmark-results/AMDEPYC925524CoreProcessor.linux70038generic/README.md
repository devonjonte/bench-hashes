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

The library's raw samples, printed results and chart are unchanged from the record above. The map was redrawn with the same pinned executable (`bench-hashes map`) from the library samples and the b3sum samples below. SHA-256 and BLAKE3 manifests cover all seven artifacts and were verified after transfer.

## b3sum, sha256sum, sha1sum, md5sum (October 24, 2026, 15:07 UTC)

`b3sum.result.txt`, `b3sum.samples.tsv` and `b3sum.chart.svg` come from a fresh CLI run: the released benchmark (ae63011, 0.17.0), with one change to its instrument, described below.

```sh
LAYOUTS=4 python3 tools/b3sum-contenders.py BLAKE3-at-082afa3 bin 082afa368f37c050238c0c9a708348f1940aff51 |
    tr '\n' '\0' | xargs -0 bench-hashes b3sum --files /root/results/b3sum-files-v7
```

The contenders:
- official b3sum 1.8.2 from crates.io;
- servil 082afa3's b3sum, statically linked as its README recommends, and the same build with `--num-threads 1`;
- four relinked layouts of each b3sum, as on Devon's i7 run;
- the system's `sha256sum`, `sha1sum` and `md5sum` (uutils coreutils 0.10.0, Ubuntu 26.04).

The run had 15 rounds, warm and cold. The files were made by an earlier run. Nothing else of mine ran on the server.

**Load: quiet, 0.00 CPUs on average, 0.31 in the busiest window.** The run's clocks are the bench's pin 7f9f1f7 plus [johnservil/BLAKE3#142](https://github.com/johnservil/BLAKE3/pull/142) (a240274; its later commits change tests only). That change makes the load windows count other programs from their own CPU time on Linux.

With the pinned clocks unchanged, the same run read busy in 16 of 403 windows, about 1 CPU for 1 s each, with no other program running. Every window I checked overlapped the official b3sum's "1000 x 16 KiB, a process each" cell, and the time was the kernel's work on behalf of that contender's own processes, charged to no process (#142 has the breakdown). Timings are unaffected: the change only labels windows.

The override was `--config 'patch."https://github.com/devonjonte/BLAKE3".clocks.path=…'`, which drops the clocks source line from Cargo.lock. So the samples header reads "git clean status: clean", but its dependency-lock fingerprint is 76467d9… rather than the release's 08170e2…. The October 23 CLI run (26 of 432 busy, old clocks) stays withheld.

Read and render with the compatible v7 tools; timing was performed with the exact pins above. Server work was serialized and no native work ran on the potentially shared local i7.
