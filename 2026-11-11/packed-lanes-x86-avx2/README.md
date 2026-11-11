# Packed leaves in whole groups on the independent-compression kernels (BLAKE3 #297), two EPYC 7443, November 11, 2026

**Question.** The landing gate: BLAKE3 f2902fb2 (the same tree as the
landed 40b38526) against next 3313686b, bench 224590ad.

**Commands.** `run.sh` (every cell: `stdout.txt`, `kept/`), then the
trees and two batch points by name, 16 pairs (`named.stdout.txt`,
`kept-named/`).

**Verdict.** Single-threaded trees 44.9% to 57.4% faster (16 pairs);
multithreaded 65536 x 32 B 38.6% faster, 1048576 x 16 B 8.8% faster.
**One cell slower: the multithreaded tree of 1048576 leaves of 32 B,
6.4% (64 pairs; 4.9% in the every-cell check).** Landed with that cost
recorded as its own issue.

**Machine.** Two EPYC 7443, 96 threads, AVX2, Linux 7.0.0-42.
**Posted.** BLAKE3 #297.
