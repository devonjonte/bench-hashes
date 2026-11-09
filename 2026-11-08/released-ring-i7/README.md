# The released-line ring composition (BLAKE3 #303), i7-12700K

**Commits.** 7b1ba7b9 (integrate/released-ring: the ring fix b4989d6c, the full-ring guard in every build, the ported GPU fixture) against its parent composition 71154c1d. bench-hashes 5c1a092f.

**Command.** `check --new 7b1ba7b9 --against 71154c1d --points "continuous 64 B,continuous 128 B,continuous 256 B,continuous 1 KiB,continuous 4 KiB,continuous 64 KiB,continuous 1 MiB,continuous batch 1024,collection git objects" --layouts 8 --when-quiet`.

**Verdict.** No cell slower; mt continuous 64 B x0.981, 128 B x0.990, 64 KiB x1.043 (2 of 8 pairs faster, level). Posted on BLAKE3 #303.
