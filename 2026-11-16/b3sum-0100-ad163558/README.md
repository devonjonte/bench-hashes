# `b3sum` at `0.10.0` baseline `ad163558` across six x86-64 Linux hosts (`BLAKE3 #402`)

## Question

How does `b3sum` at `ad163558bd882ca7768e59764c6588fce0f285f9` (`0.10.0+4e8634b71df01d406906025b4ccda17a828a2aa7`, including `9de026af`'s reader-thread ramp and `30602666`'s redirected-file path) perform beside `0.9.0` (`bf2da8b9`), `0.8.0` (`b5b988d8`), and official `b3sum` `1.8.7` across both the full 10-input suite and the `--quick` suite (`100 x 16 KiB`)?

Tracked in [BLAKE3 #402 (0.10.0 measured evidence)](https://github.com/servil-software-factory/BLAKE3/issues/402). Per John's update on [#402](https://github.com/servil-software-factory/BLAKE3/issues/402) and [#433](https://github.com/servil-software-factory/BLAKE3/issues/433), `ad163558` is baseline pre-remediation evidence; the final `0.10.0` candidate will be re-measured after the audit dispositions land.

## Commits and command

- `b3sum-0.9.0` (base): `bf2da8b957f5e0c80babb57952de3e53f95c921a` (`0.9.0+73ee859efce085d28f1c2b22c35a5703403476f7`)
- `b3sum-0.8.0`: `b5b988d8982bea9490c38c79ec4b8c5c2428270c` (`0.8.0+b3c5efc7c975d903762dea809066f7c0a0603861`)
- `b3sum-0.10.0`: `ad163558bd882ca7768e59764c6588fce0f285f9` (`0.10.0+4e8634b71df01d406906025b4ccda17a828a2aa7`)
- `official`: crates.io `b3sum 1.8.7`
- Benchmark harness: `bench-hashes` `cade30fdb71682719f5fa3e586ff96146ae9fc25` (`v0.23.0+ba147639c35454e648847adbb08e2435e450493e`), running four fresh link layouts per BLAKE3-Servil contender (`run.sh` in each host folder).

## Full 10-input suite (`b3sum-full.stdout.txt`, 10 rounds)

### `b3sum-0.10.0` against `b3sum-0.9.0` (warm)

| input | `x86-epyc-9275f` | `x86-epyc-9255` | `x86-9700x` | `x86-icelake` | `x86-icelake-2` | `x86-avx2` |
|---|---:|---:|---:|---:|---:|---:|
| 4 KiB | ×0.987 | ×1.047 | ×1.018 | ×1.042 | ×1.008 | **×0.880** (faster) |
| 64 KiB | ×1.032 | ×1.085 | ×0.979 | **×1.044** (slower) | **×1.034** (slower) | ×0.964 |
| 1 MiB | **×0.784** (faster) | **×0.808** (faster) | **×0.931** (faster) | ×0.970 | ×0.940 | **×0.786** (faster) |
| 16 MiB | ×1.012 | ×1.037 | ×1.048 | ×0.989 | ×0.984 | ×1.037 |
| 256 MiB | ×1.001 | ×0.976 | ×1.007 | ×0.995 | ×1.007 | ×0.962 |
| 1 GiB | ×0.977 | ×1.012 | ×0.965 | ×1.004 | ×0.996 | ×0.956 |
| 1000 x 16 KiB | **×0.866** (faster) | **×0.865** (faster) | **×0.841** (faster) | **×0.799** (faster) | **×0.814** (faster) | **×0.864** (faster) |
| 1000 x 16 KiB, a process each | ×1.013 | ×1.011 | ×1.012 | **×1.039** (slower) | **×1.041** (slower) | ×0.988 |
| mixed tree, 1000 files, 74 MiB | ×0.898 | **×0.845** (faster) | ×0.936 | **×0.873** (faster) | **×0.895** (faster) | ×1.020 |
| 16 x 64 MiB | **×0.664** (faster) | **×0.697** (faster) | ×0.924 | **×0.700** (faster) | **×0.724** (faster) | **×0.558** (faster) |

### `b3sum-0.10.0` against `b3sum-0.9.0` (cold)

| input | `x86-epyc-9275f` | `x86-epyc-9255` | `x86-9700x` | `x86-icelake` | `x86-icelake-2` | `x86-avx2` |
|---|---:|---:|---:|---:|---:|---:|
| 4 KiB | ×1.042 | ×1.051 | ×1.004 | ×1.032 | ×0.976 | ×0.949 |
| 64 KiB | ×1.044 | ×0.993 | ×0.984 | ×1.058 | **×1.055** (slower) | ×1.027 |
| 1 MiB | ×1.041 | **×1.085** (slower) | ×1.004 | **×1.050** (slower) | ×1.002 | ×1.122 |
| 16 MiB | **×0.807** (faster) | **×0.689** (faster) | **×0.822** (faster) | **×0.788** (faster) | **×0.843** (faster) | **×0.806** (faster) |
| 256 MiB | **×0.666** (faster) | **×0.746** (faster) | **×0.598** (faster) | **×0.677** (faster) | **×0.814** (faster) | **×0.617** (faster) |
| 1 GiB | **×0.644** (faster) | **×0.766** (faster) | **×0.544** (faster) | **×0.640** (faster) | **×0.807** (faster) | **×0.532** (faster) |
| 1000 x 16 KiB | **×0.934** (faster) | **×0.962** (faster) | **×0.540** (faster) | ×0.994 | **×0.955** (faster) | **×1.060** (slower) |
| 1000 x 16 KiB, a process each | ×1.018 | ×1.013 | ×1.007 | **×1.036** (slower) | **×1.034** (slower) | ×0.993 |
| mixed tree, 1000 files, 74 MiB | **×0.790** (faster) | **×0.845** (faster) | **×0.706** (faster) | ×1.024 | ×1.006 | ×0.989 |
| 16 x 64 MiB | **×0.699** (faster) | **×0.759** (faster) | **×0.687** (faster) | **×0.708** (faster) | **×0.805** (faster) | **×0.630** (faster) |


## Quick 7-input suite (`b3sum-quick.stdout.txt`, 5 rounds — includes `100 x 16 KiB`)

### `b3sum-0.10.0` against `b3sum-0.9.0` (warm)

| input | `x86-epyc-9275f` | `x86-epyc-9255` | `x86-9700x` | `x86-icelake` | `x86-icelake-2` | `x86-avx2` |
|---|---:|---:|---:|---:|---:|---:|
| 4 KiB | ×1.057 | ×0.950 | ×0.931 | ×1.006 | ×1.020 | ×0.882 |
| 1 MiB | **×0.794** (faster) | ×0.873 | ×0.933 | **×0.904** (faster) | **×0.922** (faster) | ×0.909 |
| 16 MiB | ×1.012 | ×0.994 | ×0.936 | ×1.033 | ×0.981 | ×1.150 |
| 100 x 16 KiB | ×1.075 | ×1.023 | **×1.084** (slower) | **×1.073** (slower) | **×1.061** (slower) | ×1.049 |
| 100 x 16 KiB, a process each | ×1.020 | ×1.023 | ×1.023 | ×1.043 | **×1.040** (slower) | ×1.013 |
| mixed tree, 100 files, 5 MiB | ×0.943 | ×1.002 | ×0.890 | ×0.964 | ×0.961 | ×0.976 |
| 4 x 16 MiB | **×0.628** (faster) | ×0.695 | ×1.015 | **×0.570** (faster) | **×0.574** (faster) | ×0.752 |

### `b3sum-0.10.0` against `b3sum-0.9.0` (cold)

| input | `x86-epyc-9275f` | `x86-epyc-9255` | `x86-9700x` | `x86-icelake` | `x86-icelake-2` | `x86-avx2` |
|---|---:|---:|---:|---:|---:|---:|
| 4 KiB | ×1.002 | ×1.021 | ×1.010 | ×1.001 | ×0.986 | ×0.925 |
| 1 MiB | ×1.062 | ×0.995 | ×0.993 | ×0.950 | ×1.013 | **×0.824** (faster) |
| 16 MiB | ×0.807 | **×0.689** (faster) | **×0.883** (faster) | **×0.789** (faster) | **×0.838** (faster) | ×0.872 |
| 100 x 16 KiB | ×1.172 | ×0.936 | ×0.600 | **×1.302** (slower) | **×1.288** (slower) | ×1.119 |
| 100 x 16 KiB, a process each | ×1.053 | ×0.999 | ×0.998 | **×1.038** (slower) | **×1.033** (slower) | ×1.026 |
| mixed tree, 100 files, 5 MiB | ×1.044 | ×0.967 | ×0.947 | ×1.117 | ×1.081 | ×0.923 |
| 4 x 16 MiB | **×0.593** (faster) | **×0.554** (faster) | **×0.628** (faster) | **×0.683** (faster) | **×0.678** (faster) | **×0.567** (faster) |


## Summary of findings

1. Against official `b3sum 1.8.7`, `b3sum-0.10.0` (`ad163558`) is faster on every measured input, warm and cold, on all six Linux machines in both suites.
2. Against `b3sum-0.9.0` on the full suite:
   - Faster on all six machines for warm `1000 x 16 KiB` (`×0.80–×0.87`) and cold `16 MiB` (`×0.69–×0.84`), `256 MiB` (`×0.60–×0.81`), `1 GiB` (`×0.53–×0.81`), and `16 x 64 MiB` (`×0.63–×0.81`), and on five of six for warm `16 x 64 MiB` (`×0.56–×0.92`).
   - Cold `1000 x 16 KiB` is faster on four machines (`×0.54–×0.96`), level on `x86-icelake` (`×0.994`), and `×1.060` slower on `x86-avx2` (`10.2 -> 10.8 ms`, [#403](https://github.com/servil-software-factory/BLAKE3/issues/403)).
   - Both Ice Lake Xeon pairs (`x86-icelake`, `x86-icelake-2`) mark single-process startup rows slower against `0.9.0`: `1000 x 16 KiB, a process each` (`×1.039` and `×1.041` warm; `×1.036` and `×1.034` cold) and `64 KiB` (`×1.044` and `×1.034` warm; `×1.055` cold on `icelake-2`), alongside cold `1 MiB` on `x86-epyc-9255` (`×1.085`) and `x86-icelake` (`×1.050`).
3. On `--quick`'s `100 x 16 KiB` row (where `9de026af` uses 5 reader threads), `ad163558` against `0.9.0` still reads slower cold on both Ice Lake Xeon pairs (`×1.302` and `×1.288`, `2.0 -> 2.6 ms`, keeping `2.9–3.0` CPUs busy against `0.9.0`'s `4.7` CPUs) and warm on `x86-9700x` (`×1.084`), `x86-icelake` (`×1.073`), and `x86-icelake-2` (`×1.061`).
