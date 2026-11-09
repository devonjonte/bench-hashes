# #314 at 64 pairs on the i7-12700K (BLAKE3 #314, #306)

**Question.** Does #314 on John's return-chain candidate, compared with the code before the ring fix, make any short-stream cell slower when judged over 64 pairs, as Sam ran it on Ice and EPYC?

**Commits.** fe60dc85 (`candidate/devon-task-prefix` on 88e215ed) against fbfb319f. bench-hashes 49f45960.

**Command.** `check --points "continuous 64 B,continuous 128 B,continuous 256 B,continuous 1 KiB,continuous 4 KiB,continuous 16 KiB" --layouts 64` (`away-20261109.queue`, through queue.py, 55 min).

**Verdict.** No cell slower. Faster: mt 1 KiB -4.1% (59 of 64 pairs), 4 KiB -6.1% (58), 16 KiB -12.5% (63); shared one-cache 1 KiB -6.1% (62), 16 KiB -8.6% (61). Level: 64 B x1.007 (19 of 64 pairs faster), 128 B x1.000, 256 B x0.990; shared 64 B and 128 B x1.021 (21 and 22 of 64 faster), 256 B and 4 KiB level. The short shared cells lean about 2% slower, inside the 3% margin. Posted on BLAKE3 #314.
