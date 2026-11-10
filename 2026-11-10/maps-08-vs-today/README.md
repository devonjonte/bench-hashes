# BLAKE3-Servil 0.8 beside today's, as maps (i7-12700K, November 10, 2026)

**Question** (Zooko): pages like the overview and a machine's map, showing
BLAKE3-Servil 0.8 and today's library as two contenders, for two subsets
of uses: (1) what `blake3-servil-core` is to hold, one thread; (2) the
multithreaded calls that return when the work is done, settled for 0.9.
The streaming uses (continuous, lent, receiving) are left out of both.

**The pages.** `pages-core/index.html` and `pages-sync/index.html`, each
linking its machine's map under `benchmark-results/`. Screenshots of the
two front pages: `shot-core-index.png`, `shot-sync-index.png`.

**Where the figures come from.** Today's bench cannot build against 0.8
(the API changed), so the two versions come from the release check of
bench-hashes 0.21's rehearsal 6 (`../release-021-rehearsal-6-i7`, to
follow): four runs a side, fresh link layouts, alternating, the same
sample sizes; 0.8 (b5b988d8) built by bench-hashes 3363bee8, today's
(2037118c) by bench-hashes 0.21. Each cell's samples from the four runs
are joined (`merge.py`). The other hashes are from 0.21's full run. That
check judged every cell of the two versions: no cell slower.

**A first attempt, set aside:** one full run a version. It read today's
64 B call 25% slower than 0.8's, where the paired check reads it level
(12.43 and 12.17 ns/B): a single run carries one link layout's luck in
the cells of calls made now and then.

**How drawn.** The maps by a scratch build of bench-hashes that knows two
extra contenders for 0.8's samples and never measures them
(devonjonte/bench-hashes `scratch/devon-maps-08-vs-now`, cb88ed0b, never
to land), then titled by `title.py`; the front pages by `front.py`.

**What they show, on this machine:** the two versions about the same in
most uses; today's faster at one 3 KiB message (21%) and one 1 KiB
message (7%) between other work, and at a 64 B message after a pause (7%).
