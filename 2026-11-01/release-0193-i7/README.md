# bench-hashes 0.19.3's release runs on the i7-12700K (November 1)

**Question:** the i7's runs at the 0.19.3 tag (`a48ee6c7`), as CONTRIBUTING's
"Releases" step 4 asks, the fork at BLAKE3-Servil 0.8 (`b5b988d8`, clean
worktree). Power: mains; governor `powersave`, EPP `performance` (the
sandbox cannot set the governor). Kernel 7.0.0-42. Command: `run.sh`, then
`confirm.sh`.

| run | verdict |
|---|---|
| full (`full/`): `build-against`, then `--all --expect-servil b5b988d8` from a scratch directory | 392 s; quiet (0.12 CPUs, 0.42 the busiest window); the report names b5b988d8, bench 0.19.3, clocks ac9e6b7d |
| b3sum (`b3sum/`), LAYOUTS=4 | 515 s; busy in 1 of 514 windows (1.10 CPUs at 72-73 s) |
| b3sum again (`b3sum-2/`): the one in the records | 513 s; quiet (0.05, 0.38) |
| same-library check (`check-same*`): `--against b5b988d8 --old-bench 1f4dfd63 --cells all` | 1334 s; 2 cells slower (mt shared LentMessages 64 MiB +5.5%, st solo IdleManyMessages 16 +7.6%), about 160 faster (0.19's trains: nonstop cells -3% to -33%) |
| those 2 cells alone (`confirm*`): 16 pairs from the check's kept links, judged on the 2 | IdleManyMessages 16 level; LentMessages 64 MiB -21.2% (all 16 pairs): neither slowdown seen outside the full run's order |

**Posted:** the records PR on johnservil/bench-hashes (bench-hashes #98 thread).
