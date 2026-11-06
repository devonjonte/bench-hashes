# Three cold-API (convenience::hash) variants on x86, probed (i7-12700K, November 6, 2026)

Under the rule of November 5 (convenience for calls now and then, judged by the cold
cells; performance for call after call), three ideas for `convenience::hash` on x86,
each a `check --probe` (3 fresh pairs, named cells, no verdict) against #248's branch:

| variant (branch in devonjonte/BLAKE3) | after other work | after 5 ms | after 20 us |
|---|---|---|---|
| `exp/devon-cold-serial`: 2-3 leaves through the 448-byte single-block kernel | 2 KiB x1.31, 3 KiB x1.48 | 1536 B x0.73, 2304 B x0.70, 2 KiB x0.82, 3 KiB x0.92 | x1.95-2.02 |
| `exp/devon-cold-prefetch`: 4 KiB of the kernels' code prefetched | x1.04-1.12 | x0.93-0.96 | level |
| `exp/devon-cold-two-plus-partial`: 2 chunks and a partial on 4 lanes | 2304 B x1.31 | 2304 B x1.29 | level |

Verdict: none ships. The i7 has two kinds of cold: after other work the kernels' code
is still partly in L3 and the wide kernels win; after a 5 ms pause with every core idle
L3 is flushed and the compact kernel wins by a quarter, at a third's cost in the other
column and double warm. A convenience version would have to tell the two apart, which
the rule's "no clock" forbids, and which no call can see. Retired; recorded on BLAKE3 #118.
