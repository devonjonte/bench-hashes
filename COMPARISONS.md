# How a comparison is judged, and why

For the servil team. **Read this before changing how bench-hashes compares
runs**: the rule, its margins, pairs, rounds, layouts, or which cells a
check judges. The rule has changed many times; each change answered a
measured problem, and several later changes undid earlier ones because the
reasons were scattered across notes, pull requests, and commit messages.
This file keeps them in one place. Add your decision here when you change
anything it covers.

## The rule

Every comparison takes **pairs of runs**, one of each side, back to back in
alternating order, and summarises each cell of a run by its **mean** (total
time over total work, `clocks::summary::mean`). `clocks::summary::discoveries`
judges all of a comparison's cells at once: per cell a paired t-test on the
logarithm of each pair's ratio, new over old; over all cells the
Benjamini-Hochberg procedure at a 5% false discovery rate; and a cell that
passes is slower or faster only beyond a 3% margin. Each pair gets a **fresh
link layout** on both sides (the fork's `tools/perf_regress.py` relinks each
side with a random function order). `bench-hashes compare` applies the rule
to samples files; `bench-hashes regress` runs the pairs and applies it, over
the lent cells, or every cell with `--full`.

**Use one driver.** `perf_regress.py compare OLD NEW [--full]` builds the
sides, relinks them per pair, and runs `regress`. A hand-written loop of runs
skips something sooner or later: fresh layouts, alternation, the load check,
the rule itself.

## Each choice and its evidence

| choice | evidence | what it gives up |
|---|---|---|
| A run's **mean**, not a median or a fast speed (October 2) | Calibration with planted slowdowns, Mac jobs 1164-1167 (the fork's NOTES, "The regression check, calibrated"): at +6% the fast speed never caught 1 MiB (0 of 18); the mean caught all three cells nearly every time. | Nothing callers pay; a cell's two speeds stay visible in its samples. |
| **Pairs of runs**, alternating (October 2) | Most uncertainty lies between processes: code placement, thread placement, the speed a cell settles into. Twelve samples or twenty-four gave the same between-run spread (September 26, ae3b7662); one binary's run means varied 1.49 times what its samples predict (audit/variance-on-unchanged-code.md). | The time of a second side's runs. |
| **A fresh link layout per pair** (October 16) | A binary's layout moves the cells of calls made now and then by several percent, fixed for every run of that binary: alternation cannot cancel it. Two links of one source gave 27 false verdicts in 700 cells (the audit). | A relink per pair (seconds), done by `perf_regress`. |
| **All cells judged at once**, false discovery rate 5% (October 16, Zooko) | A per-cell test at a few percent, over 700 cells, flags 15-27 cells of unchanged code; the sign test cannot go stricter with few pairs (8 pairs: best p = 1/256). With the rule: 0 of 700 in three unchanged-code controls, and the code's real changes found (the audit). | Floating point inside the t-test, which the statistics need. |
| **A 3% margin** (October 2) | The planted calibration: +3% caught about half the time, +6% nearly always; one layout-only change in eight held at the lent 64 B cell near 3%. | Changes under 3% pass one commit at a time; the release check (`--against` the last release) sees their sum. |
| The **gate judges the solo lent cells** (October 2) | On identical code the queue's cells moved 6-60% between processes, and two copies' shared 64 B cells switch between states 20-30% apart. | Those cells are judged by `--full` comparisons and review, and the gate stays quick (about 30 s). |
| **Cold calls out of the gate** (October 1) | Layout luck of about ±60% at 64 B after a gap on the Mac, fixed per binary; telling 20% from it needed a dozen layouts a side. | A cold-path slowdown shows in `--full` comparisons and review. |
| **No intervals as verdicts** (October 1) | The 95% median bands held for a quarter of the cells across runs of identical code. The sign test's range printed beside each median (October 15) is a reading aid, not a verdict. | — |

## Why the rule kept changing

Five patterns, each seen in the history:

1. **A rule calibrated for one question, reused for another.** The gate's
   sign test was calibrated for about a dozen cells. On October 15 `compare`
   began judging all 700 cells "as `regress` judges", and false alarms
   followed at the rate 700 tests at 3.5% predict. Likewise, twelve samples
   per cell were chosen on September 26 to steady one run's own figures, and
   stayed after October 2 moved every judgment to pairs of runs. **Before
   reusing a rule, name its question and how many cells it judges.**
2. **Adopted fixes waiting to land.** The rule above was adopted on October
   16, while day-to-day measurements still ran builds without it. The false
   alarms came back and were nearly solved a third time. **Measure with the
   adopted rule, or say plainly that the result predates it.**
3. **Several drivers of one procedure.** `perf_regress`, `regress`,
   `tools/fresh-layouts.sh`, and private scripts each ran pairs slightly
   differently. **One driver; improve it instead of writing another.**
4. **Reasons kept apart from the rule.** The calibrations live in the fork's
   NOTES, the causes in `audit/`, the decisions in pull requests. Documents
   described the rule as it stood, without the alternatives already tried.
   **This file holds them.**
5. **Each fix revealed the next noise source.** Layout luck, then the slow
   speed's rule, then the queue's cells, then address randomization, then a
   calibration probe that caught a cell still warming. That is progress; it
   reads as circling only when nobody records what each step removed.

## Before you change it

1. State the question the rule answers (a quick gate on a few cells, or a
   survey of every cell) and how many cells it judges at once.
2. Calibrate on this machine and the Mac, with the rule's own driver:
   identical code with fresh layouts (A/A), and planted slowdowns of +3% and
   +6% (the fork's `B3_PLANT` probe). Count false and true verdicts.
3. Change every producer, reader, driver, test, and document at once:
   `clocks::summary`, `compare`, `regress`, `perf_regress`, METHODOLOGY,
   AGENTS, PROCEDURES, FROZEN.md (the gate's points, pairs, and margin are
   Zooko's decision).
4. Add a row above: the choice, its evidence, and what it gives up; and any
   alternative you measured and set aside below.

## Alternatives set aside

- **Two speeds per cell** (September 28 to October 2): replaced by the mean,
  which carries a change in how often a cell runs slow.
- **A slow-speed rule** (until October 1): fired on identical code in 5 of
  8 checks.
- **Function alignment** to remove layout luck (October 1): no narrower on
  the Mac's cells, the binary 6% larger.
- **A confirmation stage and a SHA-256 control in the gate** (until October
  2): the mean over eight pairs needed neither.
- **Holm's correction over sign tests** (October 17): the adopted t-test with
  Benjamini-Hochberg reaches stricter levels with few pairs.

## Samples per run against pairs, measured (October 17)

A full run on an i7-12700K takes about 13 s plus 5.7 s per sample of every
cell (`--rounds`: 2 samples 24 s, 4 samples 35 s, 12 samples 81 s, the
default's 12). Three designs of about 21 minutes of runs each, `regress
--full` through `perf_regress compare --layouts N --rounds K --keep DIR`,
a fresh layout per run on each side; the two sides #59's head 845529b with
`hash()` planted 0% and 3% (probe/devon-plant-0 and -3: servil st's
one-message cells planted, the other 624 cells unchanged):

| design | false discoveries, 624 unchanged cells | median interval width, unchanged cells | streams and lent, solo | one call, solo | after a gap, solo |
|---|---|---|---|---|---|
| 8 pairs × 12 samples (the default) | 0 | 4.6% | 2.0% | 8.6% | 12.7% |
| **18 pairs × 4 samples** | **0** | **2.8%** | **1.4%** | **5.6%** | 13.6% |
| 26 pairs × 2 samples | 0 | 3.7% | 1.6% | 7.0% | 10.6% |

(The interval is the sign test's range, about 90% for every pair count, so
its width compares precision across designs.) **18 × 4 judges about 40%
more narrowly than the default in the same time, about 2.7 times the
information per minute;** 26 × 2 lies between, ahead only after a gap.
The rule kept its false discovery rate in all three: no verdict on any of
the 624 unchanged cells.

The plant did not rank the designs. "3 of every 100 calls hash twice"
follows one deterministic call sequence, so a cell making few calls a run
(1 MiB and up) gets 0% or more, not 3%, and 3% sits on the margin: the
lent cells to 64 KiB read x1.03-1.05 in every pair and passed the margin
about half the time, as the October 2 calibration found. A plant for
sensitivity needs every call's cost raised by its share, at about twice
the margin.

Not decided: the default rounds and the gate's pairs are frozen, so a new
default is Zooko's decision. Evidence: Devon's machine,
`bench-hashes-validation/measurement-procedure/budget/`.
