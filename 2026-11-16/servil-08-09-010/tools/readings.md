@@STATUS@@
`ad163558` is baseline pre-remediation evidence; the final `0.10.0` tag commit will be measured again once audit fixes land.

@@COLD-RECIPE@@
For the cold case, write the file out once and evict it before each run (checked
with `fincore`: no page of the file stays cached):

```sh
sync FILE
hyperfine -N --prepare 'dd of=FILE oflag=nocache conv=notrunc,fdatasync count=0' \
    'official/bin/b3sum FILE' 'servil-0.9/bin/b3sum FILE' 'servil-0.10/bin/b3sum FILE'
```

@@COSTS@@
- **Large one-shot calls on machines with several L3 caches** (John Servil,
  [BLAKE3 #401](https://github.com/servil-software-factory/BLAKE3/issues/401)).
  On the two machines whose cores span three L3 caches, the every-core form's
  one-shot calls of 32 MiB and more, and a few shared cells with them, read slower
  in the mean since the cache-topology pool (`3ec37f0e`); each is named on those
  machines' pages. The cost sits in six of each cell's first 24 calls, which take
  ×1.3 to ×1.8 as long; the other calls take the earlier time
  ([pattern and evidence](../topology-one-shot-pattern/README.md)).
- **The Pipeline with very large owned batches** (John Servil,
  [BLAKE3 #389](https://github.com/servil-software-factory/BLAKE3/issues/389)): batches
  of 16,384 and 65,536 messages take 22% to 196% longer through the Pipeline than
  through the synchronous call in the same-library control.
- **b3sum's start, 3% to 5% since 0.8.0** (John Servil,
  [BLAKE3 #375](https://github.com/servil-software-factory/BLAKE3/issues/375)): the
  row "a process each" above. A [profile](../b3sum-startup-profile/README.md) finds
  about 28,000 more user instructions and 12 more page faults per run in 0.9.0; b3sum's
  own share of a small run is about a tenth, the rest is process creation.
- **One message of about 4 KiB on Zen 5, 0.8.0 → 0.9.0**
  ([BLAKE3 #376](https://github.com/servil-software-factory/BLAKE3/issues/376)),
  recorded with 0.9.
- **b3sum on a thousand 16 KiB files read cold in one run, on the two-socket EPYC
  7443** (John Servil,
  [BLAKE3 #403](https://github.com/servil-software-factory/BLAKE3/issues/403)): ×1.05
  against 0.9.0 in both runs there, 10.4 → 10.9 ms, while keeping 5.9 CPUs busy where
  0.9.0 kept 8.7 to 8.9. The same input is faster or level on the other machines.
- **A turn of 1024 × 1 KiB messages on Ice Lake, 0.9.0 → 0.10** (John Servil,
  [BLAKE3 #404](https://github.com/servil-software-factory/BLAKE3/issues/404)): 2% to 5%
  slower on both Xeon pairs, in both forms; the same-library control and the AMD
  machines are level.
- **Every other slower cell** is listed by name on its machine's page.

@@EVIDENCE@@
- **This folder and `b3sum-0100-ad163558`:** [`../b3sum-0100-ad163558/`](../b3sum-0100-ad163558/README.md) holds each Linux machine's `ad163558` full and quick `b3sum` reports, samples, and `run.sh`; `evidence/<machine>/release-0100-follow/` holds each machine's `b3sum-base-0100` report and `0.9.0 → ad163558` library check (`kept-release/`); `evidence/<machine>/evolution-010/` holds the earlier `0.8.0 → 70483031` library check (`kept-08-to-010/`); `evidence/recipe/` holds the three runs of the commands above; `tools/` holds the scripts that wrote this page. `SHA256SUMS` and `BLAKE3SUMS` cover every file.
- **Apple M6:** `evidence/apple-m6/` holds the `70483031` `b3sum` report and samples (`benchmark-results/AppleM6.darwin27/`) plus `3244-release-0.10.0-check/` (`0.9.0 → ad163558` library check).
- **0.8.0 → 0.9.0:** the release runs of bench-hashes 0.22,
  [`2026-11-13/release-022/`](../../2026-11-13/release-022/README.md).
- **Same-library control and earlier `0.10` (`70483031`):**
  [`2026-11-16/release-023/`](../release-023/README.md); the `70483031` `b3sum` results are
  drawn on the [published overview](https://servil-software-factory.github.io/bench-hashes/).
- **Versions:** BLAKE3-Servil 0.8.0 `b5b988d8982bea9490c38c79ec4b8c5c2428270c`,
  0.9.0 `bf2da8b957f5e0c80babb57952de3e53f95c921a`, 0.10 baseline
  `ad163558bd882ca7768e59764c6588fce0f285f9` (earlier `0.8 → 0.10` and `apple-m6` b3sum used `7048303103c69b8609ffe9ca0361197ba318107c`); official b3sum 1.8.7; bench-hashes
  `0.23.0+ba147639c35454e648847adbb08e2435e450493e`.
- **How the tables are made:** b3sum cells are copied from each run's report; library
  verdicts are `bench-hashes compare`'s over the kept runs, with the second stage's
  verdict for the cells a check measured again. The scripts count and group; they
  judge nothing.
