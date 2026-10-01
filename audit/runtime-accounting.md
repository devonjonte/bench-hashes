# Runtime order and recorded-accounting checks

First evidence for T1/T5 of [the measurement-trust ledger](measurement-trust.md).
This checks sampled dispatches and recorded work units. Calibration history,
actual internal execution and causal performance validity remain open.

## Reuse the existing trace

The existing `--trace-clocks` CSV records round, position, contender, size,
iterations, elapsed wall time, use case and each shared copy's wall time.
The offline checker uses that trace rather than adding runtime instrumentation
or changing the benchmark's compiled measurement path. Preparation rows remain
separate. The checker implements no clock, speed or samples-file parser.

`tools/check-trace-accounting.py` imports the shared v4 samples reader. It
checks point rotation, recorded dispatch chronology, each participant's
positions, within-visit ordered adjacencies, expected visit counts, exact
wall/work pairs, sample order and solo/shared multiplicity. Explicit round
counts are declared with `--explicit-rounds`: the current samples metadata
records N but does not distinguish the every-round CLI mode from defaults.
The frozen unit contract supplies bytes per message (64), units and participants.

| Retained run | Dispatch rows | Sample cells | Complete balanced points |
| --- | ---: | ---: | ---: |
| ba4a327 full, eight contenders | 15420 | 1296 | 139 |
| ba4a327 quick, eight contenders | 7536 | 720 | 100 |
| ae52af3 default quick | 4656 | 472 | 100 |
| d772be9 clean ABBA, each of four runs | 4656 | 131 | 35 |

All seven pass; no partial design occurs in these runs. The full control's
139 points cover differing participation sets. Trace/sample accounting is
exact, including each shared copy and the msg-versus-byte denominators.
These checks compare two outputs of the same instrument and establish their
agreement at this scope. Independent actual-work checks are still required.

Williams balance is checked **within each point's visits**. Across visit
boundaries and different points, predecessor counts differ; the JSON output
retains them as dispatch-unit counts, not a CPU/core execution trace. A row
includes solo and possibly shared work; it does not trace internal hash calls,
per-core scheduling or calibration. Empirical carryover remains an open task.

## Shared reader: preserve the measured work and reject duplicate cells

The existing reader reduced `128/64` to `Fraction(2, 1)`, which is appropriate
for speed comparisons but loses the raw elapsed time and work count. The
proposed reader additionally retains `run.measured[key] = [(ns, units), ...]`.
For accounting, even `256/128` must stay distinct from `128/64`.

A malformed v4 file with the same cell twice silently overwrote its first row.
The proposed reader rejects that duplicate, identical or different, and
checks nonnegative time over positive work. This is a demonstrated reader
contract defect, with **no duplicates found in 47 retained v4 files**; there
is no evidence here that it caused the historical measurements to be wrong.
The format stays v4 and existing ratio APIs keep their values.

Four reader tests pass. Four checker tests exercise a known two-participant
complete design and reject wrong iterations, elapsed time, row position,
missing dispatches, reordered participants, and a raw ns/work corruption that
keeps the normalized ratio unchanged. The unchanged Rust hashing code also
passed the required diagnostic check; that passing verdict is recorded as a
procedural result, rather than measurement validation.

## Reproduce

Use the proposed shared reader in `devonjonte/BLAKE3` branch
`candidate/devon-sample-accounting`, and the measured commits' retained files.
The checker assumes the current frozen points and participation contract.

```sh
PYTHONDONTWRITEBYTECODE=1 python3 tools/check-trace-accounting.py SAMPLES TRACE --reader /path/to/BLAKE3/tools/samples.py
PYTHONDONTWRITEBYTECODE=1 python3 tools/check-trace-accounting.py SAMPLES TRACE --reader /path/to/BLAKE3/tools/samples.py --explicit-rounds
BENCH_SAMPLES_READER=/path/to/BLAKE3/tools/samples.py PYTHONDONTWRITEBYTECODE=1 python3 tools/test-trace-accounting.py
PYTHONDONTWRITEBYTECODE=1 python3 /path/to/BLAKE3/tools/test_samples.py
```

Apply an external process-group deadline to test commands. Historical files
stay unchanged. Next: predeclared exact-artifact nulls, actual-work controls,
carryover, shared statistics and maintainer review.
