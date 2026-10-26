# Benchmarking speed-only mutants, a second batch, i7-12700K

**Question:** as `../bench-mutants-i7`, for six more rows whose reasons
claim speed without a figure.

**Commits:** each mutant on johnservil/BLAKE3 `candidate/release-0.8`
8c34ead, against 8c34ead; bench d21cdf36.

**Command:** `bench_mutants.py` at 8 pairs (`run3.sh`) under
run-bounded.py, October 26, 09:51-11:18 UTC. The version here also
skips places the suite catches (`TESTS_TSV`); this run predates that.

| mutant | verdict |
|---|---|
| `Pool::wake_for` → () | **slower**: its reason holds |
| `hash_four_at_a_time`: delete arm 3 | **no cell runs it** |
| `root_children` `*` → `+` (the small arrays' size) | level: a candidate (one array size) |
| `Hasher::gather_part` `*` → `/` (the staging threshold) | level: a candidate, or a cell the bench lacks |
| `ChunkState::absorb` `>` → `>=` at 341:25 (the surviving place) | level |
| `ChunkState::absorb` `>` → `>=` at 352:24 | the bench panicked (`compress_blocks` asserts 1..=16 blocks). **The suite catches this place**: the prototype measured every place of a name, caught ones included; now fixed |
| `sources::closed` → () (OPEN never falls) | level in time. Workers then spin after any stream ever opened, an energy cost that `check` doesn't judge |

**Posted:** BLAKE3 #183.
