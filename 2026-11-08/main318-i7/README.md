# The 0.8-line safety composition (BLAKE3 #318) on the i7-12700K

**Question.** Does John's main composition 71154c1d make any cell slower than main 6e0dffd3? It holds the scoped stream constructor, update_each's grouping by public mode, and the checked batch capacity.

**Command.** bench-hashes 5c1a092f, the last bench before the pipeline contender: main has no pipeline, and the bench built against main must speak its API. `check --new 71154c1d --against 6e0dffd3 --points "interleaved 256,turn 256,idle turn 256,brief idle turn 256,continuous batch 1024,lent batch 1024,continuous 64 B,continuous 64 KiB,64 B,1 KiB,1024,merkle 65536,collection git objects" --when-quiet`: 4 pairs, then 64 on two suspects.

**Verdict.** No cell slower at either stage; no level cell's instructions moved beyond 0.5%. Posted on BLAKE3 #318.
