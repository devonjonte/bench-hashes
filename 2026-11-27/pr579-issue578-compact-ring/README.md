# PR #579 (`#578`): Compact zero-`unsafe` `IndexRing` + 32 B `EventRing` (5-host bare-metal gate + diagnostic probes)

## Question
Does replacing the five `40 B` `VecDeque + cap` rings in `Pipeline` (`200 B` inline, introduced in `9e18fda35`) with four `24 B` `IndexRing`s (`Box<[u32]>` + `u32` `head`/`len`, exact capacity, branchless wraparound, no pop write-back) and one `32 B` `EventRing<Event<T, B, P>>` (thin `VecDeque` newtype preserving `Unpin` and single backing-capacity assert) = `128 B` inline (exact two 64 B cache lines, zero `unsafe`) recover the `+5.5%` `x86-avx2` `shared-one-cache / ContinuousMessages / 64 B` regression (#578) with zero regressions across all 5 bare-metal hosts (`4` Linux x86 + Apple M6) and zero regression against `0.11.0`?

## Commits & Command
- `servil-software-factory/bench-hashes`: `3f119a507807078649d8700112994fce24666868`
- `servil-software-factory/BLAKE3` base (`next`): `2557d53c772edfa2f3eeb28b8c8827919a27d608`
- `servil-software-factory/BLAKE3` candidate (PR #579): `7f392fdebc90aa362c7115cceb1824df2319102b`
- `servil-software-factory/BLAKE3` `0.11.0` baseline (probe comparison): `e1966b498bc769db3d51451a4ddc8188a19ed593`
- Command:
  - 4 Linux x86 hosts: `bench-hashes check --fork BLAKE3 --against 2557d53c772edfa2f3eeb28b8c8827919a27d608 --new 7f392fdebc90aa362c7115cceb1824df2319102b --cells all --when-quiet --keep kept-drift` (submitted via `tools/nightly_drift.py`, run `drift-2557d53c-7f392fde-e7488250`).
  - Apple M6 (`mac-m6-timing`): `mac-runner` job `20261127T035025Z-devon-check-pr579-7f392fd-v2` (`--cells all`).

## Verdicts (5/5 bare-metal hosts PASS — `no regression`)
| Host | Hardware | Stage | Verdict | Lifecycle (4096 rooms) |
|---|---|---|---|---|
| `x86-9700x` (`bench-9700x`) | Ryzen 7 9700X (Zen 5) | Stage 2 | **no regression (exit 0)** | `1.13 -> 1.10 ms`; RSS `11.3 -> 11.3 MiB` |
| `x86-epyc-9255` (`electric-rhino`) | EPYC 9255 (Zen 5) | Stage 2 | **no regression (exit 0)** | `2.19 -> 2.09 ms`; RSS `11.9 -> 11.9 MiB` |
| `x86-icelake` (`fast-feedback-icelake-147`) | Xeon Ice Lake | Stage 2 | **no regression (exit 0)** | `6.65 -> 6.57 ms`; RSS `10.0 -> 10.0 MiB` |
| `x86-avx2` (`bench-zen3`) | 2× EPYC 7443 (Zen 3) | Stage 2 | **no regression (exit 0)** | `7.58 -> 8.25 ms`; RSS `10.9 -> 10.9 MiB` |
| `Apple M6` (`mac-m6-timing`) | Apple Silicon M6 | Stage 2 | **no regression** | `1.73 -> 1.72 ms`; RSS `7.4 -> 7.4 MiB` |

### Key `x86-avx2` improvements (`2557d53c772e -> 7f392fdebc90`, Stage 1)
- `blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 B`: `0.685 -> 0.631 ns/unit` (`x0.920`, `-8.0%` faster, `4/4`, instructions `x0.995`)
- `blake3-servil-mt / shared-one-cache / ContinuousMessages / 128 B`: `0.357 -> 0.329 ns/unit` (`x0.923`, `-7.7%` faster, `4/4`, instructions `x0.995`)
- `blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 B`: `0.195 -> 0.184 ns/unit` (`x0.940`, `-6.0%` faster, `4/4`, instructions `x0.996`)
- `blake3-servil-mt / shared-one-cache / ContinuousLentMessages / 64 B`: `0.574 -> 0.557 ns/unit` (`x0.971`, `-2.9%` faster, `3/4`, instructions `x0.995`)
- `blake3-servil-mt / solo / ContinuousMessages / 64 B`: `0.673 -> 0.651 ns/unit` (`x0.968`, `-3.2%` faster, `4/4`)
- `blake3-servil-mt / solo / ContinuousLentMessages / 64 B`: `0.595 -> 0.566 ns/unit` (`x0.952`, `-4.8%` faster, `3/4`)
- `blake3-servil-mt / shared-two-caches / ContinuousLentMessages / 64 B`: `0.635 -> 0.630 ns/unit` (`x0.992`)

## Diagnostic Probes (`probes/`)
- `probes/probe-578-avx2-v2`: round-1 single-struct `Ring<X: Default>` (`120 B` inline) recovered `ContinuousMessages / 64 B` (`-5.5%`), but full `--cells all` caught a `+10.4%` / `+8.9%` `x86-avx2` regression on `ContinuousLentMessages / 64 B`.
- `probes/probe-578-lent-vs-msg`, `probes/probe-578-p1-vs-0110`, and `probes/probe-578-p4-p5-p3`: isolated ring header layout modulo 64 B cache lines on Zen 3 (`200 B` and `136 B` regressed `ContinuousMessages / 64 B` by `+5.4%..+5.5%`; `120 B` — even with `MaybeUninit` in `P5` — regressed `ContinuousLentMessages / 64 B` by `+5.3%..+10.4%`; `P4` = `128 B` [`4 × 24 B IndexRing + 32 B EventRing`, zero `unsafe`] passed `EXIT=0` against `0.11.0` with `shared-one-cache / ContinuousMessages / 64 B` `-2.5%` faster [`9/12`], `ContinuousLentMessages / 64 B` `-4.5%` [`11/12`], `shared-two-caches / ContinuousMessages / 64 B` `-30.9%` [`12/12`], `128 B` `-19.5%` [`12/12`], and `ContinuousLentMessages / 64 B` `-5.4%` [`9/12`]).

## Where Posted
- [servil-software-factory/BLAKE3 #578](https://github.com/servil-software-factory/BLAKE3/issues/578)
- [servil-software-factory/BLAKE3 PR #579](https://github.com/servil-software-factory/BLAKE3/pull/579)
