# The two-crate tree against 0.8, every cell, Ryzen 7 9700X, November 12, 2026

**Question** (BLAKE3 #357, step 3, a preview): is any cell of the tree that
becomes 0.9 (candidate/split-release-tools, 5c0247cd) slower than 0.8
(b5b988d8)?

**Command.** `run.sh`: `bench-hashes check --new 5c0247cd --against
b5b988d8 --old-bench 3363bee8 --cells all`, bench next (02292b06), under
the machine's lock. First-stage figures, four pairs a cell.

**Verdict.**
- **Every cell slower is a multithreaded continuous cell, where 0.8's
  bench called the stream and today's makes one-shot calls** (0.9 ships
  no stream): 44 cells. Alone: messages one after another 2.7 to 24 times
  0.8's time (the most at 512 B and 1 KiB), batches 1.2 to 2.9 times,
  collections 3.3 to 3.4 times.
- **No other cell is slower**: none of the single-threaded cells, none of
  the multithreaded one-shot cells.
- Faster: one message of 3 KiB to 7935 B by 11 to 45%; collections on
  one thread by 11 to 17%.

**Machine.** Ryzen 7 9700X (Zen 5, 16 threads, AVX-512), Linux 7.0.0-42.
**Posted.** BLAKE3 #357, #292.
