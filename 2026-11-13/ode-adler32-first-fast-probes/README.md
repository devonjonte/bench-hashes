# First native Adler-32 algorithm probes, November 13, 2026

Can a different vector reduction design earn the cost of implementing and
proving a competitive Adler-32 function in Ode?

**The optimized probes are UNVERIFIED native C.** The original scalar Ode
checksum still has its machine theorem. These measurements select designs;
they establish neither an optimized machine theorem nor a fastest-known result.
[The goal and remaining work](https://github.com/servil-software-factory/BLAKE3/issues/377).

## What the complete table says

At 64-byte-aligned inputs, the four-prefix 512-bit probe beats the ordinary
libdeflate dispatcher in the Xeon bulk cells. At offset-one inputs, its 64 KiB
and 1 MiB calls lose. Those regressions belong to the candidate's design work.
EPYC bulk is mostly level. Several small-input cells also lose on both CPUs.
A single prefix accumulator usually loses to four.

| CPU | bytes | offset | libdeflate ns | four-prefix 512 ns | new/old permille | judgment |
|---|---:|---:|---:|---:|---:|---|
| Xeon 6330 | 4096 | 0 | 100.55 | 67.86 | 672 | faster |
| Xeon 6330 | 65536 | 0 | 1565.07 | 912.14 | 583 | faster |
| Xeon 6330 | 1048576 | 0 | 25923.38 | 15497.33 | 608 | faster |
| Xeon 6330 | 65536 | 1 | 1586.45 | 2010.10 | 1265 | slower |
| Xeon 6330 | 1048576 | 1 | 25698.85 | 32965.48 | 1285 | slower |

Times are medians of per-run means. The new/old column is the paired geometric
ratio judged by the shared rule; it need not equal the ratio of displayed times.
The complete 16-cell tables for every contender, including small costs, are in
`comparison-*.tsv` in each final `ode-adler-fast-probe3` directory.

**Attribution remains open:** libdeflate deliberately prefers 256-bit vectors
on Ice Lake. Its existing internal 512-bit kernel must be compared before the
aligned gain can be attributed to the algorithm. Libdeflate's release build
uses -O2 here; the probes use -O3. The first runs could not observe the selected
function pointer (`dispatch.txt`). A direct-kernel control and actual pointer
record are the next experiment, declared in source `08b870ad` before collection.

## Sources, commands and workload

The final series uses experiment
[`64c4e525b12daeb2763408b10d1606dbde4eb2f3`](https://github.com/devonjonte/BLAKE3/commit/64c4e525b12daeb2763408b10d1606dbde4eb2f3).
Each delivered `run.sh` records the complete build/validation/collection commands.
Each sample file embeds the report, source-file digests, compiler, address,
layout padding, load windows and counter availability.

- Shared clocks: bench-hashes `5f99f456951ab36f7201decd8aa5e0249ec67bd1`.
- Libdeflate 1.26: `92e6a0db9fa848d742f9eb286c92afc60f2c3dda`.
- Zlib-ng 2.3.3: `12731092979c6d07f42da27da673a9f6c7b13586`.
- Zlib 1.4: `99623ef7097352da7993ba614161fd6a311e046e` (validated, outside these timed questions).
- ISA-L 2.32.1: `7c3479e0a9dac17f448603ec1ad64c7c625f530c`.

Four probes combine 256/512-bit VNNI vectors with one/four prefix accumulators.
They reduce every 16384 bytes and widen horizontal weighted sums to u64. Each
call starts at seed one and returns u32 through the same indirect adapter.
Preparation explicitly opts into native probes with `--skip-proof`.

All nine engines pass fixed/reference vectors and read-only guard checks under
SDE and on both physical CPUs. A planted one-byte overread faults. Timings use
deterministic random input at 0/1/16/64/256/4096/65536/1048576 bytes, aligned or
offset by one. Each question has three paired layouts (padding 0/256/1024),
alternating order and rotated competitor order, plus libdeflate/libdeflate
controls. Compare every question's 16 cells together: shared 5% FDR/3% margin.

Both final jobs exit zero. All 42 final runs per CPU are accepted quiet;
all 16 same-code control cells are level on each CPU. Both platforms provide
**no per-thread cycle counters** in these runs. Wall times stay unscaled;
energy, clock-speed states and their mixes remain unobserved.

## Failed and shorter-budget evidence stays here

| directory | experiment commit | requested batch | outcome |
|---|---|---|---|
| `ode-adler-fast-probe` | `8a81ec3ad604eb806100500b74df5f3153c50d11` | 5 ms | both CPUs stop on unobserved load windows |
| `ode-adler-fast-probe2` | `5455dd61dbe1ba16cbc3c8c18546e1d479c154d1` | 10 ms | EPYC stops on unobserved load; Xeon completes |
| `ode-adler-fast-probe3` | `64c4e525b12daeb2763408b10d1606dbde4eb2f3` | 20 ms | both complete quiet |

Calibration checks a clock per call. For nanosecond checksum calls the actual
sample batches are much shorter than the nominal request. The first attempts
correctly abstained where clocks could not observe a load window. Shared clocks
and its acceptance/statistics rules remain unchanged. Every failed attempt and
its partial data is retained; the final table uses only the final series.

## Reproduce the summaries

Build the adapter from the pinned experiment and clocks sources as `run.sh`
does. Reading needs no measurement machine. Inside a delivered directory:

```sh
READER --compare $(tr '\n' ' ' < probe512.pairs)
```

The source-pinned Rust reader reproduced all fourteen final comparison tables
exactly before publication. Historical formats use their own pinned reader.
This folder redacts only `/home/devon` as `<runner-home>`. Every numeric sample,
load window and acceptance record stays unchanged. The two manifests cover
public text records; executable manifests identify binaries retained off-branch.

Devon owns the next move: compare libdeflate at equal vector width, improve the
small/unaligned costs, and bring a measured instruction-form list to Sam before
extending the machine model. The full matrix, real libdeflate timings and exact
optimized machine theorem remain open.

— Devon Jonte
