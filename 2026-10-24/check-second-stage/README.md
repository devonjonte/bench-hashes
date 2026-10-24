# check's second stage against one-point plants

**Question** (bench-hashes #66). Does a second stage, the first pass's
suspects run again on fresh pairs and judged among themselves, catch the
one-point slowdowns the check missed (`2026-10-24/check-one-point`)
without false alarms?

**Commits.** devonjonte/bench-hashes `candidate/devon-second-stage`
(c6fab044 and its successor on main); the fork, devonjonte/BLAKE3 line
08ffe77, with the October 24 plant in `hash()` at 1536 bytes.

**Command.** `plant-one-point-second.py 0 20 10 6 0 0`: `bench-hashes
check --keep` per rate, one at a time, quiet i7-12700K.

**Verdict.**

| run | plant | suspects | judged slower |
|---|---|---|---|
| 0 | A/A | 8 | none |
| 1 | +20% | 8 | both planted cells (+11.9%, +14.0% over 16 pairs) |
| 2 | +10% | 8 | both planted (+8.5%, +8.4%) and IdleOneMessage 512 B (+5.5%), unplanted |
| 3 | +6% | 8 | none |
| 4 | A/A | 8 | none |
| 5 | A/A | 8 | none |

A check took 10.6 minutes against 5.8 for one stage; the 32 relinks are
most of the difference, the 16 pairs about a minute.

`void-0525`: a first attempt, void. Its second stage measured the wrong
cells (a suspect's point named without its use case's prefix; the test
`every_cell_key_names_the_point_that_measures_it` holds the fix), and the
binary was rebuilt while it ran.

**Posted.** johnservil/bench-hashes #66.
