# The x86-64 mutation map, i7-12700K, October 21, 2026

`pypy3 tools/mutants/check.py --map` from johnservil/BLAKE3's
candidate/map-places at b399810 (the place-keyed tool, since landed on
servil), on an i7-12700K (20 CPUs, 14 GiB). Each shard ran alone
(SHARDS=1, CARGO_BUILD_JOBS=2, NEXTEST_TEST_THREADS=4): the default six
shards killed this machine twice by OOM.

tests.tsv records every test's outcome and time on every mutant, by
place. Its commit file names the commit. For #117: which tests x86
cannot spare.
