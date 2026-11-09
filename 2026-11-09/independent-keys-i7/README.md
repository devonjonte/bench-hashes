# Sam's independent-key candidate (BLAKE3 #312, #325) on the i7-12700K

**Commits.** 62b75883 (samshackleton-tech `candidate/sam-independent-reviewed-next`) against 0b5bf7b7. bench-hashes 49f45960.

**Command.** `check --points "interleaved 256,turn 256,idle turn 256,turn 1024 x 1 KiB,idle turn 1024 x 1 KiB,continuous 64 B,64 B,1 KiB" --layouts 8 --when-quiet`.

**Verdict.** No cell slower; every cell level (st turn 256 x0.987, mt idle turn 256 x0.968, the 1 KiB turns x0.99-1.005). The bench's turn cells hash in plain mode, where the candidate keeps the shared kernel; its keyed gains lie outside them. Posted on BLAKE3 #325.

**3f1c24d8** (Sam's independent backend on John's in-place workspace) against 0b5bf7b7, the seven cells of grouped-noalloc-i7 (`3f1c24d8-gate.stdout.txt`): no cell slower at either stage, every cell level. The first stage's line reads: `regress: instructions moved beyond +0.5% in 4 level cells, suspects first: blake3-servil-st|solo|IdleInterleavedTurn|256 +2.4%; blake3-servil-st|solo|Interleaved|256 +2.3%; blake3-servil-st|solo|IdleInterleavedTurn|1024 x 1 KiB +1.5%; blake3-servil-st|solo|InterleavedTurn|1024 x 1 KiB +1.5%`
