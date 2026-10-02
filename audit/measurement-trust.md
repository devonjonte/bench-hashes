# Measurement-trust re-audit: review ledger and validation plan

For maintainers reviewing whether bench-hashes supports performance decisions.
Baseline: benchmark **ee3b85a**, fork **8825450** (hashing), with each
experiment recording the actual clocks source separately. This is a review
plan with preliminary findings, rather than a completed validation verdict.
The user asks for measurement validation and John Servil's review before
acting on performance results. Further contender optimization and the broad
batch-axis extension are paused. The existing BLAKE3 proposal stays draft.

## Current upstream review — October 2, 2026

John supplied [itemized T1–T8 assessment](https://github.com/johnservil/bench-hashes/issues/4#issuecomment-5942866515)
and requested current-candidate x86 controls. Bench candidate67f5300 / fork
d31a46c introduce material changes; earlier source-specific evidence stays intact.

| Claim | John's current assessment/change | Independent status |
|---|---|---|
| T1 scheduling | Adopted actual-participant balanced Williams/full visits | Earlier controls support adopted design; current-source checks due |
| T2 uncertainty | Confirmed correlation; removed intervals/bands/~ and bootstraps | Removal addresses advertised interval claims; presentation/source review due |
| T3 consistency | Findings need explanations; fast differences >10% | Conditional premises and fast-only scope need review |
| T4 labels | Our PR3 cherry-picked0c615e9; provenance narrowed321722a | Incorporated, PR closed; current rendered output review due |
| T5 accounting | Rust reader/readback test replaces Python twins | Adapt controls to shared Rust; independently observed work still relevant |
| T6 gate | Prior slow/gap false flags acknowledged;16 clean self-compares reported | NEW fast-median Rust detector calibration pending |
| T7 load | Fixed context/no-window/single-tail implemented3a29cb8; our PRs superseded | Busy-tail dilution independently reproduced; focused safeguard f82d46c |
| T8 caller | Welcomes clocks/shared-tool probes | Historical q5 caller sensitivity retains old-source scope |

`bench-hashes regress` now owns decisions and uses fast-speed medians;
`perf_regress.py` builds/delegates. Python readers/twins are removed. The new
rule needs fresh calibration; John explicitly records calibration to follow.
[Busy-tail evidence](results/current-rust-gate/README.md) preserves two failed
counter fixtures and a minimal correction. Upstream incorporation and removal
of unsupported claims improve readiness; they do not supply a GO verdict.

## Historical review checkpoint — October 1, 2026, 16:11 UTC API check

The issue bodies/comments and both PRs' reviews/inline comments were checked.
John has supplied no new response on bench issue#4/PR#3 or BLAKE3 PR#3/issue#4.
The initial source-plan ledger below remains historical context; the links here
record subsequent evidence. Pending review stays pending.

| Claim | Existing maintainer assessment | New evidence / pending assessment |
|---|---|---|
| T1 scheduling/carryover | Original design defects confirmed and fixed | Seven runtime traces balanced; selected-context costs remain open |
| T2 shared uncertainty | Copy correlation confirmed; round grouping proposed | Coverage controls show flattened undercoverage; grouped/serial/split estimand review pending |
| T3 consistency | Boundary exceptions acknowledged | Correct SMT-contended SHA-256 counterexample; universal premise review pending |
| T4 kernel labels | One-shot inheritance marked for checking | bench PR#3 has no review; API-specific unreported schedule proposal pending |
| T5 accounting | Reporting/allocation defects confirmed and fixed | Raw reader/anchors/traces extend scope; BLAKE3 PR#3 has no review |
| T6 null/gate/context | Earlier variability acknowledged in NOTES | Actual identical-artifact solo hold; narrow-context dismissal control; review pending |
| T7 load/provenance | Stale untracked fingerprint acknowledged | Missing-window verdict reproduced; focused guard proposed; BLAKE3 issue#4 has no response |
| T8 direct caller | No requested confirmation yet | Observed extra-work control near2x; first stage lacks load and remains failed coverage |

The focused load guard is [BLAKE3 PR#5](https://github.com/johnservil/BLAKE3/pull/5),
building on reader PR#3. It supplies exit2 on missing initial/confirmation
windows; obtaining adequate narrowed-process coverage remains open.

- [Committed go/no-go decision procedure](reliability-assessment.md)
- [Supporting effect-resolution profile and baseline metric](reliability-profile.md)
- [Current-source fixed-context and actual-work gate controls](results/fixed-context/README.md)
- [Final-window coverage, failed snapshot design and stronger abstention controls](results/final-load-coverage/README.md)
- [Near-margin calibration and per-size held-out sensitivity failures](results/near-margin/README.md)
- [Historical adaptive gate null pilot](results/live-gate/README.md)
- [Deterministic gate contracts, including narrowing](results/gate-contract/README.md)
- [Recorded runtime accounting](runtime-accounting.md)
- [Paired uncertainty](results/paired-ci/README.md),
  [context sensitivity](results/context-sensitivity/README.md),
  [SMT premises](results/smt-consistency/README.md)

### Subsequent source review and controls

Fetched fork6afda66 / bench663b035. John's52b0418 removes the pooled slow-speed
verdict and restricts the gate to14 nonstop points. His NOTES independently
reports identical-artifact slow-rule false decisions; this supports T6's
premise, while the omitted slow/after-gap claims stay outside gate coverage.
Direct issue/PR replies were still absent at the17:24UTC check.

The fixed-context candidate retains selected neighbors through pairs and
confirmation. Two live fixed null checks pass with windows in every process;
one adaptive check uses eight processes without windows. Actual doubled-work
caller controls hold three cells near2x, with exact completions/raw accounting.
These are pilots, not the acceptance campaign. Recorded-start coverage also
exposes uncovered tails despite quiet windows, so T7 remains open. Details,
failed-before tests and every process are preserved in the linked record.

The subsequent shared-load candidate3a240a0 observes short final tails over
an existing sufficiently long quiet interval, preserves busy findings, and
seals each extension so frequent snapshots cannot hide bursts. That last defect
was reproduced in the first prototype and its failed control is retained.
The stronger shared-reader/gate policy rejects uncovered recorded starts,
including confirmation. Corrected-source nulls and2x callers have zero
uncovered starts; short processes and externally busy controls remain exit2.
All66 prototype/follow-up processes,22 report checks and264 direct accounting
cells are retained. These are diagnostic comparisons across two instruments,
not the finite acceptance campaign. Millisecond starts still cannot certify
full timed intervals; T2–T8 closure and independent review remain outstanding.

Predeclared near-margin work controls separately calibrate timing shifts
~3%/~6%, with all work accounted. Held-out actual-gate3% confirmations are0/8
at every size. At6%,64/2048 B confirm8/8;102400 B confirms4/8 despite all eight
whole comparisons returning exit1. Single below-margin pairs suppress bulk
findings. These diagnostic failures keep both3% and blanket6% NO-GO; the two
small direct-caller cases motivate a fresh narrow scope, not retroactive rescue.

Confirmations retain their original scope. No new refutations or acceptance
responses were received at this check; experimental counterexamples are our
findings awaiting John's assessment, rather than attributed responses.

## Evidence already reviewed

John's [PR #2 response](https://github.com/johnservil/bench-hashes/pull/2#issuecomment-5924871773)
confirms the earlier listed defects, incorporates the three harness commits
with authorship, and describes the remaining items individually. In
particular, it confirms the shared-copies bootstrap issue and the remedy's
ownership in the shared rules. His one-CPU fix is BLAKE3 **2cc0c00**.
These confirmations have the scope of that response; they do not establish
that all measurements are reliable. [PR #3](https://github.com/johnservil/bench-hashes/pull/3)
proposes API-specific labels with unreported internal schedules and awaits
review. [BLAKE3 PR #1](https://github.com/johnservil/BLAKE3/pull/1) contains
provisional optimization evidence and remains draft.

## Claim ledger

For each ID, review can confirm, refute, narrow, or request further evidence.
A source inspection, a unit test, a runtime control and a maintainer response
are separate forms of evidence; the ledger preserves each one's scope.

### T1 — Realized order balance is repaired; carryover validation remains

`participating_orders`, `cell_wants_sample`, and
`harness_tests::sampled_visits_complete_the_participating_williams_design`
cover complete default cycles over participating contenders. Explicit round
counts can leave a partial cycle. John confirmed the original long-cell and
filtered-design defects and incorporated the fix (ddce746/ee3b85a).

Open: the tests simulate the sampling selector. A runtime trace must check
actual dispatch order, counts and predecessors against it. Williams balance
addresses positions and immediate predecessors within its design; phase
history, point rotation, calibration, longer carryover and unequal-duration
workloads can still matter. An empirical order/neighbor sensitivity test is
needed before claiming those effects are controlled.

### T2 — Shared bootstrap treats concurrent copies as independent

`clocks/src/speeds.rs::bootstrap_median_interval` resamples individual sorted
values; `speeds` applies it to each selected speed. The shared observations
come two per visit. Correlation can make the displayed interval too narrow.
John explicitly confirmed this item and recommended resampling rounds with
both copies together. Existing METHODOLOGY states the limitation.

Open: shared interval repair and its coverage validation. Any repair belongs
in clocks and its Python twin with common vectors. Group identity must survive
sorting and speed classification; a within-visit clustering remedy also needs
a decision about serial dependence across visits and split-selection
uncertainty. Treat these as separate questions. Solo serial independence also
needs assessment. Current bands are excluded from acceptance arguments.

### T3 — Consistency relations are useful diagnostics with conditional premises

`src/main.rs::consistency` checks four relations and emits "relations that
hold for every contender when the benchmark measures what it means to".
METHODOLOGY allows a finding to be explained; John's audit response and NOTES
acknowledge nonmonotonic performance at block/SIMD/tree/wake boundaries.

The inequalities alone do not identify a defect: extra helper wakeup,
frequency/topology, contention or timed read overhead can change the relation.
Open: state each premise explicitly, establish counterexamples with unchanged
correct implementations, and revise classifications/wording with review.
Separate exact accounting invariants from performance expectations. Shared
interval limitations also affect checks using those intervals.

### T4 — Queue/incremental labels need API fidelity and schedule uncertainty

The original labels inferred queue/incremental paths from one-shot reports;
John's NOTES marks this for checking. PR #3 labels Queue::messages,
Queue::pieces above PIECE_LEN, Queue::fixed and update_multithreaded, and
leaves their internal schedules unreported. Its 23 Rust tests and a default
quick run's report/graph/guide checks pass.

Open: John's PR review, all metadata consumers, and the boundary between a
reported dispatcher and the actual fallback kernel used for a short/tail
call. Labels describe available information; they provide no execution trace.

### T5 — Internal report agreement validates reporting, with limited scope

The checker now rejects missing/duplicate sampled cells and verifies every
reported value using the shared samples reader and speed rules. John
confirmed and incorporated the fix. Retained full/default quick reports pass.

Open: independent fixed arithmetic anchors, cross-language rule parity,
input/unit/count accounting, and actual completion/digest observation. A
report matching its samples can faithfully report a systematically biased
measurement. Correctness audit tests belong outside timed benchmark runs;
production benchmark calls and the frozen workload remain unchanged.

### T6 — Repeat and layout controls show sensitivity, with causality open

The public [dispatcher record](https://github.com/devonjonte/BLAKE3/blob/candidate/devon-x86-assurance/devon-results/two-chunk-dispatch/README.md)
retains a 35-point 48-round block: queue batch4096 candidate fast ratio 1.126,
new/new ratio 0.834; lent 1 MiB MT candidate 1.121, old/old 1.196. Separate
identical-source builds and affinity controls also vary. These are observations
from the retained instrument, pending its validation. They establish neither
an intrinsic regression nor an environmental explanation.

Open: exact-artifact null controls, separated from identical-source/different-
artifact controls; order, neighboring workload and affinity experiments; and
comparison-tool false verdict behavior. Define tolerances, repetitions and
failure handling before running. Preserve disagreements and adaptive
confirmation rounds rather than selecting favorable repeats.

### T7 — Quiet load reports and provenance each have bounded meaning

clocks reports OS-visible other load, not all relevant machine state. Linux
thread-cycle fields are unavailable. A quiet verdict does not establish
constant frequency, topology, instruction-cache state or host availability.
John confirmed a stale provenance-cache possibility for untracked files;
source and measured dependency names alone also need actual patch verification
(NOTES documents the earlier clocks-patch confound).

Open: record executable hashes, exact source/build flags, clocks source,
affinity, power information and input shape. Test build-script invalidation.
Keep a diagnostic artifact manifest outside published historical results.

### T8 — Stable target repeats are provisional workload-specific evidence

The independent-message 2048-byte probe uses clocks and shared rules and
shows stable pinned repeats with a plausible SIMD occupancy explanation.
Reference/vector/sanitizer/Miri checks support hashing correctness at their
stated scopes. Measurement trust still needs the accounting and controls
above. Those checks do not independently validate the performance estimate.

Open: corroborate selected calls with a smaller direct caller through the
same clocks implementation, inspect generated code and accounted work, and
contrast it with the full harness while changing one factor at a time.
Preserve honest differences in producer, gap, batching and completion scope.

## Experiments before further optimization

1. **Static and runtime accounting.** Trace dispatched use case, participant,
   point, order and visit in a diagnostic sidecar outside timed regions.
   Compare the trace with the schedule contract. Audit calibration, preparation,
   submitted/completed inputs, observed digests and sample denominators;
   supplement with test-only fixed-vector checks of the harness adapters.
2. **Measurement controls.** Predeclare a representative frozen set including
   short after-work/idle calls, borrowed calls, owned queue messages/batches
   and incremental MT. Compare repeat processes of exactly the same artifact;
   separately compare different builds of identical source. Add controlled
   extra completed work in test probes (no sleeps as a stand-in for hashing)
   and verify the expected accounting and detection. Estimate false verdict
   behavior at the actual gate margins; explain any failure before accepting
   results. Keep all runs and confirmation rounds.
3. **Carryover.** Hold the artifact fixed and vary predecessor/order, selected
   neighbors and balanced starting rotations. Distinguish schedule invariants
   from actual state persistence. Clocks records wall time and available
   thread counts; all summaries use its shared rules.
4. **Statistics.** Agree with John on grouping and the estimand before code.
   Add fixed arithmetic/paired-observation anchors, simulate correlated visits
   through the shared rule, and evaluate coverage and split/share behavior.
   Keep production timing, parsing and statistics implementations shared.
5. **Diagnostic semantics.** Review T3/T4, repair reviewed claims/metadata,
   rerun report/graph/guide tests and read the generated pages afresh.
6. **Bounded direct corroboration.** A small separate caller checks selected
   work/timing paths, using clocks rather than a second timing implementation.
   Differences are findings requiring explanation, not values to average away.

Every potentially hanging command uses an external process-group deadline.
Tests/probes run in isolated directories and preserve historical evidence.
Mac/ARM findings require that hardware; local Linux checks do not supply them.
Changes to frozen APIs/axes remain Zooko's decision. An eventual optional
batch-length suite requires a separate contract proposal.

## Acceptance ledger

An item closes only with a scoped explanation or fix, reproducible evidence,
relevant tests, and the maintainer's explicit assessment (including any
refutation or narrower interpretation). A general approval does not stand in
for item-by-item responses. Pending responses stay pending. The final audit
will identify which workloads, effects and margins the instrument supports,
which remain unresolved, and what invalidates a comparison. The user decides
whether that evidence justifies acting on benchmark results.
