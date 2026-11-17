# Project 3 (`bench-hashes #210`): empirical evaluation of kept two-stage `check` runs

For [bench-hashes #210 (measurement audit)](https://github.com/servil-software-factory/bench-hashes/issues/210). November 17, 2026. Devon Jonte.

Offline evaluation of all **129** kept `check` runs across six Linux hosts (`x86-9700x`, `x86-avx2`, `x86-epyc-9255`, `x86-epyc-9275f`, `x86-icelake`, `x86-icelake-2`) retained in the local `inbox/` archive (`eval.py` + `all-kept.tsv`), scored with `bench-hashes 0.23.0` (`cade30fdb7`) `compare`.

## Summary

- **Stage 2 confirmations:** 36 of the 129 runs entered Stage 2 (`64` pairs across 16 fresh layouts a side). `11` of those `36` confirmed `>= 1` Stage 1 suspect (`1`–`5` slower suspects in `evolution-010`, `release-022`, `release-023`, `numa-ab`, `own-code-2`) after Stage 1 read `0` slower.
- **Unchanged-code `release-022/kept-same` controls (`222` cells, 5 Linux hosts):**
  - `x86-epyc-9275f`: 0 Stage 1 suspects (`no cell slower`).
  - `x86-9700x`, `x86-epyc-9255`, `x86-icelake`: 5–8 suspects in Stage 1, all cleared in Stage 2 (`no cell slower`).
  - `x86-avx2`: 8 suspects in Stage 1, **1 suspect confirmed slower in Stage 2** (`st|solo|OneMessage|256 B`, `×1.110`, 16/64 faster).
- **Stage 2 `contenders × points` spillover:** `check` passes Stage 2 the union of suspect contenders and `--points` rather than the exact suspect `(contender, scenario, use_case, point)` cells (`src/check.rs:562–570`), running `17`–`28` cells in full-bench checks with `8` suspects (`2.1×`–`3.5×` inflation). On 3 of 8 full-bench `0.23` Stage 2 runs (`x86-9700x/release-023-cade30fd/kept-control`, `x86-avx2/release-023-cade30fd/kept-release`, `x86-avx2/release-0100-follow/kept-release`), `1`–`2` non-suspect cells measured beside suspects read `slower` in `second/` (`×1.045`–`×1.094`), excluded from `check`'s verdict.

Production statistical rules remain unchanged. Any narrowing of Stage 2 to exact suspect cells waits for explicit review in `#210`.
