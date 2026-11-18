# Four programs under one bench-hashes: identical code, a planted slowdown, and 0.9.0 (November 18, 2026)

**The question.** The release check for BLAKE3-Servil 0.10.0 marked small one-message cells slower, and
the same check marked identical library code slower too
([bench-hashes #3](https://github.com/devonjonte/bench-hashes/issues/3)). Zooko asked for a check whose
marks can be believed, and set its margin at 5%. This experiment tries the proposed design on three
x86 machines before anything is built into `check`:

1. one version of bench-hashes measures both sides (0.22.0, `97c0fbcb`);
2. every pair of runs gets a new link layout for each side (a relink from the kept link inputs, about
   0.04 s, in place of a full compile);
3. on a machine with two memory nodes, both programs of a pair are written from the node of the CPU
   that pair runs on;
4. the judging rule looks after 8, 16, 32 and 64 pairs: each cell's ratio of arithmetic means with a 99%
   interval, decided "slower" when the whole interval lies beyond the margin, "within" when the whole
   interval lies inside it, and "cannot tell" when no look decides;
5. the instructions a call retires are read beside the times.

**The programs.** `check` built them (`runs/<host>/issue3-arms-a/probe-*.txt`):

| name | library |
|---|---|
| A | 0.9.0, `bf2da8b957f5e0c80babb57952de3e53f95c921a` |
| B | the 0.10.0 candidate, `27eacce3a5c2e03043f4fcd347c178a80f9d911c` |
| B2 | the candidate, in a scratch clone |
| P | that clone's working tree with a planted slowdown: 25 dependent multiply-adds on every one-shot call of 256 bytes or less (`plant.diff`), about 120 instructions a call |

**The comparisons.** Each is `bench-hashes regress` with its own calibration, pinning and load rule: 16
pairs over ten cells (one message of 64 B and 128 B after other work; 64 B, 128 B and 256 B after a
pause; single-threaded and multithreaded contenders), then 48 more pairs over the four cells after
other work.

| name | sides | what a mark means |
|---|---|---|
| null | B against B, other layouts | a false alarm |
| plant | P against B2 (single-node machines) | a detection; a planted cell left undecided is a miss at this budget |
| release | B against A | the release's question |
| far | B with its file on the far memory node against the same bytes on the near node (two-node machine, 16 pairs) | what memory placement alone does |

The job is `analysis/issue3-arms-job.sh`; its header is the declaration made before the runs.

## Results

Every figure below comes from `analysis/looks.tsv` and `analysis/judged.tsv`, written by
`bench-hashes issue3-audit --looks --margin 50` and `--judge` (source in `analysis/issue3_audit.rs`,
research branch `probe/devon-icache-counts`); `analysis/shown-cells.txt` lists every cell.
"Today's rule" is `regress`'s own verdict at its 3% margin. "Within" means the whole 99% interval lies
below +5%.

### Identical code (null)

| machine | today's rule | stopping rule at 5% | one pair's spread |
|---|---|---|---|
| Ryzen 9700X | 10 of 10 level | 8 within, 2 undecided at 64 pairs (about 76 and 106 pairs would decide) | 1.6% to 2.9% after a pause, 12% to 17% after other work |
| EPYC 9255 | 10 of 10 level | 7 within, 3 undecided at 64 pairs (about 99 to 135 pairs) | 1.0% to 3.1%, 12% to 15% |
| EPYC 7443 pair, files placed, default memory policy | 2 of 4 after-other-work cells "faster" at 64 pairs | 2 within, 2 undecided | 34% to 42% |
| EPYC 7443 pair, CPUs confined to node 0 (`bound`) | 3 faster, 2 slower of 10 | 4 within, 5 undecided, **1 false "slower"** | 7% to 26% |
| EPYC 7443 pair, CPUs and memory bound by policy (`bound-policy`) | 10 of 10 level | 9 within, 1 undecided | 4% to 12% |

The two `bound` arms ran the same 32 programs. The bound memory policy is what calms the two-node
machine; its kernel has automatic NUMA balancing on (`machine.txt`). The audit of November 13
([`2026-11-13/methodology-audit/`](../../2026-11-13/methodology-audit/)) had counted that balancing's
sampling faults and seen the same policy stop them.

### The planted slowdown (single-node machines)

| machine | cells after other work (4) | cells after a pause (6) |
|---|---|---|
| Ryzen 9700X | all shown slower at 32 pairs, 1.18 to 1.26 times | the plant costs 2% to 5% there: 4 within, 2 undecided on the margin |
| EPYC 9255 | all shown slower at 16 pairs, 1.19 to 1.23 times | 2 within, 4 undecided on the margin |

Instructions a call rose 4% to 9% in every planted cell over all pairs. The check's own first-look
rule (every one of the first four pairs beyond 0.5%) flagged all ten cells on the EPYC 9255 and seven
on the 9700X: the count wanders a few percent between pairs in the cells after other work.

### The candidate against 0.9.0

| machine | today's rule | stopping rule at 5% |
|---|---|---|
| Apple M6 (`runs/mac-m6-timing/`, `check` itself, every cell of bench 0.22, version commit `477d479e`) | no cell slower at 4 pairs, nor among 8 suspects at 64 pairs: no regression | not applied |
| Arm VM (`runs/arm-vm/release-0100-onebench/`, `check` itself, every cell, `477d479e`) | five cells slower at 4 pairs, all a turn of 1024 × 1 KiB messages (+3.7% to +5.8%): regression | see the next section |
| Ryzen 9700X | no cell slower | 9 within, 1 undecided (1.007, interval 0.937 to 1.082) |
| EPYC 9255 | no cell slower | 6 within; the four cells after other work read 1.015 to 1.024 and stay undecided at 64 pairs (about 87 to 226 pairs) |
| EPYC 7443 pair, bound policy (`policy-release`) | no cell slower; the four cells after other work "faster" | 12 of 14 readings within; those four cells 0.935 to 0.954 |
| EPYC 7443 pair, default policy | 1 slower, 2 faster of 10 at 16 pairs | undecided in 11 of 14 readings |

Instructions a call are unchanged between the two libraries in every one of these cells (0.994 to
1.005). The version commit differs from `27eacce3` in version strings, lock files and tests, with no
library source change.

### The Arm VM's turn of 1024 × 1 KiB messages

The three turn points repeated by name with this study's method (fresh layout a pair, 16 then 48
pairs, six cells), time ratio with its 99% interval at 64 pairs (`analysis/arm-turn-*.looks.tsv`):

| comparison | one thread: turn / after a pause / after a brief pause | every core: the same three |
|---|---|---|
| `477d479e` against 0.9.0 (`release-0100-turn-repeat`) | 1.039 [1.027, 1.052] / 1.047 [1.040, 1.055] / 1.047 [1.040, 1.055] | 1.039 [1.027, 1.050] / 1.050 [1.042, 1.058] / 1.050 [1.043, 1.058] |
| `1364e4b3` against its parent `47995e88` (`release-0100-turn-1364e4b3`) | 1.018 [1.005, 1.032] / 1.030 [1.019, 1.041] / 1.031 [1.022, 1.041] | 1.018 [1.005, 1.030] / 1.033 [1.023, 1.043] / 1.030 [1.021, 1.038] |

The cost from 0.9.0 to the candidate is steady at 4% to 5%, with one pair's spread of 2% to 4%. The
stopping rule calls every one of those six cells undecided at a 5% margin. It estimates about 66 and
84 pairs for the two turns without a pause, about 520 for two cells, and gives no count for two: the
change is real and about the margin's size, an outcome the three-way rule lacks. The commit
that carries [BLAKE3 #404](https://github.com/servil-software-factory/BLAKE3/issues/404)'s accepted
cost on Ice Lake, `1364e4b3`, costs 2% to 3% here; about 2% more comes from other commits in the range.
The Mac's check judged the single-threaded turn among its 64-pair suspects and found it level.
The kept link reproduced `check`'s executables byte for byte on this aarch64 machine too
(`verify-release.txt`).

### Far memory (EPYC 7443 pair, default policy, 16 pairs)

The same bytes with their file on the far node read 1.342 times slower in the multithreaded 64 B cell
after other work (interval 1.166 to 1.545) and 1.286 in the 128 B one (undecided). The single-threaded
cells range from 0.63 to 1.18: under the default policy the machine's own spread covers the effect.

### Minutes

On the single-node machines, 16 pairs over ten cells took 4.2 to 4.7 minutes and 48 more pairs over
four cells 2.4 to 3.0 minutes. Today's `check` took 14 to 39 minutes on the same cells, 11 to 32 of
them relinking (`analysis/issue3-relink-proof.stdout.txt`: a relink from kept inputs takes 0.04 s and
gives the same bytes).

## Limits

- One run per machine; three x86 machines, one Mac and one Arm VM. The Mac and the VM ran no
  identical-code comparison and no planted slowdown.
- The second 48 pairs measure four cells alone, a lighter run than the first 16 pairs' ten cells.
- The stopping rule looks four times at a 99% interval with no correction across cells; the looks'
  boundaries are the study's, with their tuning still to do.
- `runs/arm-vm/issue3-control2` and `issue3-tailored2` are the earlier two-bench controls on the Arm VM,
  kept here so they have a permanent home.

Devon owns the check's design and this evidence; John owns the release
([BLAKE3 #447](https://github.com/servil-software-factory/BLAKE3/issues/447)); Zooko set the 5% margin.
