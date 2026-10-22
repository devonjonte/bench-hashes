# The x86-64 mutation map, i7-12700K, October 21, 2026

`pypy3 tools/mutants/check.py --map` from johnservil/BLAKE3's
candidate/map-places at b399810 (the place-keyed tool, since landed on
servil), on an i7-12700K (20 CPUs, 14 GiB), with CARGO_BUILD_JOBS=2 and
NEXTEST_TEST_THREADS=4.

**Shard metadata correction, October 22:** the record contains six
unmutated baselines: each of its 146 distinct tests appears six times.
The local launcher assigned `SHARDS=1` after importing the checker, while
`run(..., shards=SHARDS)` had already bound its default to six. The source
launches every shard before waiting. Thus the completed map used six
concurrent shards. The earlier statement that each shard ran alone was
incorrect. Earlier attempts also hit OOM; the completed record retains
its actual outcomes and concurrency qualification.

[Source/default audit and raw receipts](../../2026-10-22/mutation-place-audit/)
preserve the launcher, checker and relevant mutant logs. All original
`tests.tsv` rows remain unchanged.

`tests.tsv` records every test's outcome and time on every mutant, by
place. Its `commit` file names the source commit. This place-keyed map
supports the test-reduction review; timings and timeout catches describe
the declared concurrent run.
