# Every waker wakes at most FANOUT: 8, 4 and 64 against wakes-8, i7-12700K

**Question (BLAKE3 #119):** the release integration's wakes-8 lets one
woken worker make every owed wake (`wake-counts/`: in 24% of 2 MiB jobs on
the i7, one worker made all 11). Does bounding every waker at FANOUT cost
anything, and which FANOUT?

**Commits:** new, devonjonte/BLAKE3 `exp/devon-fanout` (the integration's
ee4c0d7 with FANOUT; `run.sh` sets it to 8, 4 and 64 in turn); old, ee4c0d7
(wakes-8). The bench at d21cdf36 nested in both.

**Command:** `run.sh`: `bench-hashes check --against ee4c0d7 --pairs 8` for
each FANOUT (the 152 servil mt cells the change touches), October 25,
19:44 to 20:40 UTC.

**Verdicts and the cells as a group** (`f*-compare.txt`, first stage):

| FANOUT | verdict | 152 mt cells: median, above +5%, below -5% | one-shots 512 KiB-8 MiB, median |
|---|---|---|---|
| 8 | no cell slower | x0.999, 3%, 7% | x1.002 |
| 4 | 2 cells slower (2 MiB +4.8%, batches of 32768 after a pause +8.0%) | x1.000, 8%, 9% | x1.030 |
| 64 (every wake direct on 19 workers) | no cell slower | x0.998, 5%, 5% | x0.979 |

**Reading:** on the i7, FANOUT 8 costs nothing against wakes-8 and bounds
every waker; a deeper tree (4) costs the one-shots about 3%; every wake
direct stays the i7's fastest, about 2% on the one-shots. The EPYC, with
47 workers, decides between 8 and every wake direct.

**Posted:** BLAKE3 #119.
