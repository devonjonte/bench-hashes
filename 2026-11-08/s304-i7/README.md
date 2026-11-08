# Sam's #281 stage (BLAKE3 #304) on the i7-12700K

**Question.** Does the exact tested integration a6fedec5 make any bench cell slower on a physical AVX2 machine, against 60a42e1e (both with John's ring fix)?

**Command.** bench-hashes 49f45960 (bench-hashes #157) `check --new a6fedec5 --against 60a42e1e --points "turn 256,turn 1024 x 1 KiB,idle turn 256,idle turn 1024 x 1 KiB,interleaved 256,1 KiB,collection git objects" --when-quiet`.

**Verdict.** No cell slower and none faster, at 4 pairs and on the 64-pair suspect (mt idle turn 256); no level cell's instructions moved beyond 0.5%. The bench's turn cells use Plain mode with one key, where Sam's matrices also read level; the stage's gains (distinct keys, mixed modes) lie outside these cells. Posted on BLAKE3 #304.
