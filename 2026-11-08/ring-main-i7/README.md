# The ring fix on the 0.8 line (BLAKE3 #303), i7-12700K

**Question.** Does the per-slot generation protocol carried to main (b4989d6c, devonjonte `fix/devon-ring-generation-main`) cost the stream what next's version cost (BLAKE3 #306)?

**Command.** bench-hashes 5c1a092f (main's API, no pipeline). `check --new b4989d6c --against 6e0dffd3 --points "continuous 64 B,continuous 128 B,continuous 256 B,continuous 1 KiB,continuous 4 KiB,continuous 64 KiB,continuous batch 1024,collection git objects" --layouts 8 --when-quiet`.

**Verdict.** No cell slower. servil mt continuous 64 B x0.993, 128 B x0.978, 256 B x1.006 (8 pairs, all level). The cost next's ring fix shows on the i7 (64 B +8%) is absent on main. Posted on BLAKE3 #303 and #306.
