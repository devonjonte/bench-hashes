# The 0.10.0 candidate on the x86-64 fleet: one-bench release checks and the b3sum suite (November 18, 2026)

**Questions.**

1. With one bench-hashes on both sides (the procedure of
   [BLAKE3 #447](https://github.com/servil-software-factory/BLAKE3/issues/447)), which cells of the library
   read slower at the 0.10.0 version commit than at 0.9.0 on the six x86-64 machines?
2. What does the b3sum suite read at the candidate, and what changes when a two-socket machine's run
   keeps to one memory node (the benchmark measures one node since November 18)?

**Commits.** Library: `477d479e` (0.10.0's version commit) against 0.9.0 `bf2da8b9` in the checks;
the b3sum suite at the candidate `27eacce3` (the version commit changes no library source) beside b3sum
0.9.0, 0.8.0 and official 1.8.7. bench-hashes 0.22 `97c0fbcb` builds both sides of each check; the
b3sum suite ran under bench-hashes 0.23.0 `cade30fd`.

**Commands.** `scripts/onebench-x86.sh` (`check --cells all`), `scripts/b3sum-one-node.sh`,
`scripts/issue447-batch8192-xeon.sh`; the unbound b3sum runs are `runs/<host>/b3sum-0100-27eacce3/run.sh`.
Two-socket machines ran their checks under `numactl --cpunodebind=0 --membind=0`.

## 1. The library, one bench on both sides

bench 0.22 marks at 3%; the margin is 5% since November 18, so the table separates the two.

| machine | marked beyond 5% | marked between 3% and 5% |
|---|---|---|
| Ryzen 9700X | none: no cell slower, nor among 8 suspects at 64 pairs | none |
| EPYC 9275F | every core: one message 32 MiB +12.0%, 128 MiB +12.9%; shared one cache: lent 64 MiB +26.4%, collection of Nix files +9.0% | every core: one message 64 MiB; after a pause 32, 64 and 128 MiB |
| EPYC 9255 | every core: one message 32 MiB +6.8%, 128 MiB +7.4%; shared one cache: lent 64 MiB +16.2% | every core after a pause 32 and 64 MiB; one thread after a pause 256 B +3.6% |
| EPYC 7443 pair, bound | every core: lent 64 MiB +26.1%, one message 128 MiB +6.5%, 32 MiB +5.3% | none |
| Xeon 6330 pair `x86-icelake`, bound | none | one thread: turn of 1024 × 1 KiB after a pause +4.2% |
| Xeon 6330 pair `x86-icelake-2`, bound | every core: batch of 8192 after a brief pause +6.7% (4 pairs) | four turns of 1024 × 1 KiB, +3.4% to +4.9% |

- Every large-message cell beyond 5% is one of
  [BLAKE3 #401](https://github.com/servil-software-factory/BLAKE3/issues/401)'s: the cache-topology
  pool's trials on machines of several caches, accepted for 0.10.0 there.
- The turn of 1024 × 1 KiB messages is [BLAKE3 #404](https://github.com/servil-software-factory/BLAKE3/issues/404)'s
  workload, accepted on these Xeons.
- **The batch of 8192 does not repeat by name.** Over 64 fresh-layout pairs under the bound policy it
  reads 0.998 (99% interval 0.992 to 1.004) on `x86-icelake-2` and 1.000 (0.994 to 1.006) on
  `x86-icelake`; all six cells of that batch size read within 5% on both (`analysis/batch8192-*/looks.tsv`).

## 2. b3sum at the candidate

Reader: `scripts/read_b3sum.py RUN` (each run's own report; `scripts/page.py` holds the parsing).

**Unbound, six machines, against b3sum 0.9.0** (15 rounds, every run quiet): faster on all six for
1 MiB warm, a thousand 16 KiB files warm, sixteen 64 MiB files warm and cold, and 16 MiB, 256 MiB and
1 GiB cold. Slower marks: a thousand cold 16 KiB files on `x86-avx2` (1.110) and `x86-icelake-2`
(1.039), the two-socket machines; nine cells carried slower marks at the earlier candidate `ad163558`.

**Bound to one node, the three two-socket machines** (time ratio against b3sum 0.9.0, cold files;
the unbound ratio in brackets):

| input | `x86-avx2` | `x86-icelake` | `x86-icelake-2` |
|---|---|---|---|
| a thousand 16 KiB files | 0.963 faster (1.110 slower) | 0.956 faster (1.014) | 0.940 faster (1.039 slower) |
| 16 MiB | **1.133 slower** (0.816 faster) | **1.273 slower** (0.812 faster) | **1.168 slower** (0.839 faster) |
| mixed tree, 1000 files, 74 MiB | 0.910 faster (0.998) | 1.125 slower (1.009) | 1.049 slower (1.009) |

- The thousand cold small files, the cell of
  [BLAKE3 #403](https://github.com/servil-software-factory/BLAKE3/issues/403), read faster than 0.9.0 on
  all three once the run keeps to one node.
- One cold 16 MiB file reads 13% to 27% slower than 0.9.0 on all three when bound, in the full suite
  and in the quick one. Bound, b3sum 0.9.0 nearly halves its time on that input (10.6 to 5.95 ms on
  the EPYC pair) and the candidate gains less (8.66 to 6.74 ms). The three one-socket machines read
  that cell 0.69 to 0.83, the candidate taking 3.0 to 3.8 ms there against 5.6 to 6.7 ms on the bound
  machines. The cause is unexamined.

**Apple M6 against official b3sum 1.8.7** (`runs/mac-m6-timing/`, quiet): faster in 16 of 20 cells,
level in three (4 KiB warm and cold, 16 MiB warm), slower in one (1 MiB warm, 1.065, as at `ad163558`).

## Limits

One run of each kind per machine. The bound runs use `numactl`; bench-hashes binding itself is a
separate change ([`one-memory-node/`](../one-memory-node/)). The Arm VM's and the Mac's library checks
are in [`issue3-four-programs/`](../issue3-four-programs/).
