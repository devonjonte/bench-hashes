# Adler-32: existing libdeflate width and narrow reductions, November 13, 2026

How much of the first probe's Xeon gain comes from libdeflate's width policy,
and can narrower reductions improve its small-input costs?

**The existing 512-bit libdeflate kernel explains most of the aligned Xeon
gain.** On EPYC the dispatcher already selects that kernel. The optional u32
reductions improve the native probe at 16/64/256 bytes on both CPUs, while its
16-byte calls still lose against the matched-width libdeflate kernel. The
probe's unaligned 1 MiB call loses badly on Xeon. The faster-and-proved target
remains open: all optimized probes here are **UNVERIFIED native C**.

## Decisive cells

Each row names its own comparison. Times are medians of per-run means; paired
ratios come from the shared rule and may differ from ratios of displayed times.

| CPU / question | bytes | offset | old ns | new ns | new/old permille | judgment |
|---|---:|---:|---:|---:|---:|---|
| Xeon, dispatcher → existing 512 | 4096 | 0 | 100.62 | 63.81 | 636 | faster |
| Xeon, dispatcher → existing 512 | 65536 | 0 | 1565.46 | 984.88 | 629 | faster |
| Xeon, dispatcher → existing 512 | 1048576 | 1 | 25811.01 | 17561.65 | 669 | faster |
| Xeon, existing 512 → probe-r32 | 4096 | 0 | 65.05 | 64.37 | 1003 | level |
| Xeon, existing 512 → probe-r32 | 65536 | 0 | 984.57 | 910.39 | 927 | faster |
| Xeon, existing 512 → probe-r32 | 1048576 | 1 | 18648.06 | 32754.57 | 1786 | slower |
| Xeon, existing 512 → probe-r32 | 16 | 0 | 13.55 | 16.05 | 1184 | slower |
| EPYC, existing 512 → probe-r32 | 16 | 0 | 2.97 | 3.32 | 1117 | slower |
| EPYC, existing 512 → probe-r32 | 4096 | 0 | 16.74 | 16.70 | 989 | level |
| EPYC, existing 512 → probe-r32 | 1048576 | 0 | 6737.96 | 6538.23 | 968 | level |

The complete tables retain every small/bulk/alignment cell, including outcomes
judged level despite an apparent change in the medians. Both same-code controls
judge all 16 cells level on each CPU. All **48 runs per CPU are accepted quiet**.
Counters are unavailable: wall time only, unscaled; energy and speed states are
unobserved. Eight reader/adapter tests and all twelve regenerated comparison
tables pass locally.

The alignment distinction has a concrete source difference. Pinned libdeflate
`lib/x86/adler32_template.h` aligns a misaligned pointer before processing
lengths **greater than 65536**. The native probe always uses unaligned loads.
That explains why alignment handling is a useful next controlled change.
Hardware-level attribution of the full cost still needs a targeted test.

## Sources and controlled changes

Experiment [`08b870ad4384517fb5c1403f20addfeece8d912f`](https://github.com/devonjonte/BLAKE3/commit/08b870ad4384517fb5c1403f20addfeece8d912f).
[`FAST.md`](https://github.com/devonjonte/BLAKE3/blob/08b870ad4384517fb5c1403f20addfeece8d912f/tools/verify/machine/experiments/adler32/FAST.md)
declares the six questions before collection. Sources, compilers, flags and
all commands are in each CPU's `provenance.txt`, `run.sh`, build logs and samples.
Shared clocks: bench-hashes `5f99f456951ab36f7201decd8aa5e0249ec67bd1`.
Native-library pins match [the first probe](../ode-adler32-first-fast-probes).

`libdeflate512` calls the existing internal
`adler32_x86_avx512_vl512_vnni` function. Preparation globalizes that function and
`adler32_impl` in a **copy** of the archive. Every archive member's section
contents, section headers and relocations compare equal to the pristine build.
The symbols bind privately. `libdeflate-exposure.json` records both archive
digests; `symbols-*.txt` and `validate-*.txt` record the actual pointer selection.
Xeon's selected pointer matches the 256-bit kernel's offset. EPYC's pointer
matches the existing 512-bit kernel. Default-dispatch and direct-kernel calls
remain separate comparators. Libdeflate keeps -O2; the native probes use -O3.
Same-width comparisons still combine algorithm and compiler effects.

`probe512-r32` changes only reduction arithmetic in the 512-bit/four-prefix
native probe: A reduces in u32; B reduces in u32 when the block has at most
5552 bytes, and in u64 otherwise. Both probe variants retain 16 KiB blocks.
Preparation requires explicit `--skip-proof` for all native probes.

Before timing, all 11 engines pass fixed/reference checks, every length 0–257
at all 64 byte alignments, all masked tails against both read-only guard edges,
and reduction boundaries. A deliberate one-byte overread faults. Altering one
text byte makes archive verification fail. Local SDE evidence is in
`local-validation/`; each physical host records its own validation.

## Collection and reproduction

Four paired layouts (0/256/1024/2048 padding), alternating order and rotating
questions; deterministic random input, eight lengths and two alignments, the
same 16-cell probe workload as the first series. Requested batches are 20 ms.
Each question judges its 16 cells together with shared clocks' 5% FDR/3% margin.
Jobs hold each measurement host's `bench-turn` lock and run under the existing
`run-bounded.py` supervisor, adapted only to a home-relative durable lock path.
Both finish within their 1200-second deadlines. Every attempt is retained.

| comparison file | old → new |
|---|---|
| `comparison-width.tsv` | libdeflate → libdeflate512 |
| `comparison-wide.tsv` | libdeflate512 → probe512 |
| `comparison-wide-r32.tsv` | libdeflate512 → probe512-r32 |
| `comparison-reduction.tsv` | probe512 → probe512-r32 |
| `comparison-control.tsv` | libdeflate → libdeflate |
| `comparison-control512.tsv` | libdeflate512 → libdeflate512 |

Build the source-pinned adapter as the job's script does. Its `--compare` path
reads samples without executing native probes or reading a clock. Inside a CPU
folder, `READER --compare $(tr '\n' ' ' < width.pairs)` reproduces that table.
All twelve tables reproduced byte-for-byte before publication.

Public copies replace the host's home prefix with `<runner-home>` and the local
validation's home prefix with `<development-home>`. All numeric samples, counts,
load windows and acceptance records stay unchanged. Dual manifests cover these
public text records; binaries remain off-branch.

Next move, Devon: repair and measure alignment/small-input costs, then probe a
fixed 4 KiB raw-sums kernel as a simpler proof boundary. Send Sam the measured
instruction forms before changing the shared model. The optimized Ode machine
proof, full workload and real libdeflate timing remain future gates.
[Tracker](https://github.com/servil-software-factory/BLAKE3/issues/377).

— Devon Jonte
