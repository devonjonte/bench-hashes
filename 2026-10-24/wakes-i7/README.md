# The owed-wake cascade on the i7: the opposite of the EPYC

**Question.** Restoring the owed-wake cascade (devonjonte/BLAKE3
`fix/owed-wakes` 9d87940) takes back the 14 EPYC pool cells e2504be made
4-12% slower (BLAKE3 #119). What does it do on the i7-12700K?

**Commands.** gate18: `bench-hashes check --against 08ffe77` (two stages,
bench-hashes 1bc45a7a) with 9d87940 in the working tree. gate15 (from
`2026-10-24/line-gate-4`): e2504be against 8bd5af6, four pairs, one stage.
`cell_ratios.py` reads both.

**Verdict.** gate18: 6 cells slower in the second stage, 15 of 16 pairs
each: servil mt solo IdleManyMessages 16384 +25.1%, 32768 +18.1%,
IdleOneMessage 1 MiB +20.9%, 2 MiB +16.6%, ManyMessages 16384 +21.5%,
OneMessage 1 MiB +19.5%. gate15's kept runs show the same cells the other
way when the cascade was removed: IdleManyMessages 16384 -13.7% (every
one of five pairs), 32768 -9.0%, ManyMessages 16384 -14.0%; four pairs
judged them level.

So on 19 workers the publisher making every wake itself is faster; on 47
(EPYC) the cascade is. The fix is not landed.

**The number of direct wakes** (`wakes-sweep.py`; branches
devonjonte/BLAKE3 `exp/wakes-2` 8caf7ce, `exp/wakes-4` 772bf2d,
`exp/wakes-8` 41e6b53d): the publisher makes up to W wakes itself and
owes the rest, which every woken worker helps pay. Each W against
08ffe77 (every wake direct), two-stage check:

| W | verdict | 1 MiB one-shot | 1 MiB after a pause | batches of 16384 |
|---|---|---|---|---|
| 1 (gate18) | 6 slower | +19.5% | +20.9% | +21.5% |
| 2 | 2 slower | +10.1% | +11.6% | +7.2% |
| 4 | 1 slower | +8.7% | +4.6% | +4.4% |
| 8 | none | +5.1% | -3.2% | +0.9% |

(first-stage geometric means over 4 pairs, `cell_ratios.py`.)

**Posted.** johnservil/BLAKE3 #119.
