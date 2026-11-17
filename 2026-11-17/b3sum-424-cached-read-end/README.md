# `b3sum`: cost of ending cached page-multiple files with a zero read (BLAKE3 #424)

For [BLAKE3 #424](https://github.com/servil-software-factory/BLAKE3/issues/424), November 17, 2026. Devon Jonte.

Compares John's `a17ad8d19fc5a2a0bfb57b917eb578c4a91befc1` (`candidate/b3sum-fail-stop`) against [`c1a93ec3a77f602c3c16d5914949a608f768d094`](https://github.com/devonjonte/BLAKE3/commit/c1a93ec3a77f602c3c16d5914949a608f768d094) (`candidate/devon-424-cached-read-end`), which keeps `try_pread_cached`'s size-hint shortcut only when `hint` is not a multiple of the page size. Measured with `bench-hashes 0.23.0` (`cade30fdb71682719f5fa3e586ff96146ae9fc25`), 4 layouts a side, 15 full rounds and 5 `--quick` rounds.

**Declared expectation (in `run.sh`):** warm `1000 x 16 KiB` and `100 x 16 KiB` (whose files are whole pages) up to 5% longer; every other input level.

**Result:** no input on either host (full or quick, warm or cold) is marked slower or faster.

| Host | Warm `1000 x 16 KiB` | Warm `100 x 16 KiB` (`--quick`) |
|---|---|---|
| `x86-9700x` (Ryzen 7 9700X) | `1.53 -> 1.63 ms` (`×1.047`, level) | `549 -> 555 µs` (`×1.010`, level) |
| `x86-epyc-9275f` (EPYC 9275F) | `2.78 -> 2.59 ms` (`×0.950`, level) | `917 -> 907 µs` (`×0.987`, level) |
