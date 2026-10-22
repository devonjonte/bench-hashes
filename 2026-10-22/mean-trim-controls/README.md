# Fresh controls for the restored trim — predeclared plan

## Instrument and scope

Zooko approved restoring the declared trim on October 22, with reliance
held until fresh controls pass. Candidate source:
`61afea44ac45fc94f0a91d5e150b56689891f074`, benchmark
`0.17.0+e06acf9bd851cc0d0387d2b3552baf237ea40557`, clocks
`99d34d94db14eac01a9c652e0a4858055502b08f`.
[Owner decision](https://github.com/johnservil/bench-hashes/pull/60#issuecomment-6344515055).

The first stage checks the existing Rust reader/comparator with fixed
arithmetic inputs at the actual **6/24-sample budgets**. This can expose a
policy blind spot before spending a live campaign's budget. These synthetic
records carry no measured speed, hardware cycles, energy or load evidence.

## Stage A: deterministic decision-path controls

Generate four pairs of v6 files, with independent cell names for budgets
6 and 24, phases0–9, and these three cases:

- Null: 1000 ns/unit on both sides.
- Uniform extra cost: 1000 old, 1060 new, every sample.
- Intermittent extra cost: 1000 old; new2000 when `(sample+phase)%10==0`,
  otherwise1000. The ten phases jointly impose precisely10% extra raw
  time at either budget. Each cell's four pairs repeat the same arithmetic
  inputs, eliminating measurement uncertainty for this contract check.

Use the candidate's unmodified `compare` command, its existing 5% FDR and
3% margin, judging all60 cells together. Expected policy behavior follows
from independently fixed arithmetic:

| case | retained new mean | expected judgment |
|---|---:|---|
| null, either budget | 1000 | level |
| uniform, either budget | 1060 | slower |
| intermittent,6 | 1000: each run has at most one slow sample, removed | level |
| intermittent,24 | 24000/23 or25000/23 | slower |

The six-sample result would establish a detection blind spot: all ten
phases lose their entire intermittent effect, even though their pooled raw
time rises10%. Treat it as a blocker to a reliance claim covering such
slow modes. It is an expected outcome of the declared selection, separate
from a repair's implementation correctness. Publish every fixture and log.
No data-dependent retuning or acceptance claim follows from this stage.

## Stage B: live calibration and acceptance

Live execution waits until proofs/builds stop and Stage A's scope questions
are resolved. Use existing `check`/relink/`regress`, shared clocks and the
Rust readers; Python collects processes and filenames only. Preserve both
wall time and available caller cycles, state shares, load windows and all
attempts. Scope the first campaign to this i7-12700K/Linux host. Native Mac,
VM and general-reliance claims retain their own requirements.

Before any live calibration, commit exact artifacts, independent layout
seeds, AB/BA schedules and completed-work plants. Calibrate uniform E/2E
plants independently, include intermittent modes at6/24, then freeze fresh
acceptance schedules. Apply the existing written reliability procedure:
66 null comparisons (33 exact-artifact/33 rebuild), at least60 valid and
zero false verdicts;30 positive checks each at E/2E per claimed family,
at least27 detections;12 ABBA blocks across three sessions; direct-caller
agreement within E/2. Abstentions/timeouts count as misses. Independent
reproduction and item-by-item review still govern promotion. These stages
supply no shortcut around that procedure or the current NO-GO.
