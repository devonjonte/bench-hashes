# bench 0.20 candidate (the shared scenario retired): A/A and same-library checks (i7-12700K, November 2)

**Question:** does bench #110 (2259e1f8, every cell one program alone,
samples v8) read identical code as level, and read 0.19.6's v7 files
through its bridge? The fork at 0.8 (b5b988d8). Command: `run.sh`.

| check | verdict | time |
|---|---|---|
| A/A, `--cells all` (`aa*`) | no cell slower, both stages | 2326 s, with pair 1 repeated twice for busy windows (my shell in the sandbox) |
| same-library, `--old-bench 71c71159` (0.19.6, v7) `--cells all` (`same*`) | no cell slower, nothing faster: the solo trains are 0.19's | 1825 s |

A first-stage pair takes 141 s (0.19.6: 173), a second-stage pair
10.3 s (13): a check's measuring time falls by about 18%, less than a
full run's, since a check measures servil's two contenders alone and
the shared trains were a smaller share of it.

**Posted:** bench-hashes #110.
