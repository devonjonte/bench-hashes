# bench-hashes 0.21 at its tag on the rented x86-avx2 machine (two EPYC 7443), November 11, 2026

**Question.** The release runs of 0.21 (tag v0.21.0+84236bf0, pin
BLAKE3-Servil 2037118c) on the machine that takes the i7-12700K's place.

**Command.** `run.sh`, under the machine's lock (`stdout.txt`).

| run | result |
|---|---|
| full (`full/`) | exit 0, 755 s; load quiet |
| crowd (`crowd/`) | exit 0 |
| same-library check (`check-same.*`) | no cell slower, both stages |
| release check against 0.8, the long stream cells named (`check-long.*`) | first stage no cell slower; second stage, 64 pairs: **4 cells slower**, the multithreaded stream of 1 MiB messages beside another program +74.2% (one cache) and +18.6% (two caches), of 4 MiB +13.5% and +4.0% (BLAKE3 #368) |
| the same over every cell (`check.*`) | first stage no cell slower; second stage: single-threaded batches of 2 and 4 after a brief pause +4.4% and +3.2% |

No b3sum run: its test files are not on that machine yet. The machine
gives the account no instruction counts, so each second stage's suspects
are wall's alone.

**What the two release checks show together:** the whole map's second
stage did not take the stream cells (their pairs spread from -32% to
+166%, weak evidence at four pairs); the check that names them did.

**Published.** bench-hashes `next` d3aabbea
(`benchmark-results/AMDEPYC744324CoreProcessor.linux70042generic/`),
bench-hashes #163, BLAKE3 #368.

**Machine.** Two EPYC 7443 (96 threads), AVX2 without AVX-512, Linux
7.0.0-42, governor `performance`.
