# Nightly cumulative-drift check: `0.11.0` (`e1966b498bc7`) -> `87a0ab4b9f3c` (with bisects)

## Question
Did cumulative changes on `servil-software-factory/BLAKE3` `next` between release `0.11.0` (`e1966b498bc769db3d51451a4ddc8188a19ed593`) and `87a0ab4b9f3cebfa30a791993573bfb4b128ae4e` (after PR #567 place-wake, B1/B2/B3 `def5e11ef`, `VecDeque Ring` `9e18fda35`, `d332acb52`, and `b3sum` split) regress any cell across the four bare-metal Linux measurement hosts under `bench-hashes@3f119a507807078649d8700112994fce24666868` (`--cells all`, including the new `Packed<48>` MerkleTree cells)?

## Commits & Command
- `servil-software-factory/bench-hashes`: `3f119a507807078649d8700112994fce24666868`
- `servil-software-factory/BLAKE3` base (`0.11.0`): `e1966b498bc769db3d51451a4ddc8188a19ed593`
- `servil-software-factory/BLAKE3` target: `87a0ab4b9f3cebfa30a791993573bfb4b128ae4e`
- Additional bisect commits: `b308ba41dc6cbddb7f259bf847611850485a6fd3`, `6618a609b1fc018302b0115f269c1e7d7fc68669`, `def5e11eff984a4be4249fbdd10ff3901c5df648`, `9e18fda35a9b992e682516dee2146f51959ff5b0`, `d332acb52bd38ed2f758087efca2e5d520db7c2d`, `093de3aedf3ff528f233655358996be9dc11fdc7`
- Command:
  ```sh
  python3 tools/nightly_drift.py \
    --bench-sha 3f119a507807078649d8700112994fce24666868 \
    --base-sha e1966b498bc769db3d51451a4ddc8188a19ed593 \
    --target-sha 87a0ab4b9f3cebfa30a791993573bfb4b128ae4e \
    --submit x86-9700x,x86-epyc-9255,x86-avx2,x86-icelake
  ```

## Verdicts
| Host | Hardware | Deciding stage | Verdict | Key cells |
|---|---|---|---|---|
| `x86-9700x` (`bench-9700x`) | Ryzen 7 9700X (Zen 5) | Stage 2 (64p) | **no regression (exit 0)** | All cells level or faster; lifecycle RSS `11.8 -> 11.8 MiB` |
| `x86-icelake` (`fast-feedback-icelake-147`) | Xeon Ice Lake | Stage 2 (64p) | **no regression (exit 0)** | All cells level or faster; lifecycle RSS `10.9 -> 10.9 MiB` |
| `x86-avx2` (`bench-zen3`) | 2× EPYC 7443 (Zen 3) | Stage 2 (64p) | **REGRESSION (exit 1)** | `blake3-servil-mt\|shared-one-cache\|ContinuousMessages\|64 B`: **SLOWER `+5.5%`** (`0.680 -> 0.717 ns/unit`, `9/64` faster, cycles `+5.5%`, instructions `-2.1%`, cache misses `+6.7%`); `128 B` `x1.041` (`18/64`), `256 B` `x1.042` (`19/64`); `shared-two-caches\|64 B` faster `-30.3%` (`59/64`) |
| `x86-epyc-9255` (`electric-rhino`) | EPYC 9255 (Zen 5) | Stage 2 (64p) | **REGRESSION (exit 1)** (cleared by bisect as #69) | `blake3-servil-st\|solo\|ManyMessages\|8`: `+11.0%` (`24/64`, instructions `-0.3%`, bimodal state mix); all other cells level/faster (`shared-two-caches\|64 B` `-23.6%`, `shared-one-cache\|64 B` `x0.998`) |

## Bisect Findings
1. **`x86-avx2` (`bisect-avx2-drift-64b/` + `bisect-avx2-leg3/`, 16 pairs/leg):**
   - `e1966b49 -> b308ba41` (pre-PR #567): level (`shared-one-cache\|64 B` `x0.984`).
   - `b308ba41 -> 6618a609` (PR #567 `wake_if_place_asleep`): level (`shared-one-cache\|64 B` `x0.989`, `128 B` `x0.984`; `shared-two-caches\|64 B` faster `-25.6%`, `15/16`).
   - `6618a609 -> 9e18fda3` (`def5e11ef` + `9e18fda35`): **REGRESSION on 3 cells** (`shared-one-cache\|64 B` **SLOWER `+8.1%`** `1/16`, `128 B` **SLOWER `+6.0%`** `4/16`, `shared-two-caches\|128 B` **SLOWER `+17.4%`** `1/16`, `instructions +0.5%`).
   - Split of `6618a609 -> 9e18fda3` (`bisect-avx2-leg3/`):
     - `6618a609 -> def5e11ef`: level (`shared-one-cache\|64 B` `x1.010` `10/16`, `instructions x1.000`).
     - **`def5e11ef -> 9e18fda35` (`threads: safe VecDeque Ring and roomless zero PieceNodes`):** **`shared-one-cache\|64 B` `x1.041` (`3/16` faster, `cycles x1.041`, `instructions x1.005`), `128 B` `x1.038` (`4/16`, `cycles x1.037`, `instructions x1.004`), `256 B` `x1.012` (`4/16`, `instructions x1.005`)** — isolates the cumulative regression to `9e18fda35` (`+40 B` inline `Pipeline` growth across 5 `VecDeque` rings + double `assert!` in `Ring::push_back`).
   - `9e18fda3 -> 87a0ab4b`: level across all 9 cells (`instructions x1.000`).
2. **`x86-epyc-9255` (`bisect-epyc-many8/`, 32 pairs/leg on `blake3-servil-st\|8`):**
   - `e1966b49 -> 6618a609`: `x0.945` (`18/32`, level).
   - `6618a609 -> def5e11ef`: `x0.983` (`18/32`, level).
   - `def5e11ef -> d332acb52`: `x0.987` (`16/32`, level).
   - `e1966b49 -> 093de3aed` (current `next` incl. `de69cb0ba`): `x0.967` (`17/32`, level).
   - Confirms zero code regression in `ManyMessages / 8`; the full-run Stage-2 spike was `bench-hashes#69` bimodal process state on EPYC.

## Where Posted
- `servil-software-factory/bench-hashes#241`
- Follow-up regression issue on `servil-software-factory/BLAKE3`
