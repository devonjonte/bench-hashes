# Two benches read the same library apart on small one-message cells (bench-hashes #3)

November 17, 2026. Devon Jonte. For [bench-hashes #3](https://github.com/devonjonte/bench-hashes/issues/3).

**Question.** The 0.10.0 release check compares the candidate with 0.9.0 through two bench versions (`--old-bench d7723f11`). How much of its small-cell marks is the bench difference alone?

**Control.** The candidate library `27eacce3` on both sides; bench 0.22 (`d7723f11`) against bench 0.23 (`cade30fd`); points `idle 64 B, idle 128 B, idle 256 B, 64 B, 128 B`. Any slower or faster mark is the instruments', because the library code is identical.

| machine | check verdict | second stage (64 pairs) |
|---|---|---|
| EPYC 7443 pair (x86-avx2) | REGRESSION: 1 slower | st OneMessage 128 B +29.2% slower; four other suspects faster |
| Ryzen 9700X | REGRESSION: 2 slower | mt OneMessage 64 B +7.5%, 128 B +8.0% |
| EPYC 9255 | REGRESSION: 2 slower | mt OneMessage 64 B +5.9%, 128 B +4.1%; st level |
| Xeon Gold 6330 (x86-icelake-2) | no cell slower | — |

First stage on the EPYC 9255 read st OneMessage 64 B ×1.239 and mt ×1.130 over four pairs. On every machine the check reported **no level cell's instructions moved beyond +0.5%**: the same work retires, and the wall time moves.

**Tailored controls** (the same control at the other machines' reported marks): Ryzen 9700X `ManyMessages 1` and `Collection git objects`, and Xeon `MerkleTree 1048576 x 16 B` and `ManyMessages 8192`, all read level or faster over four pairs, with no cell slower. Those release marks do not survive this control.

**Cause.** Between the two benches, the OneMessage call, its sample preparation, and the after-other-work gap are unchanged. What changed is the bench binary around them (the Pipeline and short-incremental cells, bench-hashes #213/#214; the perf-group narrowing, #229). The marks sit in cells whose call takes a few nanoseconds after other work, where the instrument's own code and buffer placement and the cache state it leaves are a large share of the reading. Both directions occur (+29% slower on one machine, faster marks beside it), as placement effects do.

**Recommendation.** Judge the cells both releases share with one bench on both sides: the old bench builds both libraries (the candidate side of these controls is that proof). Leave the new-API cells to the current bench, with no 0.9.0 comparison. Keep a same-library two-bench control as a diagnostic of the instrument, not as a per-cell divisor: its pairs are fresh layouts and processes, so dividing a release mark by it would add the control's variance to the mark.

Each machine folder holds the job, stdout/stderr, versions, and kept samples (first stage and `second/`). Paths are redacted. No binaries.

## Addendum: which placement carries it, and the one-bench check

**Allocator experiment** (EPYC 9255, st OneMessage 64 B, 12 processes each pinned to CPU 0; `diag-pinned/`): with every allocation of 64 bytes or more on a 64-byte boundary, the benches read 3.59 (old) and 3.82 (new) ns/B; at a 48-byte line offset, 3.45 and 3.75; default, 3.67 and 3.98. Buffer placement moves both benches by a few percent and does not close the gap. (`diag-unpinned/` is the same exes unpinned: placement noise swamps it, kept as the control that shows why the pin matters.)

**Per-layout cycles** (kept second stages): at constant instructions (14.5/B) and constant LLC misses, layouts fall in two cycle states, about 24 and about 35 cycles/B. Only the bench executable's link layout differs between those runs.

**One bench on both sides** (EPYC 7443 pair, bench 0.22 for candidate against 0.9.0, `x86-avx2/onebench/`): no cell slower at the first stage; the second stage convicted one, mt OneMessage 64 B +13.6%, while mt OneMessage 128 B read faster (×0.882) and mt IdleOneMessage 128 B faster (×0.880). A fixed per-call cost cannot change sign between 64 B and 128 B; this last mark is a layout draw between two different library builds, of the same kind the controls measure.

**Conclusion.** The carrier is the bench executable's code placement (function order and alignment, which the relink layouts randomize), acting on a call that takes a few nanoseconds after other work with its code cold. Buffer placement is a smaller, independent sensitivity. Neither is the library's code, which the controls hold identical.
