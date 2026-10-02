# Linux optimization: eight-hour plan

Decision committed before new measurements, October 2, 2026, starting about
04:08 UTC; finish or checkpoint by 12:08 UTC. The user explicitly authorizes
independent ownership of Devon's Linux forks, relaxation when the original
acceptance procedure cannot finish, and immediate optimization under a frozen
instrument. No external approval is a prerequisite for this branch.

## Claim and changed requirements

The original reliance procedure remains at bench-hashes-trust commit c05a253,
`audit/reliability-assessment.md`. It has not passed. Another operator's
reproduction and outstanding external reviews cannot be assured within this
window. This plan permits **provisional Linux optimization**, not general
benchmark endorsement, a retroactive pass, or an upstream release.

Keep independently anchored cryptographic correctness, exact raw time/work,
source/artifact provenance, quiet-load qualification, shared clocks and Rust
speed rules. Replace the 66-null/60-positive/12-block acceptance campaign and
external-review prerequisites with bounded change-specific experiments:

- Freeze benchmark runtime after the known missing-load compare fix. Hashing
  changes never change this instrument. Preserve binaries and SHA-256 manifests.
- Use default generic Rust builds on this i7-12700K Linux host. Compare actual
  frozen production workloads and supplementary batch workloads separately.
- For each candidate, fresh ABBA on CPU0 and CPU16 where the caller is serial,
  plus default placement for production queue/shared/incremental workloads.
  Compare old/new and each side's repeat through the same Rust reader.
- Run the stock regression check as a diagnostic, preserving its outcome;
  it is not a calibrated acceptance guarantee. A zero exit cannot erase a
  measured slowdown, an abstention, or a missed per-cell effect.
- First target a substantial streaming/batch gain (at least 10% wall-time in
  both repetitions, larger than same-side variation); preserve all cells,
  speed states and shares. Smaller/unstable changes remain experiments.
- Busy/unobserved results are descriptive only. Preserve every planned
  attempt; no favorable retries. A failed experiment requires a new plan.
- Default/pure/no_sme2 library/API tests, published vectors, documentation
  tests and relevant boundary/mode/alignment/sentinel/concurrency tests must
  pass before publication as a correctness-tested candidate. No expected
  digest regeneration. No cryptographic contract or security relaxation.
- Record every plausible slowdown with scope and magnitude. Broad costs
  remain open until controlled or explained; never claim no regression from
  a favorable target probe. Linux-only publication; ARM/Mac remain untested.

## Instrument and implementation sequence

1. Minimal shared load predicate: compare and regress require quiet evidence;
   fixture tests plus replay the retained short samples. No detector retuning.
2. Retain the shared clocks backend from BLAKE3 1fd5691, including the busy-tail
   safeguard and fixed-call timing. Limit counter evidence to fresh exec,
   native 64-bit x86 ABI on this host; unsupported counters are explicitly
   unavailable. Resolve ABI gating before freezing; no fork-without-exec claim.
3. Freeze exact source and build artifacts, record baseline tests and a fresh
   production identical-artifact diagnostic. Preserve failed controls.
4. Review x86 batch dispatch first: whole-block messages currently use a
   four-lane NEON arrangement even when x86 offers eight/sixteen SIMD lanes.
   Test letting the existing platform kernel consume the full batch on x86;
   retain ARM arrangement. Supplementary lengths do not alter frozen axes.
5. Compare, test and publish supported candidates to Devon's branches. Assess
   the already-published two-chunk optimization independently if time permits.

All potentially hanging commands run under the existing bounded process-group
supervisor. Builds/tests have finite deadlines; individual measurements at
most 180 seconds, regression checks at most 600 seconds. Collection remains
process plumbing; only Rust reads samples and computes speeds. Historical
worktrees and evidence remain unchanged.
