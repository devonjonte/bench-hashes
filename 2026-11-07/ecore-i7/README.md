# Servil st on an E core against a P core (i7-12700K, November 7, 2026)

One quick run of bench-hashes (3 rounds), the process pinned to CPU 2 (P) or
CPU 16 (E), BLAKE3-Servil st at the 2-chunk sizes (build edcf5ff9):

| size | P ns/B | E ns/B | E/P |
|---|---|---|---|
| 1 KiB | 1.518 | 2.256 | x1.49 |
| 2 KiB | 1.032 | 1.892 | x1.83 |
| 2304 B | 1.066 | 1.842 | x1.73 |
| 4 KiB | 0.610 | 1.269 | x2.08 |
| 8 KiB | 0.439 | 0.845 | x1.92 |

The E core's cost is a nearly uniform 1.8-2.1x at 2-8 KiB with the same
sawtooth shape as the P core's: no disproportionate 2-chunk cost for a
kinder kernel to rescue. The width and clock explain it.

— Devon Jonte
