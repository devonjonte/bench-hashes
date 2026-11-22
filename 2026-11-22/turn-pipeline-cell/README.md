# bench-hashes #258: the Pipeline in the multithreaded turn cells (November 22, 2026)

**Question.** Moving BLAKE3-Servil mt's four turn use cases (`InterleavedTurn` and its gap twins) from `update_each_multithreaded` to `throughput::Pipeline` (a 64 KiB Room per open message): what changes across every cell, and is any other cell disturbed?

**Verdict.** On both machines, mt's `1024 x 1 KiB` turn cells drop by 82% to 88% in wall time (6× to 9× faster). On the `256` mixed-length schedule (256 KiB bursts), mt reads level to 20% slower depending on the gap (+17.3% on the 9700X after 20 μs idle over 64 pairs; +20.0% on the EPYC 9255 after other work over 4 pairs; −6.1% faster on the 9700X after other work over 64 pairs). No other multithreaded cell is slower.

**Neighbour effect on `blake3-servil-st`.** In `st`'s own unchanged code, `BriefIdleInterleavedTurn|256` reads +7.3% slower on the 9700X (64 pairs) beside the new mt contender, and `IdleInterleavedTurn|256` read +8.0% slower on the EPYC 9255 in the 3-pair probe (not marked in the all-cells gate). Run alone in the process (`st-alone-53f2cef9`), `st` reads level under both benches on both machines (within 1.6% on the 9700X, within 0.6% on the EPYC 9255). The old mt contender shared `st`'s `STREAM_BUFFER` and left it warm in cache; the new mt contender runs a `Pipeline` over other memory. `METHODOLOGY.md` and `FROZEN.md` record this.

| Machine | Run | Notable cells (old bench `ed3688ca` → candidate `53f2cef9`, library `2fd4ff6f` both sides) |
|---|---|---|
| `x86-9700x` | `cell-probe-53f2cef9` (3 pairs, 6 turn points) | mt `1024 x 1 KiB` ×0.160 / ×0.131 / ×0.127; mt `256` ×0.965 / ×0.873 / ×1.229; st `256` brief idle ×1.076 |
| `x86-9700x` | `st-alone-53f2cef9` (3 pairs, st alone) | no cell slower (×0.994 / ×0.985 / ×1.016) |
| `x86-9700x` | `gate-53f2cef9` (all cells, 4 + 64 pairs) | mt `1024 x 1 KiB` −82.4% / −82.8% / −82.9%; mt `256` other work −6.1% (64 pairs), brief idle +17.3% (64 pairs); st `256` brief idle +7.3% (64 pairs); no level cell's instructions moved |
| `x86-epyc-9255` | `cell-probe-53f2cef9` (3 pairs, 6 turn points) | mt `1024 x 1 KiB` ×0.135 / ×0.117 / ×0.113; mt `256` ×1.051 / ×0.956 / ×1.066; st `256` idle ×1.080 |
| `x86-epyc-9255` | `st-alone-53f2cef9` (3 pairs, st alone) | no cell slower (×0.994 / ×1.006 / ×1.003) |
| `x86-epyc-9255` | `gate-53f2cef9` (all cells, 4 pairs) | mt `1024 x 1 KiB` −86.7% / −87.4% / −87.7%; mt `256` other work +20.0%; all other cells level |

**Commits.** Old bench: `ed3688caff37d28d8519aab9b125001b26e5402e`. Candidate bench measured: `53f2cef9a34a` (`candidate/devon-pipeline-turn`). Library on both sides: BLAKE3-Servil 0.10.0 `2fd4ff6f643ef04f98f7a2e5f8ca0f096298827a`.

**Posted:** [bench-hashes #258](https://github.com/servil-software-factory/bench-hashes/issues/258) and [BLAKE3 #470](https://github.com/servil-software-factory/BLAKE3/issues/470).
