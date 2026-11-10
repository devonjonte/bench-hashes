# bench-hashes 0.21, rehearsal 5 on the i7-12700K (November 10, 2026)

**Question.** Do 0.21's release runs pass at the release's pin: bench
`next` 301afa6a (then 7c1645d4 for the release check), BLAKE3-Servil
5663b129 (the ring race's repair and the build version)?

**Commands.** `rehearse-5.sh` (the full run, b3sum, crowd, the release
check, the same-library check) and `rehearse-5b.sh` (the release check
again, after bench-hashes #165).

**Result: the runs pass; the release check finds a library regression,
and with it a hole in the check. The tag waits.**

| run | result |
|---|---|
| full run (`full/`) | exit 0, 496 s. Header: `blake3-servil version: 0.8.0+dev.5663b129…`. Load: busy in 2 of 440 windows, both my own commands on the machine during the run |
| b3sum (`b3sum/`) | exit 0, 558 s |
| crowd (`crowd/`) | exit 0, 24 s |
| same-library check (`check-same.stdout.txt`): the pin on both sides, bench 148827f3 against 301afa6a, every cell | no cell slower, and no level cell's instructions moved beyond +0.5%, in both stages |
| release check, first try (`check-first-try.*`): the pin against 0.8, old bench 3363bee8, every cell | exit 2, no verdict: the old bench has no pipeline contender. Repaired in bench-hashes #165 |
| release check (`check.stdout.txt`, samples in `check/`, `check-compare.md`) | **REGRESSION: 2 cells slower**: the multithreaded stream of 4 MiB and 16 MiB messages, shared one cache, +33.1% and +29.9% |

The two cells are followed up in `../long-stream-shared-i7/`: the
library's, from commit 06f6e26d.

**Machine.** i7-12700K, Linux 7.0.0-42, mains power, governor
`powersave` (no root here to set `performance`).
