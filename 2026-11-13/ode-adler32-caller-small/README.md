# Adler-32: caller costs and seed-one small inputs

November 13, 2026. [Project tracker](https://github.com/servil-software-factory/BLAKE3/issues/377).
Source [`4d519c5dd00a3c29186f01a902b77a552949fdd5`](https://github.com/devonjonte/BLAKE3/commit/4d519c5dd00a3c29186f01a902b77a552949fdd5).
[Declared plan](https://github.com/devonjonte/BLAKE3/blob/4d519c5d/tools/verify/machine/experiments/adler32/FAST.md).

**144/144 runs quiet.** Both same-code controls' 16 cells judge Level on each
CPU; all 18 tables reproduce byte-for-byte with the source-matched Rust reader.
**Counters unavailable. All optimized code remains UNVERIFIED.** The original
scalar checksum remains the sole checked whole-checksum machine theorem.

This follows the [alignment/raw-block experiment](../ode-adler32-alignment-raw4096/).
It separates three hypotheses with one change per candidate:

- `probe4096-batch`: four calls of the unchanged raw4096 kernel before
  normalization; u32 A and u64 B. Per4096 remainder handling stays unchanged.
- `probe4096-entry`: a small entry tail-calls r32 below4096, and a noinline large
  body keeps the original per4096 reductions. This tests the six-register tiny
  prologue separately from bulk work.
- `probe512-small`: the aligned probe gains a direct masked-vector path through
  64 bytes. From seed one, A needs no reduction and B needs none through22 bytes,
  the largest safe all-255 length. Above64 bytes the algorithm stays the same;
  the compiler may emit a different bulk body.

## Findings

Batching judges every cell Level on both CPUs. It supplies little help for the
large EPYC raw-caller cost: aligned64KiB median428.43→424.65 ns (Level). The
tested batching design leaves that large cost unresolved; fewer normalizations
offer little help as implemented. Several Xeon medians move more, with variability that the table's
Level verdict keeps visible.

Entry splitting improves EPYC16/64/256-byte calls. Xeon offset-one1MiB loses,
so the new entry/body layout carries an owned bulk cost too. Small seed-one
specialization improves16-byte calls against the aligned probe on both CPUs,
and beats LF512 on Xeon16/64-byte calls. EPYC16 B remains slightly slower than
LF512. It also acquires a clear EPYC offset-one4KiB loss above its specialized
range. That is a compiler/implementation interaction to isolate before choosing
this layout.

Selected medians of per-run means, ns; the paired shared rule judges each
question's complete16-cell family (5% FDR,3% margin):

| CPU / question / bytes / offset | Before ns | After ns | Verdict |
|---|---:|---:|---|
| EPYC, raw → batch,64KiB /0 | 428.43 | 424.65 | Level |
| Xeon, raw → batch,64KiB /0 | 1025.95 | 1007.02 | Level |
| EPYC, raw → entry,16B /0 | 4.03 | 3.42 | Faster |
| EPYC, raw → entry,256B /0 | 4.55 | 4.14 | Faster |
| Xeon, raw → entry,1MiB /1 | 17966.39 | 18667.71 | Slower |
| EPYC, aligned → small,16B /0 | 3.41 | 3.04 | Faster |
| EPYC, aligned → small,4KiB /1 | 16.92 | 19.69 | Slower |
| EPYC, LF512 → small,16B /0 | 2.97 | 3.04 | Slower |
| Xeon, LF512 → small,16B /0 | 13.51 | 10.59 | Faster |
| Xeon, LF512 → small,64B /0 | 13.52 | 11.19 | Faster |
| Xeon, LF512 → small,64KiB /0 | 984.62 | 906.00 | Faster |
| Xeon, LF512 → small,1MiB /1 | 19480.93 | 15374.21 | Faster |

The tables retain all cells, paired estimates and pair ranges. A Level verdict
leaves effects outside this experiment's resolution open. No universal fastest
or no-regression claim follows. LF retains -O2; C probes -O3. Matched-width
comparisons combine algorithm, compiler and caller effects. Xeon chooses LF's
256-bit public default; EPYC chooses512. Both remain comparators.

**Next move, Devon:** test cleanup placement in the raw caller, which currently
runs `vzeroupper` per block, and separate small dispatch from the unchanged bulk
body. Each proposal follows an observed instruction/layout difference. Further
wide proof work waits for a design that earns it; the exact optimized machine
theorem remains open.

## Correctness and image scope

All16 engines pass clockless SDE validation and four physical layouts on both
CPUs: fixed/reference inputs, all small lengths0–257 at all64 alignments,
read-only guards, and raw sum anchors. New callers also exercise critical
4/8/16/32KiB and65535/65536/65537/65600 boundaries at all64 alignments, plus
canonical-zero sums across4/16KiB blocks and tails. Fixed22/23-byte all-255
checks agree with an independent zlib and the direct arithmetic formula.

A planted u32 truncation of the batched B fails; a wrong small threshold fails
at the fixed23-byte anchor. Restored validation passes. Eight reader/adapter
nextest tests pass. All eight earlier native objects retain exact section bytes,
headers and relocations. Kernel text/table observations and exposure checks are
preserved. The image observer checks table values; it supplies no machine theorem.

`Block_adler32` checks16KiB update bounds (u32 A, B below2^36) and22-byte seed-one
bounds, with propext/Quot.sound only. Those mathematical bounds remain separate
from compiled implementation correctness.

## Reproduction and records

Clocks/readers/rule: bench-hashes `5f99f456951ab36f7201decd8aa5e0249ec67bd1`.
Dependencies: libdeflate1.26 `92e6a0db9fa848d742f9eb286c92afc60f2c3dda`,
zlib1.4 `99623ef7097352da7993ba614161fd6a311e046e`, zlib-ng2.3.3
`12731092979c6d07f42da27da673a9f6c7b13586`, ISA-L2.32.1
`7c3479e0a9dac17f448603ec1ad64c7c625f530c`.

Each machine folder contains the actual `bounded-tools/job.sh`, source/flag/
provenance reports, all raw v3 samples/logs, linked code/images, selected pointer
records and the unchanged-section exposure record. `run.sh` wraps the job under
ordinary exclusive1800-second supervision. Build/validation/image inspection
finish before collection. No retry was needed. Measurement uses the same16-cell
random probe,20ms nominal batches, four layouts0/256/1024/2048, alternating sides
and rotating questions. Timing, load, calibration and judgment stay unchanged.

Build `prepare_bench.py ... --skip-proof` from the pinned source and clocks,
then `cargo build --release`. For any question, feed the eight relative names
in its `.pairs` file, in order, to the resulting Rust reader:

```sh
/path/to/ode-adler-observer --compare OLD1 NEW1 OLD2 NEW2 OLD3 NEW3 OLD4 NEW4
```

Questions: `batch`, `entry`, `small`, `wide-batch`, `wide-small`, `default-batch`,
`default-small`, `control512`, `control-raw`. The final two are same-code controls.
`validation/` holds local confirming and planted-fault logs/command. Home prefixes
alone are redacted: `<runner-home>` or `<development-home>`. Numeric samples,
counts/load windows and pair names stay unchanged. No executables are included;
their recorded dual digests remain. Both public manifests are checked.

Code/test preparation took about20 minutes; controlled collection about7–9 minutes
per CPU including build/validation. Full80-cell, real integration, adverse/cold/
after-work behavior and measurements of exact proved optimized bytes remain open.

— Devon Jonte
