# BLAKE3 PR #558 round 7 (V7a) bare-metal x86 verification

- **Question:** Does the simplified counterless `local_group_mode` + unified `push_member` + `PipelineBufs` + per-cell TLS learner change (`c970a545499c23ba4c713d5107dd4ec770a63d4c`, production-identical to PR #558 round 7) preserve bare-metal x86 Pipeline gains without regressing any cell or the 1-thread `owned` / 2-thread room workloads flagged in Rule 2 round-6 review?
- **Commits:**
  - Base (`servil-software-factory/BLAKE3` `next`): `2c7c434210b1fd72eacfc27bc017cff3830e109f`
  - Candidate (`probe/devon-556-v7a`): `c970a545499c23ba4c713d5107dd4ec770a63d4c`
  - Harness (`servil-software-factory/bench-hashes` `next`): `7fae2cbff2a46392e6316f2e5e1b25123e754652`
- **Commands:**
  - `x86-avx2` (2x AMD EPYC 7443): `bench-hashes check --against 2c7c434210b1 --new c970a545499c --probe "continuous 64 B,continuous keyed 64 B" --layouts 16 --contenders blake3-servil-mt --when-quiet`
  - `x86-icelake` (2x Intel Xeon Gold 6330): `--probe "continuous 64 B,continuous 4 KiB,continuous keyed 64 B" --layouts 8 --contenders blake3-servil-mt --when-quiet`
  - `x86-epyc-9255` (AMD EPYC 9255): `--probe "continuous batch 1024,continuous 64 B,continuous keyed 64 B" --layouts 8 --contenders blake3-servil-mt --when-quiet`
  - `x86-epyc-9255` Finding-1 probe: 16 fresh `lld --shuffle-sections` alternating pairs on 5 shapes (`owned_default`, `owned_def_held`, `owned_plain`, `room_2t_clean`, `room_2t_held`).
- **Verdicts (5% gate, `EXIT=0` everywhere):**
  - `x86-avx2`: 2 faster (`shared-one-cache|64 B` `-9.7%` 16/16, `shared-two-caches|64 B` `-8.4%` 13/16), 4 level.
  - `x86-icelake`: 1 faster (`shared-one-cache|64 B` `-5.1%` 8/8), 5 level (`solo|4 KiB` `x0.951` 8/8, `shared-one-cache|4 KiB` `x0.968` 8/8).
  - `x86-epyc-9255`: 9/9 level (`solo|ContinuousBatches|1024` `x0.968` 7/8, CPU `-4.7%`; `solo|Keyed 64 B` `x0.894` 6/8, instr `-5.6%`).
  - `x86-epyc-9255` Finding-1 shuffled probe: all 5 shapes faster (`owned_default` `-2.19%` 16/16, `owned_def_held` `-2.10%` 16/16, `owned_plain` `-1.01%` 12/16, `room_2t_clean` `-1.33%` 15/16, `room_2t_held` `-2.79%` 15/16).
- **Posted:** https://github.com/servil-software-factory/BLAKE3/pull/558

## Artifact digests
- `x86-avx2-check.txt`: SHA-256 `3e9a9cce4854fd00b05781f6cc856b035dc4b3ff7b95155f2d6f91ea7824fbbf`, BLAKE3 `949f408da4a9b1e19524f6f64cf133600347ffa3db61958c9f830372a5718841`
- `x86-icelake-check.txt`: SHA-256 `c6dde223868af408e9d80bc72051f9d6525185379257e105f4156795a8af2b86`, BLAKE3 `272fb306b8bd080b0514be67f9c647a3719c072c2974d18e94188dea2c097e41`
- `x86-epyc-9255-check.txt`: SHA-256 `7aec00217ff653ad48375f4fdf95de6e52aca8296f00f061c7b2aefa651c50b2`, BLAKE3 `de48ac0d6f83a4e16ec93e0be154bab6fe978489211b156dbb7a6234b21149fc`
- `x86-epyc-9255-f1-shuffled.txt`: SHA-256 `e1e9edb8b7f7d6eec94fd366a284d4e8127606aac999a89b068018f2c02d6318`, BLAKE3 `23a27087653ae708ca91d0b14adadf328ba6a288125614c5d9b798ca6c090003`
