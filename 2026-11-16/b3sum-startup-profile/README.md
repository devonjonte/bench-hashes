# Where a small-file b3sum run spends its time

November 16, 2026. A diagnostic profile for
[BLAKE3 #375](https://github.com/servil-software-factory/BLAKE3/issues/375) and for the
"a process each" row of the [0.8 → 0.9 → 0.10 page](../servil-08-09-010/README.md).

**Question.** bench-hashes reads b3sum 0.8.0 as 3% to 5% faster than 0.9.0 and the 0.10
candidate (`70483031`) when each small file gets its own process. What does one small
run consist of, and how much of it is b3sum's to improve?

**Command.** `startup.sh` on two quiet measurement machines under their locks, with the
programs the comparison run built (first link layout): for each, `perf stat -r 300` on a
4 KiB file, `strace -c -f`, one `strace` timeline, and the program file's size; `/bin/true`
the same way as the floor of creating a process. `startup_table.py` copies the table from
perf's and strace's output.

**`x86-epyc-9275f`**

| program | time per run (perf stat, 300 runs) | over `/bin/true` | user instructions | page faults | program file | system calls | threads started | per run in a shell loop |
|---|---:|---:|---:|---:|---:|---:|---:|---:|
| `/bin/true` | 272 ± 4 μs | | 129,929 | 55 | | | | 195 μs |
| b3sum 0.8.0 | 294 ± 1 μs | +21 μs | 316,230 | 74 | 2.85 MB | 43 | 0 | 224 and 235 μs |
| b3sum 0.9.0 | 303 ± 2 μs | +31 μs | 344,351 | 86 | 2.91 MB | 43 | 0 | 232 and 229 μs |
| b3sum 0.10-candidate | 302 ± 2 μs | +30 μs | 339,272 | 97 | 3.28 MB | 41 | 0 | 227 and 228 μs |
| official b3sum 1.8.7 | 2004 ± 15 μs | +1732 μs | 8,287,168 | 397 | 1.51 MB | 2411 | 48 | 1626 and 1620 μs |
| official b3sum 1.8.7, `--num-threads 1` | 517 ± 3 μs | +244 μs | 419,075 | 117 | | | | 460 and 460 μs |

**`x86-icelake-2`**

| program | time per run (perf stat, 300 runs) | over `/bin/true` | user instructions | page faults | program file | system calls | threads started | per run in a shell loop |
|---|---:|---:|---:|---:|---:|---:|---:|---:|
| `/bin/true` | 767 ± 2 μs | | 132,359 | 55 | | | | 536 μs |
| b3sum 0.8.0 | 811 ± 2 μs | +44 μs | 290,341 | 74 | 2.85 MB | 43 | 0 | 599 and 596 μs |
| b3sum 0.9.0 | 839 ± 2 μs | +72 μs | 315,428 | 86 | 2.91 MB | 43 | 0 | 642 and 630 μs |
| b3sum 0.10-candidate | 849 ± 2 μs | +82 μs | 315,197 | 97 | 3.28 MB | 41 | 0 | 660 and 649 μs |
| official b3sum 1.8.7 | 6925 ± 12 μs | +6158 μs | 41,123,438 | 778 | 1.51 MB | 5639 | 112 | 5864 and 5832 μs |
| official b3sum 1.8.7, `--num-threads 1` | 1301 ± 2 μs | +533 μs | 424,248 | 117 | | | | 1045 and 1047 μs |


**Reading.**

- **A BLAKE3-Servil b3sum run on a small file is one thread and 41 to 43 system calls** in a
  statically linked program. It takes 21 to 31 μs longer than `/bin/true` on the EPYC and
  44 to 82 μs longer on the Xeon; the remaining nine tenths of the run is the operating
  system creating and reaping a process.
- **0.8.0 → 0.9.0 added about 28,000 user instructions (+9%) and 12 page faults**: +9 μs
  (+3.1%) on the EPYC and +28 μs (+3.4%) on the Xeon. That agrees with the benchmark's
  3% to 5%.
- **0.9.0 → 0.10 candidate:** instructions level, 11 more page faults, a 13% larger program
  file; time level on the EPYC and +10 μs (+1.2%) on the Xeon.
- **Official b3sum 1.8.7 starts a thread for every CPU** before hashing: 6.6 times
  BLAKE3-Servil's time on the EPYC and 8.2 times on the Xeon; with `--num-threads 1`,
  1.7 and 1.5 times.

**What it bounds.** b3sum's own share of a small run is about a tenth (30 of 302 μs; 82 of
849 μs), so a leaner start can gain at most that. Recovering 0.8.0's start would gain 3%.

**Limits.** This is a profile, and its figures are unjudged. perf's time includes its own
launch of each run. It covers one input on two machines. The harness's earlier
comparison with a minimal Bao tool (320 μs against 420 to 530 μs, through the harness's
launcher) has no row here. Home prefixes in logs are redacted.
