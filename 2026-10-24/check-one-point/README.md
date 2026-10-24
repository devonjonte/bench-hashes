# Does `bench-hashes check` catch a slowdown confined to one point?

**Question.** The check's calibration (2026-10-20/check-validation)
planted slowdowns that moved many cells at once. Does it catch one that
moves a single point, judged among every cell the change reaches?

**Commits.** devonjonte/BLAKE3 line 08ffe77 (HEAD, the old side); the
working tree is the same with a plant in `hash()`. bench-hashes 7cd8ba3e.

**Plant** (`plant-one-point.py`): `hash()` of exactly 1536 bytes repeats a
whole call whenever a debt of RATE% a call reaches one call (the October
20 plant, at one length). RATE 0: the line runs and does nothing (A/A).

**Command.** `bench-hashes check --keep ...` (4 pairs), one rate at a
time, under `run-bounded.py` on the quiet i7-12700K.

**Verdict.** No cell judged slower at any rate, A/A clean. The check
chose 75 cells; the plant reaches two (servil st solo, OneMessage and
IdleOneMessage at 1536 B). Per pair (`pair_ratios.py`;
`rate-*-planted-cells.txt`):

| plant | IdleOneMessage 1536 B | OneMessage 1536 B |
|---|---|---|
| A/A | -1.9% (+4.0 +13.6 +3.2 -24.1) | -4.8% |
| +6% | +22.8% (-8.5 +27.7 +8.9 +78.4) | +2.8% |
| +10% | +13.9% (+13.1 +17.6 -3.6 +20.8 +23.7) | -7.9% |
| +20% | +55.7% (+60.0 +68.0 +23.2 +77.4) | +30.9% |

At +20% the cell after a pause was slower in every pair and judged level:
a paired t of about 5.5 on 3 degrees of freedom, where Benjamini-Hochberg
over 75 cells asks for about 15 for a lone cell. Separately, the cells
after a gap swing 10-25% a pair even in the A/A, which small plants
drown in before any correction.

**Posted.** johnservil/bench-hashes (issue opened October 24).
