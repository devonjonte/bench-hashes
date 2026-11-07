# The AVX2 eight-lane candidate on the Intel i7-12700K (November 7, 2026)

Sam's comparison (BLAKE3 #271), her exact hashes: baseline 7c4166fa (frozen #271)
against candidate e3af185c (probe/sam-output8), bench 415e7df3, her bulk.sh and
ready.sh with three adaptations: builds serial with CARGO_BUILD_JOBS=4, the agent's
home and PATH in place of /root, and run-bounded's lock in place of pinned-run.
Runs pinned to CPU 2, four builds a side, alternating order, as launched.

Ready-state finalization (wall): 36 Faster / 24 Level / 0 Slower; at 1,024 states
79 -> 21.7 ns a message (about 3.7x). Complete cycles through update_each: 24 Faster
/ 8 Level / 0 Slower; 1 KiB cycles at 1,024 messages 810 -> 411 ns a message; 64 B
cycles 177 -> 107. The bulk finalize-only phase reads slower at chunk sizes
(62 -> 257 ns) where the update phase (23 Faster / 9 Level) took the deferred
prefix work, per #270. Same-head A/A: every wall cell Level (96 of 96); one
package-energy cell at +5.4% among 480 judgments.

— Devon Jonte
