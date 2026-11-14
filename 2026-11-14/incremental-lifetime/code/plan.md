# Short incremental lifetime validation — November 14, declared before timing

Candidate bench: 2c8676842feab053fa7855d4cb3393bdea26ed4a.
Baseline bench: 8d9eb92ada887ed57b4d2102d3f913344067f84a.
Library pin: f62bc6ac0bc1c86861659d61ffbf4e9546bc8aec.

The candidate adds six points with matched input preparation and shares the
constructor/update/finalize adapter with existing streams. One update of a
complete message per lifetime, no hint to Servil's constructor. All existing
and new tests run under bounded supervision. Fixed abc vectors anchor outputs;
axis-size differential checks supplement them. Deliberately empty Servil st
updates fail three tests; discarding the result fails four. Both restored.
190 release tests and fmt pass. Focused debug checks go to the workhorse.

## Locked EPYC 9275F questions

1. **New-cell unchanged-code control:** candidate/candidate, same library,
   six new cells plus their six one-shot/lent size baselines.
2. **Harness-change control:** old/candidate bench, same library, common
   old cells only: after-work64B/4KiB, continuous1MiB, receiving saturated,
   lent64B/4KiB, continuous Git collection. This checks factoring of old
   stream calls alongside unchanged calls in an identical selected context.
3. **John's finalize change:** one candidate bench, library
   c5d8331c7c3c89ac4890693f0c096336291d2639 ->
   0932d4a610e2dcc96e16af424f8d75d12cd4b360. The diff finishes Hasher in
   place (22 incremental lines and a test). Use the same short+baseline
   scope as question1. These exact pins also appear in his Mac job3116.
4. **Display snapshot:** one standard raw run of all available contenders
   on the short+baseline scope, 24 rounds. This supplies a map to inspect,
   not independent comparative speed evidence from fresh layouts.

Questions1–3 use check --probe followed by --layouts4: four fresh layouts
per side, no adaptive second stage. Both Servil forms run; after-gap cells
are solo and mt nonstop cells also use both shared placements. Record the
actual roster, points and scenarios from the samples. Different question
scopes stay distinct; a level reading does not establish equivalence.
The complete job has a one-hour deadline and holds the common benchmark lock.

Retain every failure, busy attempt and raw sample. Use the existing Rust
reader/comparison rule. Report missing cycle/energy evidence. Neither a
large effect nor a level control establishes small-effect sensitivity.
No library code or statistical rule is changed by this workload addition.

## Native Mac

Jobs3119–3121 repeat questions1–3 with the same source pins, point sets and
four layouts through the existing team runner. Both Servil forms run, with
solo gap cells and OS-placed shared mt nonstop cells. Mac placement and
compiler differ from EPYC; compare within each machine's matched context.
The mixed-use Mini remains explicitly qualified. Preserve busy retries or
abstentions and avoid new submissions aimed at a quiet verdict. Each job
has a30-minute bound. No dedicated timing-Mac claim follows from these jobs.
