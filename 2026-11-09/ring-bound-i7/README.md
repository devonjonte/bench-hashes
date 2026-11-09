# The stream's ring bound, without the per-slot generation (BLAKE3 #303), i7-12700K

**Question.** On the 0.8 line, a task ring one slot longer than the stream's entries makes early slot reuse impossible (the proof in fix/devon-ring-bound-main 38fb59e5). Without the generation protocol (probe/devon-ring-bound-no-generation b1efe4e8), what does the stream cost against main, and against the released composition with the protocol?

**Command.** bench-hashes 5c1a092f, `bound.sh`: `check --layouts 8` over continuous 64 B to 1 MiB, batch 1024 and git objects, b1efe4e8 against main 6e0dffd3, then against 7b1ba7b9.

**Verdict.**
- Against main: **no cell slower**; every cell level (mt 64 B x0.994, 128 B x0.992, 1 MiB x1.003).
- Against 7b1ba7b9: one cell slower, mt 64 B +5.9% (8 of 8 pairs). In this run 7b1ba7b9 read 0.270 ns/B at 64 B; main read 0.285 in the run before, and the no-generation version 0.283 and 0.286 in the two runs. So 7b1ba7b9 may run a little faster than main at 64 B on this machine (it read x0.981, level, against 71154c1d in released-ring-i7). These runs did not compare 7b1ba7b9 with main directly at 64 B; the every-cell check (released-ring-all-i7) judged it level. The no-generation version reads as main does.

The ARM cost John measured (16-46%) is the question this probe answers; it needs his machines. Posted on BLAKE3 #303.
