# bench-hashes keeps itself to one memory node (November 18, 2026)

**Question.** On a machine whose CPUs sit on two memory nodes (two sockets), an unbound run of
bench-hashes read identical code up to 30% apart
([`2026-11-18/issue3-four-programs/`](../issue3-four-programs/)), and under `numactl`'s bind to one node
it read level. Does the program doing that binding itself, first thing in `main`, give the same
quiet readings with no `numactl` anywhere?

**Commits.** bench-hashes `candidate/devon-one-memory-node`: `e25e337f` (the head tested); `5348e0dd`
was the first try. Libraries in the probe: BLAKE3-Servil `4483281c` against `27eacce3`; the
identical-code comparison runs the new side's 16 layouts against themselves.

**Command.** `scripts/host-test.sh` on each machine, through the measurement queue.

**Verdict.** Yes, on both machines tried.

| | EPYC 7443 pair (`runs/x86-avx2/one-node-e25e337f/`) | Xeon Gold 6330 pair (`runs/x86-icelake-2/one-node-e25e337f/`) |
|---|---|---|
| CPUs a process started anywhere may use | 0-23,48-71 (node 0) | 0-27,56-83 (node 0) |
| memory policy of every mapping | `bind:0` | `bind:0` |
| its own program file, written from the far node | 911 pages on node 0, none on node 1 | 911 on node 0, none on node 1 |
| started on the far node's first CPU | stays on that CPU, `bind:1` | stays on that CPU, `bind:1` |
| pages left on the far node | the C library, libm and the loader (other programs map them too) | the same |
| identical code, 16 pairs, ten small cells | no cell marked; ratios 0.972 to 1.023; one pair's spread 2.7% to 12.9% | no cell marked; 0.949 to 1.016; spread 4.8% to 18.9% |
| identical code, 64 pairs, four cells after other work | all within 5% (0.985 to 0.994); spread 8% to 15% | all within 5% (0.992 to 1.000); spread 10% to 12% |
| a probe through `check`, 16 layouts a side | exit 0 | exit 0 |

For comparison, the EPYC pair in the four-program experiment: unbound, one pair's spread of 34% to
42% in the cells after other work and marks both ways on identical code; under `numactl`, 3.7% to
12.2% and no mark. bench-hashes 0.23.0 beside the new program in these runs (`where-old-bench-far-file.txt`):
every CPU allowed, policy `default`, its far-written file's pages on the far node.

The judged tables are `analysis/*.looks.tsv` (`bench-hashes issue3-audit --looks --margin 50`, research
branch `probe/devon-icache-counts`). 198 tests pass on the workhorse, debug and release.

**What failed on the way, kept.** `5348e0dd` moved the pages a process had already touched and no
others: pages of its own file touched later still came from the far node's file cache (13 to 64 of
them). `e25e337f` touches the whole file first. The first test script also took stale executables
from the check's cache for its identical-code comparison: on the EPYC pair `regress` refused them (a
different samples version), and on the Xeon pair it ran a mixture of this program and 0.23.0, so that
run's comparison (`runs/x86-icelake-2/one-node-5348e0dd/kept-null*`) describes neither.

**Posted.** The pull request on servil-software-factory/bench-hashes for `candidate/devon-one-memory-node`.
