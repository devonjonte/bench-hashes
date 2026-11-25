# BLAKE3 #556: x86 Pipeline edge slowdown fixes (5-host verification)

- **Question:** Do our `#556` `places::LEARNED` + `Pipeline`/`Shared`/`MemberGroup` layout & fast-path fixes eliminate the three `0.11.0` x86 `blake3-servil-mt` `Pipeline` edge slowdowns (`EPYC 9255 solo|ContinuousBatches|1024`, `Xeon Gold 6330 solo|ContinuousMessages|4 KiB`, `EPYC 7443 shared-two-caches|ContinuousMessages|64 B`) without losing PR #544 batch wins or regressing x86 or Apple Silicon cells?
- **Commits:**
  - `bench-hashes`: `303fff16dfcd` (4 x86 hosts), `62ed59458b74` (`mac-m6-timing`)
  - `BLAKE3` baselines: `2fd4ff6f643e` (`0.10.0`), `b1f4ce0d8b30` / `690d2f872625` (`next`)
  - `BLAKE3` fix tested: `e8c17c7558ef` (4 x86 hosts), `6e52c6eb6d25` (`mac-m6-timing` & PR #558 head; identical shipped library code)
- **Hosts & verdicts (all quiet bare-metal):**
  - **2x AMD EPYC 7443 (`x86-avx2`, 16 pairs on 64 B):** `next -> fix` `shared-two-caches|ContinuousMessages|64 B` **-19.6%** (`1.473 -> 1.184`, `16/16` faster), `shared-one-cache` `-4.0%` (`13/16`), `solo` `-2.3%` (`11/16`); `0.10.0 -> fix` `shared-two-caches` `x1.025 level` (`1.155 -> 1.184`), `solo` `x0.983 level`, PR #544 batch wins intact (`-38.9%` to `-57.1%`). Residual `shared-one-cache|64 B` vs `0.10.0` is `x1.066` (`0.657 -> 0.700`).
  - **2x Intel Xeon Gold 6330 (`x86-icelake`, 8 pairs):** `next -> fix` all 8 cells `< x1.000`, `solo|ContinuousMessages|4 KiB` **-6.1%** (`8/8`, CPU `x0.961`); `0.10.0 -> fix` `solo|ContinuousMessages|4 KiB` **-12.8%** (`8/8`, CPU `x0.877`), `solo|ContinuousMessages|64 B` **-5.7%** (`8/8`), zero regressions.
  - **AMD EPYC 9255 (`x86-epyc-9255`, 8 pairs):** `next -> fix` `solo|ContinuousBatches|1024` `-2.7%` (`7/8`, CPU `x0.981`), `shared-one-cache|64 B` `-5.8%` (`8/8`), zero regressions; `0.10.0 -> fix` `solo|ContinuousBatches|1024` `x1.036 level` (CPU `x0.984`), PR #544 wins intact (`-29.3%` to `-59.4%`, all `8/8`), zero regressions.
  - **AMD Ryzen 7 9700X (`x86-9700x`, 8 pairs):** zero regressions vs both `next` and `0.10.0` (`0.10.0 -> fix` `solo|ContinuousMessages|4 KiB` **-6.1%**, `8/8`).
  - **Apple M6 (`mac-m6-timing`, `--cells all`, `690d2f87 -> 6e52c6eb`):** stage 1 (4 pairs) + stage 2 (8 suspects, 64 distinct layouts/side) verdict **`no regression`**, zero level-cell instruction moves beyond `+0.5%`.
- **Posted on:** `servil-software-factory/BLAKE3#556` and `servil-software-factory/BLAKE3#558`.
