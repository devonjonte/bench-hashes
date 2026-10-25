# #157 (the two kinds of call) against `servil`, i7-12700K: John's 64 B cells come from the bench's workload; one batch cell +3.4%

**Question:** John's VM found servil's 64-byte lent and continuous cells
7–10% slower with #157 (BLAKE3 #157, October 25, 07:25). Does the i7 see
it, and is it the API or the bench's change to the workload?

**Commits:** new, johnservil/BLAKE3 #157 at e3013b1, with the bench at
John's d21cdf36 (#80 plus `Sizes::read` skipping the other bench's rows);
old, `servil` 61b469c.

**Two runs, under run-bounded.py, October 25:**
1. `old-bench-f4f347c/`: John's command, `check --against 61b469c
   --old-bench f4f347c --cells all` (4 pairs). The old side's bench
   predates inputs in blocks. Verdict: "no cell slower" in both stages;
   the 64 B lent cells read 1.03 to 1.06 (0 or 1 of 4 pairs faster),
   256 B and 1 KiB level: John's pattern, smaller.
2. `old-bench-5be5f236/`: the same with `--old-bench 5be5f236`, the bench
   with inputs in blocks on the old API, so both sides run one workload
   (8 pairs). The 64 B lent and continuous cells read 0.97 to 1.02, the
   pairs split. Verdict: "REGRESSION: 1 cells slower": servil mt solo
   LentBatches 1024, +3.4% in all 8 pairs (LentBatches 16 reads -4.0%,
   also every pair).

**Reading:** the 64 B cells' cost in run 1 is the bench's per-message copy
into blocks (`block_message`: the boundary, the copy, the zero fill),
measured inside each call; with the workload held, the API leaves them
level. LentBatches 1024 on every core (64 KiB, below the pool's 512 KiB,
so the calling thread hashes it) is a cost of the API change, to trace.

**Posted:** BLAKE3 #157.
