# The x86 cold code prefetch in convenience's path alone, probed (i7-12700K, November 6, 2026)

`exp/devon-x86-prefetch-conv` on servil 8d6525c3: the x86 twin of NEON's cold prefetch
(4 KiB of the many-lane kernel, 1 KiB of compress) inside `hash_serial_from`'s cold path,
so throughput calls never pay it. A `check --probe` (3 pairs) on the cold cells read
x0.92-0.98 after other work, x0.83-0.99 after a 5 ms pause, x1.02 after 20 us: weaker and
less even than November 5's x0.73 against the pre-split code. Not built on; the branch
stays as the probe.
