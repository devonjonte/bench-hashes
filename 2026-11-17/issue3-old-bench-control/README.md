# Small-call controls across two benchmark versions

November 17, 2026. Devon Jonte. For [bench-hashes #3](https://github.com/devonjonte/bench-hashes/issues/3).

## Corrected interpretation

The controls establish sensitivity to the benchmark's build and run context. The mechanism remains open. The earlier claim that these controls isolate code placement, or clear the release regressions, exceeded the evidence. Corrections: [investigation](https://github.com/devonjonte/bench-hashes/issues/3#issuecomment-6960418528), [release decision](https://github.com/servil-software-factory/BLAKE3/issues/402#issuecomment-6960429511).

The original measurements remain below and in their files. Earlier interpretations remain in git history, including `caf7efa26dc50a14dfc35faa74139d51d1dcabc4`.

## Question and command

The 0.10.0 release check compares candidate `27eacce3a5c2e03043f4fcd347c178a80f9d911c` with 0.9.0 using an older benchmark. How much can the benchmark change move the same library?

The controls hold that candidate library on both sides and compare benchmark `d7723f110a6f519cccb2e4ab8f2a18be7a4f4d41` with `cade30fdb71682719f5fa3e586ff96146ae9fc25`:

```sh
bench-hashes check --fork LIBRARY --new 27eacce3a5c2e03043f4fcd347c178a80f9d911c \
  --against 27eacce3a5c2e03043f4fcd347c178a80f9d911c \
  --old-bench d7723f110a6f519cccb2e4ab8f2a18be7a4f4d41 \
  --points 'idle 64 B,idle 128 B,idle 256 B,64 B,128 B' --when-quiet --keep KEPT
```

Each folder's `run.sh` and logs give its exact command. The second stage uses 16 layouts per side, repeated four times: 64 process pairs.

| machine | judged slower cells in the second stage |
|---|---|
| EPYC 7443 pair (`x86-avx2`) | st OneMessage 128 B +29.2% |
| Ryzen 9700X | mt OneMessage 64 B +7.5%, 128 B +8.0% |
| EPYC 9255 | mt OneMessage 64 B +5.9%, 128 B +4.1% |
| Xeon Gold 6330 (`x86-icelake-2`) | none |

These are same-library comparisons between instruments. Library-release comparisons require their own evidence. Every control reported no instruction-count increase above 0.5% in its **level cells**; that diagnostic alone does not isolate a timing mechanism.

## Supplementary results and their scope

**Tailored controls.** Ryzen 9700X `ManyMessages 1` and `Collection git objects`, and Xeon `MerkleTree 1048576 x 16 B` and `ManyMessages 8192`, read level or faster over four pairs. These selected-cell controls leave the original release findings unresolved. A level verdict means insufficient evidence in that run's workload context.

**One benchmark, two library releases.** `x86-avx2/onebench/` compares candidate with 0.9.0 under benchmark `97c0fbcbedb8fe8f8395115647684dfde75d67a3` (the 0.22 version commit). The second stage measured mt OneMessage 64 B **+13.6% slower**. That cost remains open. Faster 128 B results provide adjacent-cell context; they do not identify the 64 B cost's cause.

**Allocator experiment has different libraries.** The logs in `x86-epyc-9255/diag-pinned/` identify old-side library `bf2da8b957f5e0c80babb57952de3e53f95c921a` and new-side library `7048303103c69b8609ffe9ca0361197ba318107c`. The job's claim to hold candidate `27eacce3` on both sides was wrong. Its medians cannot isolate buffer placement from the library and benchmark differences. The unpinned attempt is retained too. Six executables accidentally entered the earlier archive; their recorded hashes are now in `REMOVED-BINARIES.tsv`, and the archive keeps the text evidence alone.

## Withdrawn mechanism claims

- The alleged layout states also differed in CPU/socket placement. They do not establish a code-address effect.
- `check::each_run` cycles through all 16 layouts four times. Grouping four consecutive accepted runs as one layout was wrong. Layout index `i` takes runs `i`, `i+16`, `i+32`, and `i+48` in each side's accepted-run list.
- Later checks replaced executables in `target/check/`. Their addresses cannot be joined to earlier timings without a matching executable identity. The attempted address correlations are invalid.
- The later experimental v11 counter used `(PERF_TYPE_HW_CACHE, 0x10000)`. Linux defines that as **L1D read misses**; L1I read misses use `0x10001`. Its readings provide no instruction-cache attribution.
- Even a valid unchanged miss count would leave miss latency open. A counter needs a reproduced timing state and controls that establish what it counts.

Using one benchmark for shared API cells removes one known source difference. The one-benchmark result above shows why it remains a diagnostic step rather than a demonstrated cure. The next experiment crosses snapshotted executables with fixed CPUs, holding calibration and workload constant. Devon owns the investigation; John owns the release decision.

Folders hold samples and logs with home paths redacted. Both manifests cover every current file except the manifests themselves. No binaries remain.
