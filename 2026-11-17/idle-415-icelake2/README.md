# Repeat of the Ice Lake idle 1536 B mark (BLAKE3 #415)

November 17, 2026. Devon Jonte. `x86-icelake-2`, four arms by name, `idle 1536 B`, bench-hashes 0.23. The first two arms are the reported pair `70483031` → `9de026af`, with a same-library control between them; the release arm is 0.9.0 → `next` `a12a4d35`.

All four checks exited 0, `no cell slower`. The first-stage comparisons:

| arm | st | mt |
|---|---|---|
| pair | ×1.019 level | ×1.031 level |
| control | no marked cell | no marked cell |
| pair-again | ×1.052 level | ×1.055 level |
| release | ×0.969 level | ×0.939 level |

The +4.5% mark did not repeat. **The job's header incorrectly said the two commits differ only by #403's fix; they differ in 11 library source files.** This archive preserves the original job and outputs. No binaries.
