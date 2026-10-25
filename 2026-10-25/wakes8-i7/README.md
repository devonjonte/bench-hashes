# The newer wake design (at most 8 direct wakes) against every wake direct, i7-12700K: no cell slower

**Question:** Zooko wants the newer wake design in 0.8 (BLAKE3 #119, #80).
Does it slow any cell on the i7 against the line as it is?

**Commits:** new, devonjonte/BLAKE3 `candidate/devon-wakes-8` d795fd0: the
owed-wake cascade (9d87940) plus at most 8 direct wakes (41e6b53), on the
line's `servil`. Old, the line's `servil` 338e249, where the publisher
makes every wake itself (e2504be). The bench nested in both: devonjonte/
bench-hashes f4a8f4eb.

**Command:** `bench-hashes check --against 338e249 --cells all --keep kept`
from the bench inside ~/BLAKE3-wakes8, under run-bounded.py (4200 s),
October 25, 03:42–04:06 UTC. One first-stage pair was repeated as busy.

**Verdict:** "regress: no cell slower" in both stages. The first stage
judged 412 cells (servil st and mt) on 6 pairs; its eight suspects went to
16 fresh pairs, which judged every one level (`kept/second/`).

The supervisor vanished after the second stage's last pair and before the
check printed its closing line or released its lock; nothing in the logs
says why. Both stages' judgements are in `check.stdout.txt`, and
`bench-hashes compare` over `kept/` and `kept/second/` reproduces them
(`stage1-compare.txt`).

**The pool's one-shot cells, again (`pool-cells/`):** the first stage read
servil mt after a pause at 2 and 3 MiB about 5% slower in all six pairs,
which the EPYC's +6% at 2–3 MiB (#80) made worth a closer look. `bench-hashes
regress --contenders blake3-servil-mt --points "512 KiB … 4 MiB, idle
512 KiB … idle 4 MiB" --pairs 16` on the second stage's relinked builds
(old seeds 8–23, new 24–39): no cell slower. Every cell reads 1.001× to
1.035× (after a pause at 1 MiB the most, 3 of 16 pairs faster), so capping
the direct wakes at 8 costs the i7's 19 workers about 1–3%, below what 16
pairs judge. The EPYC (47 workers), where every wake direct cost 4–12% in
14 cells, decides the design.

**Posted:** BLAKE3 #119.
