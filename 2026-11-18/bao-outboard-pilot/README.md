# Pilots of b3sum's end-to-end outboard cells (November 17 and 18, 2026)

**Question.** Do the new cells of [bench-hashes #238](https://github.com/servil-software-factory/bench-hashes/pull/238)
run as declared: the warm run holds the three named inputs and the cold run the one, every contender
exits successfully, and each outboard form leaves one 1 GiB outboard of exactly 4,194,240 bytes?
These are five-round pilots of the mechanism. They make no claim about speed.

**Commits.** bench-hashes `4b968d88` (first pilot) and `5de0629e` (the pull request rebased onto
`next`, whose report says why a cache state is missing); b3sum at BLAKE3-Servil `27eacce3`; official
b3sum 1.8.7.

**Command.** `scripts/pilot.sh` and `scripts/pilot2.sh` on the EPYC 9275F; `scripts/read_pilot.py RUN_FOLDER`
checks a delivered run.

**Verdict.** Both pilots pass the reader's checks: 15 warm cells (5 contenders by 3 inputs), 5 cold
cells, five rounds each, the four outboard files of the expected size. In the second, the warm run's
header reads `cold: not measured: this run asked for warm files alone (--cache warm)` and the cold
run's the same of its warm files; the first pilot's warm run still blamed the filesystem.
On the workhorse at `5de0629e`: 205 tests pass, debug and release, and the three Python contender
tests. (That job's `bao-reference` step failed to compile because it ran without
`BAO_REFERENCE_SOURCE`, which that tool's README requires; the job's mistake.)

One reading to distrust: official b3sum's warm 1 GiB mean is 24.8 ms in the first pilot and 12.0 ms
in the second. Five rounds settle no cell.

**Posted.** The pull request above.
