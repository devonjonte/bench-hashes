# Nightly Cumulative Drift Verification: `0.11.0` -> `7f392fdebc90` (`next`)

## Question
After landing [BLAKE3 PR #579](https://github.com/servil-software-factory/BLAKE3/pull/579) (closing [BLAKE3 #578](https://github.com/servil-software-factory/BLAKE3/issues/578), compact `IndexRing` + 32 B `EventRing`) alongside `de69cb0ba6` (AVX-512 `across_from` cap) and `2557d53c77`, does `servil-software-factory/BLAKE3` `next` (`7f392fdebc90`) pass full `--cells all` cumulative drift checks against `0.11.0` (`e1966b498bc7`) across all 4 bare-metal Linux hosts?

## Commits & Command
- **Baseline (`0.11.0`):** `e1966b498bc769db3d51451a4ddc8188a19ed593`
- **Target (`next`):** `7f392fdebc90aa362c7115cceb1824df2319102b`
- **`bench-hashes`:** `3f119a507807078649d8700112994fce24666868`
- **Command:**
  ```sh
  python3 tools/nightly_drift.py \
    --bench-sha 3f119a507807078649d8700112994fce24666868 \
    --base-sha e1966b498bc769db3d51451a4ddc8188a19ed593 \
    --target-sha 7f392fdebc90aa362c7115cceb1824df2319102b \
    --submit x86-9700x,x86-epyc-9255,x86-avx2,x86-icelake
  ```
- **Job name:** `drift-e1966b49-7f392fde-f01e106b`

## Verdicts (**4/4 bare-metal Linux hosts PASS — no regression**)

| Host | Hardware | Stage | Verdict | Lifecycle (4096 rooms) | Peak RSS | Notable wins vs `0.11.0` |
|---|---|---|---|---|---|---|
| `x86-9700x` | `bench-9700x` (Ryzen 7 9700X, AVX-512) | Stage 2 | **no regression (exit 0)** | `1.06 -> 1.13 ms` | `11.4 -> 11.4 MiB` (level) | `ManyLongMessages\|16` **`-53.3%`** (`st`), **`-53.2%`** (`mt`), insns `-42.4%` |
| `x86-epyc-9255` | `electric-rhino` (EPYC 9255, AVX-512) | Stage 2 | **no regression (exit 0)** | `1.97 -> 2.19 ms` | `11.4 -> 11.4 MiB` (level) | `ManyLongMessages\|16` **`-58.4%`** (`st`), **`-58.3%`** (`mt`); `ContinuousKeyedMessages\|1 MiB` **`-27.9%`**; `OneMessage\|32 KiB` **`-8.6%`** |
| `x86-icelake` | `fast-feedback-icelake-147` (Ice Lake, AVX-512) | Stage 2 | **no regression (exit 0)** | `6.25 -> 6.56 ms` | `11.6 -> 11.6 MiB` (level) | `ManyLongMessages\|16` **`-13.7%`** (`st`, 64/64 faster, insns `-43.3%`) |
| `x86-avx2` | `bench-zen3` (2× EPYC 7443, AVX2) | Stage 2 | **no regression (exit 0)** | `7.95 -> 8.88 ms` | `12.2 -> 12.2 MiB` (level) | **0 cells slower**, **0 level cells instructions > +0.5%** (confirms PR `#579` eliminated `#578` drift vs `0.11.0`) |

## Where Posted
- [servil-software-factory/bench-hashes #241](https://github.com/servil-software-factory/bench-hashes/issues/241)
