# Issue #556 direct recovery check: 0.10.0 vs next (post-PR #558)

- **Question:** After landing [BLAKE3 PR #558](https://github.com/servil-software-factory/BLAKE3/pull/558) (`f1f7002d094fab6ead1bf7200fe25ab394fe38f1`) on `next`, how do the three `#556` bare-metal x86 edge cells compare directly against `0.10.0` (`2fd4ff6f643ef04f98f7a2e5f8ca0f096298827a`)?
- **Benchmark:** `servil-software-factory/bench-hashes@81c3529ecb58bf1a44075424d9fd32cb6b5c4303` (same bench on both sides; last commit before `ContinuousKeyedMessages` added `Pipeline::message_with`, which did not exist in `0.10.0`).
- **Command:** `bench-hashes check --against 2fd4ff6f643ef04f98f7a2e5f8ca0f096298827a --new f1f7002d094fab6ead1bf7200fe25ab394fe38f1 --probe ... --layouts ... --contenders blake3-servil-mt --when-quiet`
- **Verdict:**
  - **2x Xeon Gold 6330 (`solo|ContinuousMessages|4 KiB`, 8 pairs):** `0.0936 -> 0.0939 ns/unit` (`x1.003` level, CPU `x0.997`) — **recovered** from `+5.8%`. (`shared-one-cache|4 KiB` `x1.011` level.)
  - **AMD EPYC 9255 (`solo|ContinuousBatches|1024`, 16 pairs):** `2.313 -> 2.380 ns/unit` (`x1.029` level, CPU `x0.999`) — **recovered to level** from `+6.1%`. (`shared-one-cache` `x1.016` level; `shared-two-caches` `x1.024` level.)
  - **2x AMD EPYC 7443 (`shared-two-caches|ContinuousMessages|64 B`, 16 pairs):** `1.157 -> 1.464 ns/unit` (`+26.6%` slower, `0/16` pairs faster; `cycles +25.5%`, `instructions +1.3%`, `cache misses +0.0%`) — **remains open** (`solo|64 B` `0.691 -> 0.691` `x1.000`, `shared-one-cache|64 B` `x1.044` level).
- **Posted on:** [servil-software-factory/BLAKE3#556](https://github.com/servil-software-factory/BLAKE3/issues/556)

## File hashes (SHA-256 + BLAKE3)

| File | SHA-256 | BLAKE3 |
| --- | --- | --- |
| `avx2-check.txt` | `4c7c348392d8f32baf01c5a1a76fa9429c62d38773ce24aac3e74b09d34c74a6` | `df7636c85bf87ad9ef53317e893af56c3b8750c5599605a0bd2f4e516e362b8a` |
| `icelake-check.txt` | `0fda5116b060ee4a4e24edaea72fc466fe4f82e6f6549df11dc500c30cc2ee1d` | `df922c3b6d6c537e0130fa735a4f86a7e69f9bd7b38de82df1970fec752b7fa6` |
| `epyc9255-check.txt` | `6d09bfc33e14361eab7f5b34b120e37683772ac257d5d0fcb75cb476cda2ae84` | `02f24e486792ee79eb34e7022a6338a0e9cdec38375e3302eef09b08b5c65cf8` |
