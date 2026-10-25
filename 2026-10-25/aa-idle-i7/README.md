# Same-code controls for after-a-pause cells, i7-12700K: no false decision; and the size of the integration's after-a-pause cost

**Question (bench-hashes #81):** the integration's after-a-pause verdicts
flickered between runs (5 cells, then 1 other, then 0). How often does the
check judge an after-a-pause cell slower when nothing changed, and how
does the integration compare with that?

**Commit:** devonjonte/BLAKE3 `candidate/devon-release-0.8` 66732c5, the
bench at d21cdf36, against its own head.

**Command:** `run3.sh`: `bench-hashes check --against HEAD --cells all`,
three times, under run-bounded.py, October 25, 16:47 to 17:28 UTC.

**Verdict:** "no cell slower" in both stages, all three times. No cell
reached a second stage, so in 3 x 396 cells the procedure made no false
decision.

**The first stage's spread** (`analyze.txt`), solo after-a-pause cells (106
per run), beside the integration's three runs against `servil`:

| run | median | above +5% | below -5% |
|---|---|---|---|
| control 1 | x0.997 | 11% | 13% |
| control 2 | x0.997 | 3% | 23% |
| control 3 | x1.006 | 15% | 9% |
| integration vs servil, run 1 | x1.009 | 25% | 8% |
| integration vs servil, run 2 | x1.003 | 18% | 14% |
| integration vs servil + #164 | x1.007 | 17% | 10% |

The other 290 cells spread less: 14% to 17% beyond ±5%, both directions
together, against 25% after a pause.

**Reading:** with identical code, about a tenth of after-a-pause cells read
above +5% at 4 pairs, and these cells spread more than the rest. The
integration reads about twice as many above +5%, with medians 0.3% to 0.9%
above the controls'. So it has a small, real after-a-pause cost on the i7
(about 1% at the median, a heavier slow tail), and the single cells'
+7% to +20% were noise near the threshold. The check itself made no false
decision here; its verdicts on the integration flickered because a small
real shift sits at its threshold.

**Posted:** bench-hashes #81, BLAKE3 #125.
