# Linux batch optimization evidence

**Provisional optimization evidence, October 2, 2026.** The user authorizes
Devon's Linux fork to optimize under a frozen, change-specific instrument.
The original reliance acceptance procedure remains unpassed. These results
support targeted batch improvements and preserve open queue/context costs.

## What improves

| Change | Measured useful scope | Wall-time result |
|---|---|---|
| Corrected x86 tail dispatch | Six 128–1024-byte messages, CPU0 direct caller | About 30% less time |
| Corrected x86 tail dispatch | Same six-message batches, expanded lent st/mt, solo/shared | About 27–30% less time |
| Two-chunk SIMD batching | 8/16/64 messages of 2048 bytes, CPU0 direct caller | About 53% less time, roughly 2.1x throughput |
| Two-chunk SIMD batching | Same 2048-byte batches, CPU16 direct caller | About 44% less time, roughly 1.8x throughput |
| Two-chunk SIMD batching | 16 messages, expanded lent producer/digest handling, st/mt and solo/shared | About 51% less time |

Tail gains on CPU16 are about9–12%; they support no blanket10% claim.
The two-chunk queue's fast speeds improve in selected cells, but slow states
and state shares change. The queued4096-byte cells also show costs described
below. Read each corresponding speed and its share, rather than a lone pooled
median or stock detector exit.

## Frozen instruments and exact source

- Original comparison runtime: benchmark2824fd0; retained artifacts outside
  the working targets. Includes the shared quiet-load predicate for compare
  and regress. Short-record replay is in `logs/short-replay.txt`.
- Expanded runtime: **6047dcd**, version **0.10.0-devon.linux.1**.
  `batches` adds lengths64/128/256/512/1024/2048/4096; default counts3/6/8/16/64/129;
  existing lent synchronous and owned queue adapters, solo and two-copy shared.
  Producer writes and digest handling are timed. Calibration and independent
  digest tests stay outside timed samples. Unlike lengths have different keys.
- Shared clocks: Linux baseline2a2cb9c, with the earlier busy-tail safeguard,
  fixed-call helper, and optional Linux hybrid PMUs restricted to native64-bit
  ABI. Cycles/instructions are user-space only; PMU running time includes
  kernel execution. Wall time is unscaled. Fresh exec is the counter-cache
  scope; fork without exec remains outside this experimental backend's claim.
- `sources.json` separates synthetic measured commits from published commits.
  `artifacts.json` in each stage identifies every retained executable by SHA-256.
  Local retained binaries are under `bench-hashes-validation/linux-excellence/`;
  target directories are build caches, not evidence identities.

The corrected tail measured94fd358; published54a0312 changes only test feature
handling relative to that runtime. Two-chunk measurements use83cc5e4;
publication918722b adds truthful kernel reporting and documentation, then passes
a separate stock diagnostic. Its ABBA precedes that metadata addition; no claim
that those artifacts measured the later binary's layout.

## Experiments and failures retained

Every stage has12 fresh runs: CPU0 supplementary ABBA, CPU16 supplementary
ABBA, and default-placement production/expanded ABBA. The `.txt` comparisons
come directly from the frozen Rust reader and shared speed rule, including
each side against itself and both corresponding old/new pairs.

- **failed-tail/**: giving every tail to the platform removes the padded fourth
  lane for three messages, costing CPU0 about31–50% at128–1024 B. Reject this
  implementation. Its production ABBA covers the original full roster,
  including after-gap cells; unchanged SHA-256 also changes speed/state mix.
- **corrected-tail/**: retains triples, delegates other x86 tails. Full-width
  groups were already passed to the platform; the benefit is better tails,
  not a previously unused SIMD width. Six-message lent gains reproduce.
- **two-chunk/**: batches first chunks at counter0, second chunks at counter1,
  then each message's own parent root. No new unsafe code. Preserves smaller,
  empty, other-length, other-architecture and all-mode contracts.
- **fresh-null/**: one original-instrument identical-artifact whole diagnostic
  returns0 after an initial flag fails confirmation. This is operational
  evidence, not calibrated reliability or an acceptance null campaign.

**Open costs:** two-chunk expanded4096-byte queued batches have pooled fast
slowdowns up to about25%; same-code old repeats include about11–13% movement
at64 messages. Some new slow states are slower and some shares change.
Neither a passing14-point diagnostic nor target gains erase these findings.
Thread placement, scheduling and code layout are hypotheses, not established
causes. Keep queue costs open until controlled or sufficiently explained;
there is no broad no-regression claim.

## Correctness and raw accounting

- Benchmark fixtures:27 tests pass, including adapter digest boundaries,
  same-total-bytes/unlike-length queue-cache separation, exact time/work
  readback, and quiet-load predicate. The first local-path build violates
  the existing enclosing-fork contract; retained failure precedes the valid
  topology build. No measurement follows a failed build.
- Corrected tail: default/pure/no_sme2 each78 library +15 API +one isolated
  one-CPU +one allocation test pass. Pure initially fails AVX512 test gating;
  the test-only correction passes. Both logs are retained.
- Two-chunk: default/pure/no_sme2 each79 library +15 API +one isolated one-CPU
  +one allocation test pass; published vectors2 and doctests22 pass.
- Independent reference covers all64 byte alignments, portable and available
  SSE2/SSE4.1/AVX2/AVX512 implementations, counts through255, modes and
  neighbouring lengths2047/2049. Output sentinels detect an extra store.
- Fixed published2048-byte hash/keyed/derive-key anchors directly exercise
  the batched tree and pass Miri on the portable implementation.
- Postcollection test-only Rust audit reuses **unchanged production
  `read_samples`** and checks every raw ns/units pair against separate traces:
  **24 files /170112 measured batches pass** across corrected/two-chunk stages.
  Its source is `linux_trace_audit.rs`; measured instrument sources stay
  unchanged. Timing/statistics/sample parsing have no Python twin.

Logs contain the deliberate handler-panic test's stderr; its subprocess abort
is expected and the API suite passes. LinuxPMU counts cover calling threads,
not aggregate worker energy or power. ARM/macOS are untested by this work.

## Reproduce

Use the exact source IDs above, a generic Rust build, the committed plans
`audit/linux-optimization-plan.md` and `audit/expanded-batches-plan.md`, and
bounded process-group supervision. Each stage's `collect-abba.py` records
its executable hashes, commands, outcomes and original raw paths; adapt only
those paths to your checkout. `bench-hashes compare OLD... -- NEW...` computes
all summaries. Read historical records with the source-matched Rust reader.

Publication branches: `devonjonte/bench-hashes` and `devonjonte/BLAKE3`, both
`candidate/devon-linux-excellence`. This is Devon's independently versioned
Linux research line; it makes no upstream release or freeze-adoption claim.
