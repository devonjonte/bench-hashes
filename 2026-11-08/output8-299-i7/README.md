# AVX2 output8 stage (BLAKE3 #299) on a physical AVX2 machine, i7-12700K

**Question.** Sam's #299 stage had no physical AVX2 speed measurement. Does the exact tested integration tree make any cell slower on the i7, and what does it do to many short messages in small arrivals?

**Commits.** BLAKE3-Servil 925e28d9 (exact #299 integration, `refs/pull/299/merge`) against 85c4b2d9 (Sam's direct baseline, the #296 merge). bench-hashes 49f45960 (`candidate/devon-small-arrival-turn`, bench-hashes #157, which adds the `turn 1024 x 1 KiB` cell of #156).

**Command.** `bench-hashes check --fork BLAKE3-m3 --new o8new --against o8base --points "turn 256,turn 1024 x 1 KiB,idle turn 256,idle turn 1024 x 1 KiB,brief idle turn 1024 x 1 KiB,interleaved 256,64 B,1 KiB,collection git objects" --when-quiet`: 4 pairs, then 64 on the suspects.

**Verdict.** No cell slower, at 4 pairs or at 64. Faster, every pair: `turn 1024 x 1 KiB` st -40.8%, mt -40.0%; after 5 ms idle st -38.1%, mt -38.0%; after a brief idle st -44.3%, mt -44.7%. servil mt 1 KiB one message -3.8% at 64 pairs. `turn 256` and the rest level.

Posted on BLAKE3 #299.
