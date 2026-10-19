# v0.8 release check, x86-64 (BLAKE3 #94)

- **Library:** `perf_regress compare 80aa44b b065548` (bench-hashes' pin
  against `candidate/oct19`), every servil mt and st cell and sha256-ring,
  8 fresh layouts a side: no cell slower (`perf.stdout.txt`,
  `perf-samples/`). The same against `5045bb7` (`b065548` with #87): no
  cell slower (`perf87*`).
- **b3sum:** `bench-hashes b3sum`, 4 layouts a build, official 1.8.2 in the
  same run. `b3sum/`: 20 rounds, pin vs candidate. `b3sum2/`: 40 rounds,
  pin vs candidate vs candidate + #87. Cold 256 MiB: candidate x1.029 (40
  of 40 rounds slower), with #87 x0.994. The cause is #77's revert, not
  reading to EOF (correction on #94).
- **Tests:** `matrix.stdout.txt` (every suite, GCC and Clang),
  `sanitize.stdout.txt` (ASan, TSan, Miri).
