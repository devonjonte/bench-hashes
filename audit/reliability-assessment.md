# Go/no-go: recommending reliance on bench-hashes

**Current decision: NO-GO.** Sharing code and provisional evidence for
investigation remains appropriate; recommending performance decisions waits.

I will apply this procedure. These are my acceptance requirements, rather
than upstream policy. Every requirement must pass for the advertised scope.

## 1. Commit the claim and test plan

Before validation, name the exact versions/build, hardware/OS, APIs/inputs,
solo/shared scenarios, workload context, comparison statistic and minimum
performance difference **E** we will recommend acting on. Specify fast/slow
speeds and shares separately; a fast-only claim cannot certify all states.

Start by testing the existing margins: solo continuous 3%, shared continuous 10%,
after-gap 20%. They are resolution targets to validate. General endorsement
requires native x86 Linux and native Apple ARM/macOS evidence at minimum;
VMs and other configurations need their own validation. Keep unvalidated
configurations explicitly outside the recommendation.

## 2. Clear the blockers

Require zero unexplained discrepancies in independently anchored digests,
actual submitted/completed work (including calibration), time/work units,
realized scheduling, reports versus samples, and source/artifact provenance.
Exercise every advertised adapter and boundary outside production timing.

Executable tests must withhold decisions on busy/unobserved load, including
confirmation; narrowing must preserve or separately report broad-context
costs. API/kernel labels must reflect known information; consistency checks
must state conditional premises. Compared speed subsets need a defensible
meaning across runs.

For intervals advertised as 95%, require at least 95% truth coverage in each
4,000-trial validation model: correlated copies, serial dependence, and
one/two-speed selection. Freeze models/estimands and use fresh seeds. This is
an empirical threshold, not universal proof. Alternatively, remove unvalidated
intervals and claims based on them from user-facing output and narrow the
recommendation explicitly.

## 3. Freeze the instrument; run fresh acceptance tests

Commit the schedule, controls, seeds and stopping rules after exploratory
fixes/tuning. Use shared clocks/readers/statistics and bounded process-group
supervision. Preserve every attempt and adaptive stage. For each advertised
platform/configuration, require:

| Test | Required result |
|---|---|
| Exact-artifact nulls and identical-source rebuild controls | 66 scheduled whole comparisons (33 of each control type), at least 60 valid verdicts, zero false improvement/regression decisions across the advertised scope |
| Positive controls through the actual decision path | Per workload family/scenario: 30 checks at E and 30 at 2E; at least 27/30 correct detections at each level; abstentions/timeouts count as misses |
| Repeats and context controls | At least 12 ABBA blocks across three sessions; maximum observed within-context null deviation and neighbor/order-induced deviation each below E/2 for every claimed speed |
| Direct-caller corroboration | Each workload family agrees within E/2 under matched conditions, or the recommendation explicitly separates the different workloads |

Positive controls add observed, completed hashing work; establish their effect
on a separate calibration dataset. Doubling work cannot validate 3% sensitivity.
Cover short, queued and incremental paths, slow states, and broad-context-only
costs. Whole comparisons include narrowing, confirmation and user-facing
winner/regression decisions. Shared flags count even when they allow a commit.
Do not count cells as independent trials or discard failed/abstaining attempts.

These are finite release criteria, not an error-rate guarantee; statistical
generalization needs justified independence and multiplicity treatment.

## 4. Review and issue the decision

Publish a pass/fail table with reproducible commands, raw evidence and open
claims. Obtain John's item-by-item T1–T8 assessment and independent reproduction
by another operator for the declared configuration. Keep disagreements visible;
an unresolved objection affecting the recommendation blocks that scope.
Maintainer approval supplements the tests; it cannot replace them.

I will issue:

- **GO:** every requirement passes for the entire advertised scope.
- **LIMITED GO:** a predeclared subset passes; reports, guide and documentation
  mark everything else provisional and withhold unsupported decisions.
- **NO-GO:** required evidence is failed, missing or unresolved.

A changed scope/threshold requires a new committed plan and fresh validation;
it cannot retroactively rescue failed controls. Material timing, scheduling,
accounting, statistics or decision-policy changes reopen validation. Historical
failures remain available. This decision leaves the separate optimization and
promotion pause in place.

## Today's blockers

The [live gate](results/live-gate/README.md) held an identical-artifact
regression; narrowed processes lack load windows; changed context can dismiss
broad costs; shared intervals under-cover. Accounting/interpretation items,
maintainer reviews and the acceptance campaign remain incomplete. Therefore
**NO-GO for recommending reliance**, while audit publication continues.
The [supporting profile](reliability-profile.md) retains details and metrics.
