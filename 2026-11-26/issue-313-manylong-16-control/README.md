# Positive control for `bench-hashes#313`: existing `ManyLongMessages 16` (`4 KiB batch 16`) catches AVX-512 `across_from` `16 -> 32` drift

- **Question:** Does `bench-hashes`'s existing `UseCase::ManyLongMessages` point `16` (`--points "4 KiB batch 16"`, already included in `bench-hashes check --cells all`) catch `BLAKE3` `src/many.rs::across_from` drifting from `16` (`ACROSS_GROUP`) to `32` (`Platform::AVX512.simd_degree()`) on Zen 5 AVX-512?
- **Host:** `x86-epyc-9255` (bare-metal AMD EPYC 9255, Zen 5 AVX-512, mains power, performance governor).
- **Commits:**
  - `bench-hashes`: `3f119a507807078649d8700112994fce24666868` (`next`)
  - OLD (`BLAKE3` fixed probe): `99e12a05a5190ed9558778f1a8d4dbfcc34fdbd6` (`87a0ab4b9` + 1-line cap `platform.simd_degree().min(ACROSS_GROUP)` in `src/many.rs::across_from`)
  - NEW (`BLAKE3` unpatched `next`): `87a0ab4b9f3cebfa30a791993573bfb4b128ae4e` (`across_from = 32` on AVX-512)
- **Command:**
  ```sh
  ./target/release/bench-hashes check --fork "$SCRATCH/BLAKE3" \
    --against "$FIXED" --new "$BROKEN" \
    --points "4 KiB batch 4,4 KiB batch 16,4 KiB batch 64,4 KiB batch 256" --when-quiet
  ```
- **Verdict (`CHECK_EXIT=1`, Stage 1, 4 pairs):**
  - `blake3-servil-st|solo|ManyLongMessages|16`: **SLOWER `+154.2%`** (4/4 pairs `+151.3%` to `+155.9%`, cycles `+150.8%`, instructions `+73.6%`)
  - `blake3-servil-mt|solo|ManyLongMessages|16`: **SLOWER `+155.4%`** (4/4 pairs `+152.2%` to `+160.6%`, cycles `+150.9%`)
  - Existing `ManyLongMessages 16` (`4 KiB batch 16`) already guards this threshold cleanly without adding a duplicate cell.
- **Posted:** https://github.com/servil-software-factory/bench-hashes/issues/313
