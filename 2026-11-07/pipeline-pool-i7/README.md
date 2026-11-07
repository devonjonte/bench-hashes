# The pipeline's receive cells by pool size on the i7-12700K (November 7, 2026)

Question (BLAKE3 #272): John's VM read the pipeline at 0.146 ns/B on its default
16-thread pool against 0.098 on 4 threads; is the default pool's cost there on
x86 too? bench next 0b9ccc2f, BLAKE3-Servil 4eda049c (next with #272), the
receive cells (a 16 MiB message in fragments), `--threads 2..20`, two passes in
opposite orders, 6 rounds each.

| threads | 2 | 3 | 4 | 6 | 8 | 12 | 16 | 20 (default) |
|---|---|---|---|---|---|---|---|---|
| pipeline, saturated, ns/B | 0.138 | 0.098 | 0.079 | **0.071** | 0.079 | 0.088 | 0.082 | 0.080 |
| CPUs busy | 2.0 | 3.0 | 3.9 | 4.9 | 5.0 | 5.2 | 5.5 | 5.3 |
| CPU time a byte, ns | 0.276 | 0.294 | 0.308 | 0.348 | 0.395 | 0.458 | 0.451 | 0.424 |
| mt (the Hasher), ns/B | 0.241 | 0.238 | 0.238 | 0.235 | 0.243 | 0.238 | 0.239 | 0.234 |

On x86 the default pool costs little speed: 0.080 against the best 0.071 at
six threads (12%), and the pipeline is three times the Hasher at every size
from four threads. The cost is CPU time: 0.42 ns a byte at the default pool
against 0.31 at four threads (37% more), for the same speed within 1%. The 2 us
arrivals read alike.

— Devon Jonte
