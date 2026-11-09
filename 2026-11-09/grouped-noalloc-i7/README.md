# The flat grouped workspace (BLAKE3 #325) on the i7-12700K

**Commits.** bc235942 (candidate/grouped-noalloc) against its base 0b5bf7b7. bench-hashes 49f45960 (with the small-arrival cell of bench-hashes #157).

**Command.** `check --points "interleaved 256,turn 256,idle turn 256,turn 1024 x 1 KiB,idle turn 1024 x 1 KiB,continuous 64 B" --layouts 8 --when-quiet`.

**Verdict.** Seven cells slower, every pair: st and mt interleaved 256 +54%, turn 256 +42%, idle turn 256 +39-40%, shared one-cache interleaved 256 +52%. Level: turn 1024 x 1 KiB and its idle twin (x1.00), continuous 64 B. Posted on BLAKE3 #325.

**Profile** (`profile/`, st interleaved 256 on one P core, LBR call graphs): memmove takes 17.5% of cycles at 0b5bf7b7 and 43.4% at bc235942. Its share called from `each::update_turn` grows from 6.4% to 34.7%, while hash_many_avx2 per byte stays as it was.
