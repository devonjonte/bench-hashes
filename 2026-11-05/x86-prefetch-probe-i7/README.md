# Prefetching the x86 kernels' code before a cold call: two probes (i7-12700K, November 5, 2026)

Question: the Mac prefetches its kernels' code after a pause (hash_serial_from,
prefetch_after_pause: 4-16 KiB after other work x0.51-0.66). Does the same pay
on x86? Method: `bench-hashes check --probe` (3 fresh pairs, named cells, no
verdict), exp/devon-x86-prefetch-probe (devonjonte/BLAKE3) against
candidate/devon-round-up-lanes, about 4 minutes each.

1. **Wide** (the whole hash_many kernel, 11-14 KiB, and compress, 2 KiB, every
   call of 2-16 chunks): 4 KiB after other work x1.12, after 5 ms x1.21, 8 KiB
   x1.10, 2 KiB x1.15; warm cells x1.04-1.07. Worse everywhere: 250 lines of
   prefetches ahead of a 1-2 us call queue behind the demand misses.
2. **Narrow** (3 KiB of the kernel, 1 KiB of compress; probe2-*): 2 KiB x1.00,
   4 KiB after other work x1.04, 8 KiB x0.97, after 20 us x0.96, **after 5 ms
   x0.73 (4 of 4 pairs)**.

Reading: on x86 the after-other-work column gains nothing from a code prefetch
(the gap's sweep leaves the code partly in L3; the misses are the data's and
the first lines'); the after-5-ms column, where L3 is flushed (#117), may gain
a quarter from 64 lines fetched in parallel. A lead, not a change: it would
need the Mac's cold-code check (code_may_be_cold) on x86 and the full check.
Left for the next round of library work.
