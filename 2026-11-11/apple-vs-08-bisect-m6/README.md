# Which commit made the Apple M6's small batches and short multithreaded messages slower than 0.8 (BLAKE3 #364), November 11, 2026

**Answer: b2dad43c** ("Cold calls by their API, not a clock", BLAKE3 #253),
a recorded, deliberate cost: on AArch64 a `throughput` call made after
other work no longer gets the prefetch 0.8's clock gave it.

**How.** Checks on the M6 through the Mac exchange, each a commit against
0.8 (b5b988d8) with one bench (828e8500) on both sides, points
"4,8,7935 B" (`bisect.py`, `log.txt`; the jobs' logs in `job-*`):

| job | commit | reading |
|---|---|---|
| 3043 | 27717b3f | nine cells slower, 45% to 147% |
| 3044 | 27717b3f -> 2037118c | none slower |
| 3048 | b6b2e12f (58th of 121) | level (one cell +7.9% at 4 pairs: not the signature) |
| 3055 | dad0a6fc (83rd) | level |

Ten commits after dad0a6fc touch the library's code. The M6 then stayed
busy and the measured bisect stopped. b2dad43c is one of the ten, and its
message lists these cells with these sizes from its own check (Mac job
1934). A confirming check of it against its parent is queued (job 3058).

**The log shows two wrong passes.** The first two took job 3048's
"regression" status for the signature and searched commits 0 to 57; the
third asks for a cell at +30% or more.

**Posted.** BLAKE3 #364; bench-hashes #169 (the cells stay as they are).
