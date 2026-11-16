# Zen 5 servers: 256 B, 512 B, and 1 KiB one-message checks (`BLAKE3 #405`)

## Question

Do the `256 B` and `512 B` `OneMessage` slowdowns seen earlier on Zen 5 servers repeat at the `0.10.0` baseline commit `ad163558bd882ca7768e59764c6588fce0f285f9` against `0.9.0` (`bf2da8b957f5e0c80babb57952de3e53f95c921a`), and how much comes from the benchmark binary or link layout?

Tracked in [BLAKE3 #405 — Zen 5 servers: one message of 256 B and 512 B reads slower at the 0.10 candidate than at 0.9.0](https://github.com/servil-software-factory/BLAKE3/issues/405).

## Commits and command

- New library: `ad163558bd882ca7768e59764c6588fce0f285f9` (`release/0.10.0`, code parent `4e8634b71df01d406906025b4ccda17a828a2aa7`) under `bench-hashes` `cade30fdb71682719f5fa3e586ff96146ae9fc25` (`v0.23.0`).
- Old library: `bf2da8b957f5e0c80babb57952de3e53f95c921a` (`v0.9.0`) under `--old-bench d7723f110a6f519cccb2e4ab8f2a18be7a4f4d41` (`v0.22.0`). `bench-hashes 0.23` calls `0.10`'s `Pipeline`, so comparing against `0.9.0` uses `--old-bench` alongside a same-library control arm (`ad163558` under both benches).
- Command on `x86-epyc-9255` and `x86-epyc-9275f` (`run.sh` in each host folder):

```sh
./target/release/bench-hashes check --fork "$M" --new ad163558bd882ca7768e59764c6588fce0f285f9 \
    --against "$AGAINST" --old-bench d7723f110a6f519cccb2e4ab8f2a18be7a4f4d41 \
    --points '256 B,512 B,1 KiB' --when-quiet --keep "$O/kept-$ARM"
```

Three arms ran back to back on each server: `release` (`0.9.0 -> ad163558`), `control` (`ad163558 -> ad163558` across `--old-bench d7723f11`), and `release-again` (`0.9.0 -> ad163558`).

## Results

### EPYC 9275F (`x86-epyc-9275f`)

All three arms exited `0` (`no cell slower`), including 64-pair second-stage runs on both `release` and `control`:

| Arm | Pairs | `st 256 B` | `st 512 B` | `st 1 KiB` | `mt 256 B` | `mt 512 B` | `mt 1 KiB` | Verdict |
|---|---:|---|---|---|---|---|---|---|
| `release` (stage 2) | 64 | `2.204 -> 2.253` (`x1.022`) | `1.751 -> 1.769` (`x1.010`) | `1.510 -> 1.524` (`x1.009`) | `2.405 -> 2.441` (`x1.015`) | `1.810 -> 1.818` (`x1.004`) | `1.548 -> 1.552` (`x1.003`) | level |
| `control` (stage 2) | 64 | `2.078 -> 2.117` (`x1.018`) | stage 1 `x1.000` | stage 1 `x1.006` | stage 1 `x0.990` | stage 1 `x0.946` | stage 1 `x0.991` | level |
| `release-again` | 4 | `2.142 -> 2.132` (`x0.995`) | `1.708 -> 1.727` (`x1.011`) | `1.486 -> 1.482` (`x0.997`) | `2.247 -> 2.226` (`x0.991`) | `1.750 -> 1.787` (`x1.021`) | `1.501 -> 1.523` (`x1.015`) | level |

The separate every-cell check (`release-0100-follow`, `--cells all`) also read all `256 B`, `512 B`, and `1 KiB` `OneMessage` cells level on EPYC 9275F.

### EPYC 9255 (`x86-epyc-9255`)

Retired instructions and CPU frequency match across `0.9.0` and `ad163558` (`st 256 B`: `9.66` vs `9.65` ins/B at `4.34 GHz`; `st 512 B`: `7.86` vs `7.87` ins/B at `4.34 GHz`). Across 4 random function-order link layouts per check, `release` read `st 256 B` faster (`-5.7%`) and `release-again` read four cells slower (`+5.9%` to `+9.0%`) when `old` drew four high-IPC link layouts (`2.246 ns/B` vs `2.560 ns/B` in `release`, while `new` held steady at `2.448` vs `2.415 ns/B`). Over all 8 fresh-layout pairs combined (`bench-hashes compare`), every cell reads level:

| Arm | Pairs | `st 256 B` | `st 512 B` | `st 1 KiB` | `mt 256 B` | `mt 512 B` | `mt 1 KiB` | Verdict |
|---|---:|---|---|---|---|---|---|---|
| `release` | 4 | `2.560 -> 2.415` (`x0.943` faster) | `1.990 -> 1.898` (`x0.953`) | `1.685 -> 1.653` (`x0.981`) | `2.693 -> 2.526` (`x0.938`) | `1.985 -> 1.997` (`x1.006`) | `1.711 -> 1.675` (`x0.979`) | no cell slower |
| `control` | 4 | `2.509 -> 2.411` (`x0.961`) | `1.950 -> 1.931` (`x0.990`) | `1.711 -> 1.655` (`x0.967`) | `2.712 -> 2.703` (`x0.997`) | `2.061 -> 2.065` (`x1.002`) | `1.710 -> 1.714` (`x1.003`) | level |
| `release-again` | 4 | `2.246 -> 2.448` (`x1.090` slower) | `1.860 -> 1.964` (`x1.056`) | `1.589 -> 1.709` (`x1.076` slower) | `2.434 -> 2.637` (`x1.083`) | `1.902 -> 2.044` (`x1.075` slower) | `1.642 -> 1.740` (`x1.059` slower) | 4 cells slower |
| `release` + `release-again` | 8 | `2.398 -> 2.432` (`x1.014`, 4/8) | `1.924 -> 1.931` (`x1.003`, 4/8) | `1.636 -> 1.681` (`x1.027`, 2/8) | `2.560 -> 2.581` (`x1.008`, 4/8) | `1.943 -> 2.021` (`x1.040`, 3/8) | `1.676 -> 1.707` (`x1.019`, 4/8) | all 6 level |

The separate every-cell check (`release-0100-follow`, `--cells all`) also read all `256 B`, `512 B`, and `1 KiB` `OneMessage` cells level on EPYC 9255.

## Verdict

EPYC 9275F passes across 64 fresh-layout pairs (`x1.003` to `x1.022`, level). On EPYC 9255, retired instructions and clocks are unchanged, 4-layout checks swing in both directions (`-5.7%` faster and `+9.0%` slower on `st 256 B`) from Zen 5 link-layout IPC variation (`0.61–0.83`), and the combined 8-pair comparison and full `--cells all` check read all six cells level. Posted on [BLAKE3 #405](https://github.com/servil-software-factory/BLAKE3/issues/405) for John's disposition.
