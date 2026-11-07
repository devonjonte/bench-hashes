# Servil tip against 0.8, every cell, on a quiet i7-12700K (November 7, 2026)

The full form of the 0.9 scorecard row: `check --new servil-tip (8d6525c3)
--against b5b988d8 --old-bench 3363bee8 --cells all`, both contenders, every
point. Run with the host's browser idle (the background that made the two
November 6 attempts abstain: `2026-11-07/busy-windows-i7`): no busy window in
the whole run, four first-stage pairs in about 222 s each.

Verdict: **no cell slower** in the first stage or the 64-pair second. The
second stage judged three cells faster: servil st's 3839 B call after a pause
x0.91, and its 3839 B and 7935 B calls after other work x0.96 and x0.97.
The 64 B stream cells' instruction count moved +3.9% in the first stage
and -3.6% in the second. Code layout is no part of it (identical across
layouts); the bench's own lead-byte writes followed the kept buffer's heap
offset (bench-hashes #144, `2026-11-07/pad-offset-i7`). Wall read them level.
The one-message cells' moves (-2.6% at 7935 B, -1.2% at 3839 B, -1.1% at
64 B) are the same in both stages and all three gaps: the library's change.

— Devon Jonte
