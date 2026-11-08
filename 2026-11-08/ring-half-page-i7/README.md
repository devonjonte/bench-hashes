# John's candidate/ring-half-page (372ce8ce) against its base (5d2778b9), i7-12700K, November 8, 2026

BLAKE3 #237: both stream rings start half a page in, against Sam's EPYC finding (a worker on
the caller's SMT sibling slows submit_with's copy about 20%). `check --layouts 8 --points
"continuous 64 B,continuous 1 KiB,continuous 4 KiB,continuous 16 KiB,continuous 64 KiB,
continuous 1 MiB,continuous 4 MiB,lent 4 KiB,continuous batch 1024"`, bench 3363bee8 (the last
that speaks the base's API). Verdict: one cell slower, servil mt's continuous 1 KiB +3.7%
(8 of 8 pairs); every other cell level (16 KiB x0.96, the rest within 1.2%).

— Devon Jonte
