# The no-generation ring probe against main, every cell, i7-12700K

**Commits.** b1efe4e8 (devonjonte `probe/devon-ring-bound-no-generation`: a task ring of ENTRIES + 1 slots, no generation protocol) against main 6e0dffd3. bench-hashes 5c1a092f.

**Command.** `check --cells all` through queue.py (`night2-20261109.queue`, 48 min): 4 pairs over every cell, then 64 pairs on the suspects.

**Verdict.** No cell slower at either stage. No level cell's instructions moved beyond 0.5%. Posted on BLAKE3 #303.
