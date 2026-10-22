# Benchmark Mean bypasses the declared trim — October 22, 2026

## Question and verdict

Do the report and comparison summarize the original samples through the
same slowest-hundredth rule as the map?

**The original Mean wrapper bypasses the selection.** `Mean::of` first sums
all nanoseconds and units. Its `fixed()` then calls the shared mean on
that single aggregate. The map calls the rule on the original samples.

The independent fixture has 99 samples at 1000 ns and one at 1,000,000 ns,
each one unit. The declared rule returns **1000 ns**. The original wrapper
returns **10990 ns**. The regression fixture fails on the original source
and passes with the proposed repair.

This is a source-correctness check using fixed inputs. It supplies no
hardware-speed measurement or reliability acceptance verdict. Historical
raw timing samples remain useful; their original verdicts describe the
implemented plain mean. Any corrected-rule reanalysis has its own record.

## Source and reproduction

- Original benchmark main: `7cee59d0c746ed72cc609d7103fc9676640c1dae`.
- [Deliberately failing fixture](https://github.com/devonjonte/bench-hashes/tree/evidence/devon-mean-trim-repro):
  `8c0ade0a263da3812bc151d6d4c9b8a2b70479a6`; `reproduction.patch` preserves it.
- Shared helper: BLAKE3 `99d34d94db14eac01a9c652e0a4858055502b08f`,
  [Expose exact totals selected by the shared mean rule](https://github.com/johnservil/BLAKE3/pull/127).
- Consumer repair: benchmark `4ceee0dc53cb89d3a8bfdd9b8a3276358ff52f32`,
  branch `candidate/devon-mean-trim`. It keeps the existing Mean and
  formatter and calls `mean_totals` before aggregating. Its clocks pin
  names the helper; its contender pin stays unchanged. Build-against,
  relinking and coverage keep that instrument pin on both sides.
- [Consumer repair PR](https://github.com/johnservil/bench-hashes/pull/60),
  tip `3926a57d0c5fe3190be734ab6ad54a00b5b3db40`, also carries
  the separately reviewed relink-provenance fix. `build-against` builds
  old contender `c40892d2b426bf3c169fbe7bac3ab8ed0bcfd36b` successfully.
  Its copied `old-contender.Cargo.lock` retains git-pinned clocks `99d34d94`.

On the failing fixture's source, run:

```sh
cargo nextest run --release mean_keeps_the_shared_slowest_hundredth_rule
```

The shared helper returns the exact retained pair `(99000, 99)` and its
fixed-point projection returns `1000 << 64`. Its **32 clocks tests pass,
2 ignored probes skipped** (PMU pinning and load-reader cost). The proposed benchmark repair's **31 tests pass** with the
git-pinned helper. The logs also retain the deliberate red run. The
existing two-sample decimal fixture's expectation changes explicitly
from 5.000 to 2.500: the declared rule keeps its faster 1000 ns/400-unit
sample. A separate exact 1000 ns/unit anchor crosses samples-file readback.

## Review boundary

Reported at [Apply the shared slowest-hundredth rule before Mean preaggregation](https://github.com/johnservil/bench-hashes/issues/59).
The benchmark repair remains a proposal: FROZEN assigns this bug fix,
its new release, and the decision to Zooko. Fresh end-to-end controls
remain open. The repair preserves `ceil(n/100)`: at the check's budgets
of 6 and 24 samples it removes one sample, respectively one-sixth and
one-twenty-fourth. Controls must exercise those actual budgets.
