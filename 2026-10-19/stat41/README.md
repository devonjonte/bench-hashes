# Choosing the summary statistic (bench-hashes #41)

A/A runs and three planted slowdowns (`probe/devon-plant41-*`): `aa/`,
`uniform6/`, `rare10x3/`, `stall1s/`, each perf_regress's kept samples
(samples v5, read with `bench-hashes-validation/stat-eval` against clocks
`7d40f63`). Verdict posted on #41: drop the slowest ceil(n/100) (T1), which
Zooko accepted on October 19.
