# The released ring composition against main, every cell, i7-12700K

**Commits.** 7b1ba7b9 (integrate/released-ring) against main 6e0dffd3. bench-hashes 5c1a092f (main's API).

**Command.** `check --cells all` through queue.py (`night-20261109.queue`, 48 min): 4 pairs over every cell, then 64 pairs on eight suspects.

**Verdict.** No cell slower at either stage; instructions moved beyond 0.5% in two level cells only (st turn 256 +1.7%, idle turn 256 -1.9%). On x86 the released composition costs nothing measurable; the cost John measured is ARM's (BLAKE3 #303). Posted on BLAKE3 #303.
