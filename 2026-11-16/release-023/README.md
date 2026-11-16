# bench-hashes 0.23 at its version commit: the fleet's release runs

November 16, 2026. [Release tracker](https://github.com/servil-software-factory/bench-hashes/issues/232).
Bench `0.23.0+ba147639c35454e648847adbb08e2435e450493e` (version commit
`cade30fdb71682719f5fa3e586ff96146ae9fc25`), measuring BLAKE3-Servil
`7048303103c69b8609ffe9ca0361197ba318107c`.

**Command.** Each host's `release/run.sh` under its lock: the machine profile, the
release check against BLAKE3-Servil 0.9.0 (`bf2da8b9`) under the 0.22 bench
(`--old-bench d7723f11`, every cell), the same-library control across the two
benches, the full run, b3sum (four layouts) and crowd. All six jobs exit 0 with
quiet loads; every report names the meant commits. First release with cycle
counters readable on these hosts.

| host | release: faster | release: slower | control: faster | control: slower |
|---|---:|---:|---:|---:|
| x86-epyc-9275f | 126 | 12 | 59 | 10 |
| x86-epyc-9255 | 124 | 12 | 60 | 16 |
| x86-9700x | 50 | 1 | 47 | 0 |
| x86-icelake | 121 | 6 | 67 | 5 |
| x86-icelake-2 | 110 | 1 | 68 | 2 |
| x86-avx2 | 170 | 1 | 64 | 6 |

**Reading.** The control compares one library under two benches whose
multithreaded continuous cells call different APIs (synchronous in 0.22, the
Pipeline in 0.23), so its faster and slower cells are that API change's, and the
release comparison includes it. Slower cells repeated by name and owned:
multi-L3 one-shot and lent 64 MiB costs of the cache-topology pool
([BLAKE3 #401](https://github.com/servil-software-factory/BLAKE3/issues/401)),
isolated on both EPYCs with one bench (`slower-cells-023-v2/`; the first try
died on a point name of mine, kept); the Pipeline's huge owned batches
([BLAKE3 #389](https://github.com/servil-software-factory/BLAKE3/issues/389)).

**Repeats by name on the other machines** (`<host>/slower-cells-023-rest/`, the
release comparison again on each machine's own slower cells; `slower-cells-rest.sh.in`):

| host | cells repeated | reading |
|---|---|---|
| x86-9700x | `idle 8` | no cell slower |
| x86-icelake-2 | `brief idle 8` | no cell slower |
| x86-avx2 | `continuous 64 B` | shared two caches slower again, +37.0% (4 pairs); solo and shared one cache faster. The control reads the cell too: it is the every-core stream cells' move to the Pipeline ([BLAKE3 #389](https://github.com/servil-software-factory/BLAKE3/issues/389)) |
| x86-icelake | `8`, `brief idle 4`, `brief idle 8`, both turns of 1024 x 1 KiB, `lent 64 MiB` | none of the six repeats; one neighbour reads slower, the one-thread turn after a brief pause, +3.0% |

**The turn of 1024 x 1 KiB messages on the two Xeon pairs** (`slower-cells-023-turn/`,
the three turn points by name): on `x86-icelake-2` five of six turn cells read slower,
+3.7% to +4.2%. Both machines' release checks read every turn cell ×1.02 to ×1.05, and
their same-library controls read them level, so the library carries it
([BLAKE3 #404](https://github.com/servil-software-factory/BLAKE3/issues/404)).

**Mac.** The mixed-use Mini ran the full run, b3sum and crowd (`ok`, mains);
its release and control checks read busy windows four times and gave no verdict
(`mac-m6-mini/`). The dedicated timing Mac then ran the whole set
(`mac-m6-timing/`, jobs 3207 to 3211, home prefix redacted): the release check and
the same-library control read no cell slower, and its full run, b3sum and crowd are
the Apple M6's published records (pull request #236).

**Published.** Records for five x86-64 machine kinds and the overview: bench-hashes
`next` 22ffebfb (pull request #234); the Apple M6: `next` 7ec90469 (pull request #236). Sample files keep their bytes; home
prefixes in logs are redacted; both manifests cover this folder.
