# EPYC 7443 (`x86-avx2`): by-name repeat of `st MerkleTree 1048576 x 32 B` and `mt IdleOneMessage 3839 B` (`0.9.0 -> ad163558`)

For [BLAKE3 #402](https://github.com/servil-software-factory/BLAKE3/issues/402) and [bench-hashes #210](https://github.com/servil-software-factory/bench-hashes/issues/210). November 17, 2026. Devon Jonte.

In `x86-avx2/release-0100-follow` (`0.9.0 -> ad163558`, `--cells all`), `bench-hashes check` read **no cell slower**. Its second stage measured 24 cells at its 8 suspects' points over 64 pairs; `bench-hashes compare` on those runs marked two non-suspect cells slower (`st|solo|MerkleTree|1048576 x 32 B` `×1.050`, 8/64 faster; `mt|solo|IdleOneMessage|3839 B` `×1.082`, 20/64 faster), where the first stage read them `×0.987` and `×0.986`.

This run repeats `--points 'merkle 1048576 x 32 B,idle 3839 B'` across three arms (`release`, same-library `control`, `release-again`):

- **Verdicts:** all three arms exit `0` (`no cell slower`).
- **8 fresh-layout pairs (`kept-release` + `kept-release-again`):** `st|solo|MerkleTree|1048576 x 32 B` reads `×0.984` level (4/8 faster); `mt|solo|IdleOneMessage|3839 B` reads `×1.032` level (4/8 faster).
- **64-pair second stage on `mt|solo|IdleOneMessage|3839 B`:** `release` reads `×1.000` level (34/64 faster), matching `control` (`×1.008`, 30/64 faster).
