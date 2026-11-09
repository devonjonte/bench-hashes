# Sam's independent-key candidate (BLAKE3 #312, #325) on the i7-12700K

**Commits.** 62b75883 (samshackleton-tech `candidate/sam-independent-reviewed-next`) against 0b5bf7b7. bench-hashes 49f45960.

**Command.** `check --points "interleaved 256,turn 256,idle turn 256,turn 1024 x 1 KiB,idle turn 1024 x 1 KiB,continuous 64 B,64 B,1 KiB" --layouts 8 --when-quiet`.

**Verdict.** No cell slower; every cell level (st turn 256 x0.987, mt idle turn 256 x0.968, the 1 KiB turns x0.99-1.005). The bench's turn cells hash in plain mode, where the candidate keeps the shared kernel; its keyed gains lie outside them. Posted on BLAKE3 #325.
