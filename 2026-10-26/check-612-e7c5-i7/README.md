# e7c5ef48 against 612e845, i7-12700K: no cell slower

**Question:** the i7's release check (`../release-e7c5-i7`) left one cell at
+6.8% against bfbda19 (st, 3839 B after other work). 612e845 read level
against bfbda19 on October 25. Did a commit since then make it slower?

**Commits:** johnservil/BLAKE3 e7c5ef48 against 612e845, bench d21cdf36
both sides.

**Command:** `check --against 612e845 --pairs 8` (the assembly changed,
so every point: 304 cells), under run-bounded.py, October 26, 15:19-15:54
UTC.

**Verdict:** **no cell slower**, both stages (second stage: 8 suspects, 16
pairs). No commit since 612e845 costs that cell. The +6.8% against bfbda19
is a small difference at the threshold, either added up across two steps
that each read level or noise; it stays on BLAKE3 #119.

**Posted:** BLAKE3 #125, #119.
