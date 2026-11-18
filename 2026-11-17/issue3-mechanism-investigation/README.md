# Small-call mechanism investigation

November 17, 2026. Devon Jonte. For [bench-hashes #3](https://github.com/devonjonte/bench-hashes/issues/3).

## Question and current finding

What explains the small-call penalties, and which intervention reduces the slow cases users can encounter?

The same-library controls establish sensitivity to benchmark build/run context. The cause remains open. Earlier code-placement claims were stronger than the experiments support; see the [correction](https://github.com/devonjonte/bench-hashes/issues/3#issuecomment-6960418528) and [corrected original control archive](https://github.com/devonjonte/bench-hashes/tree/66277a7f998195353b72983f62ff3b4c9d2fd131/2026-11-17/issue3-old-bench-control).

**The alleged instruction-cache counter was a data-cache counter.** Linux encodes a hardware-cache event as `cache_id | operation << 8 | result << 16`. L1D has id 0, L1I id 1, read operation 0, miss result 1. The experimental `(type 3, config 0x10000)` counts L1D read misses. L1I read misses use `0x10001`. The released `clocks::events` code already uses `cache(1)` for L1I. No L1I or op-cache conclusion follows from these experimental files.

The slower CPU socket also flips between the original control and its later rerun. That motivates a direct executable-memory-locality test. A missing rise in cache misses would still leave miss latency open.

## Descriptive recheck

For st OneMessage 128 B, these are pooled raw totals divided by work, rather than statistical release verdicts. Each socket contributes 32 process runs. Units are **ns/B and cycles/B**; multiply by 128 for a call's cost.

| experiment / side | socket 0 wall / cycles | socket 1 wall / cycles |
|---|---:|---:|
| original control / old | 5.653 / 24.157 | 9.606 / 35.326 |
| original control / new | 6.891 / 24.558 | 13.347 / 35.458 |
| experimental rerun / old | 9.049 / 37.386 | 4.822 / 24.783 |
| experimental rerun / new | 13.597 / 39.443 | 8.263 / 29.063 |

The original control's all-sample old/new wall means are 7.629/10.119 ns/B; cycles are 29.741/30.008 per B. Large wall-time tails contribute to that difference. They leave kernel time or descheduling among the possibilities, alongside memory latency and the instrument's own costs. This observation establishes no specific cause.

The earlier layout analysis grouped repeats incorrectly. The check cycles through 16 executables four times: layout index `i` takes accepted runs `i`, `i+16`, `i+32`, `i+48` in each side's list. Those groups also differ in CPU/socket placement. Later checks overwrote cached executables, invalidating the attempted join of their addresses with earlier timings.

## What the retained jobs establish

`jobs.tsv` indexes the completed deliveries under `runs/`. Keep failed attempts beside successful ones.

| job | interpretation |
|---|---|
| `issue3-frontend-avx2`, `issue3-frontend-icelake` | Whole-process perf counts include the gap and startup; the intended fast/slow state did not reproduce on a fixed CPU. They provide no per-call attribution. |
| `issue3-probe-avx2` | Permission failure opening perf events. |
| `issue3-probe2-avx2` | Standalone data-walk gap omitted the benchmark's other-code program. Counter labels also need the correction above. |
| `issue3-probe3-avx2` | Uses the real other-work gap, but manual ioctl/Instant brackets differ from the benchmark's. `raw4` is branch misses; the final branch field is an unused zero slot. Retained as diagnostic development, with no release verdict. |
| `issue3-icache-avx2` | The v11 prototype's reader rejected old-side v10 samples; check exit 2. |
| `issue3-icache2-avx2` | Same-library comparison of `d7723f11` with experimental `48323043`. Four judged slower cells; the prototype changes the instrument and its extra event is L1D. This is a distinct benchmark comparison from the original `cade30fd` control. |
| `issue3-fixed-context` | Preflight failed: host had no installed b3sum. No timing. |
| `issue3-fixed-context2` | Preflight failed: file-hash helper needed the dependency's abort panic strategy. No timing. |
| `issue3-fixed-context3` | Completed 32 quiet runs: eight identified executables crossed with CPUs 0/24, two repeats each, fixed calibration and original five-point/two-contender context. |
| `x86-epyc-9255/issue3-faithful` | The 24-round faithful-bracket pilot completed, but each process lasted under a second. Load was unobserved; the comparison reader rejects it. |
| `x86-epyc-9255/issue3-faithful96` | Eight processes with 96 fixed rounds each, all with observed quiet load. The same-binary logical-CPU control reads level in all four cases. |

### Fixed-context replay

The successful replay hard-links the cached executables, preserving their inode and cached physical pages, and verifies both hashes before and after. It faults all file pages before timing and queries their NUMA residence. Every selected executable was on **node 1** in that replay. This describes the replay's backing, not the earlier original control.

`identities/` holds provenance, hashes, symbol tables and page maps. `schedule.tsv` maps every run to its executable and CPU. `kept/` preserves raw measurements. The two repeats provide a pilot rather than a release acceptance procedure.

## Faithful-bracket control on EPYC 9255

The longer probe uses the released clocks crate's real gap and timing brackets. Every callback follows the same 128 B input copy. CPU 0 and CPU 24 are SMT siblings on this host, measured sequentially. These four-pair results describe one executable and this probe's context; they leave the original multi-layout release findings open.

| callback | CPU 0 copy + callback ns | CPU 24 copy + callback ns | CPU 24 / CPU 0 | verdict |
|---|---:|---:|---:|---|
| empty | 122.839 | 124.053 | 1.010 | level |
| one 128 B hash | 425.058 | 419.625 | 0.987 | level |
| eight 128 B hashes | 1376.691 | 1367.674 | 0.993 | level |
| dependent arithmetic | 630.437 | 625.063 | 0.991 | level |

The Rust probe reader verifies callback means against the raw records, adds preparation and callback through the shared mean, and judges all four cases with `clocks::summary::discoveries`. Its four fixed-input tests pass; they cover independent totals and rejection of busy load, altered means and unequal work. The short pilot's unobserved load also stops the actual comparison command. The empty callback includes input preparation and timing, so its cost is a control rather than a per-cell divisor.

## Source reading and the next controlled intervention

The pinned library already routes whole-block inputs up to 1 KiB to a compact, stack-free chunk-root kernel. On the EPYC 7443 the SSE4.1 variant serves that path; on the EPYC 9255 the AVX-512 variant does. The generator already loops over seven rounds and aligns entries to 64 bytes. A proposed new rolled or aligned kernel would duplicate existing work.

In the locally built probe, static inspection finds a separate 286-byte `hash_serial_cold` wrapper. It reaches the kernels through two six-byte indirect GOT calls, whose local targets have `R_X86_64_RELATIVE` relocations. The wrapper's platform detection reads a cached value. Its small-input branch bypasses the general tree walk; the earlier address hunt's `hash_all_at_once` was a different path.

The next test changes those two indirect calls to six-byte relative calls in one private executable, preserving its inode, relative code positions and return addresses. The patcher verifies both full-file hashes and the local relocation targets. Static round-trip and unrelated-byte-corruption controls passed locally; **the probe was not timed locally**. Eight alternating pairs on CPU 0 judge all four copy-plus-callback cases together. The result covers call indirection in this build; broader layout behavior and the exact cache and predictor contribution stay with further controls. No library change is proposed.

## Other interventions, declared before their results

- **Executable-page locality:** write byte-identical copies on each NUMA node, verify the placement, then cross the backing node with measuring CPUs 0/24, eight repeats each. Keep workload and calibration fixed. A reciprocal remote/local effect would support executable-backing locality within this scope. ASLR, anonymous pages and shared-library pages still vary between processes.
- **Empty-work control:** use the released `clocks` crate's exact gap and preparation/call brackets, comparing an empty callback with one hash, eight hashes and dependent arithmetic. This tests the instrument's contribution. The core-only probe omits the benchmark's pool and other-contender context and therefore supplements the original workload.

## Results of the declared interventions

Every declared intervention has delivered (`jobs.tsv`).

**Executable-page locality, EPYC 7443 (`runs/x86-avx2/issue3-executable-numa/`, 32 quiet runs).** The copies' pages were verified on their nodes before and after the runs (966 pages each). Judged by the v10 `compare`, eight pairs, ten cells together (`analysis/numa-analysis/`):

| measuring CPU | cell | file on the far node over the near node |
|---|---|---:|
| 0 | st OneMessage 64 B | 1.341, slower |
| 0 | st OneMessage 128 B | 1.323, slower |
| 0 | mt OneMessage 64 B | 1.339, slower |
| 0 | mt OneMessage 128 B | 1.321, slower |
| 24 | st OneMessage 64 B | 1.484, slower |
| 24 | st OneMessage 128 B | 1.594, slower |
| 24 | mt OneMessage 64 B | 1.149, level |
| 24 | mt OneMessage 128 B | 1.329, level |

The cells after a pause read level on CPU 0 (0.95 to 1.005). On CPU 24 the multithreaded 256 B cell read 1.128, slower. The other cells after a pause read level there. Instructions a call were equal (1851 to 1859).

The scope is one executable on one two-socket machine. The whole file's pages moved together. Anonymous memory stayed local.

`check` leaves each relinked executable's memory node to chance. That would produce the two cycle states and the socket that flips between experiments. The link to the original runs is an inference. Two findings need another cause. One is the gap between the two bench-hashes versions on one CPU. The other is the 4% to 8% marks on single-socket machines.

**Direct calls, EPYC 9255 (`runs/x86-epyc-9255/issue3-directcall/`).** Eight alternating pairs ran on CPU 0. Direct over indirect read 0.969 for the empty case, 0.975 for one hash, 1.001 for eight hashes and 0.994 for arithmetic. Every case is level. The empty control moved as much as the hash. The indirection lead has no support and is parked.

**Empty-work control on the EPYC 7443 (`runs/x86-avx2/issue3-faithful96/`, `analysis/issue3-faithful96-avx2-cpu-control.tsv`).** The figures are CPU 24 over CPU 0. The empty bracket read 1.799, slower: 177.1 ns against 318.7 ns. Its cycles rose from 1670 to 3274 at equal instructions. One hash read 0.949, eight hashes 1.036 and arithmetic 1.071, all level. Where that executable's pages lived went unrecorded. The locality result above is its likeliest reading and stays unproved for it.

Scripts and source are retained under `analysis/` and `source/`. Devon owns diagnosis and benchmark presentation; John owns library design and release disposition. A library mitigation needs evidence across adverse contexts as well as a typical binary. The work continued as an experiment on the check's design: [`2026-11-18/issue3-four-programs/`](../../2026-11-18/issue3-four-programs/).

<details><summary>Reproducing the offline analysis</summary>

The Rust reader study is at benchmark commit `9432f1e8364020e1b50871b1997a892bddc1bc3b`; it is a research branch, with a failing overview-staleness test, and carries no production-landing claim. Its `issue3-audit` command uses the existing reader and shared mean, exports raw counts, and labels the historical extra event as L1D. It prints absent v10 extra events as `-`.

```sh
bench-hashes issue3-audit KEPT_DIRECTORY > run-totals.tsv
bench-hashes issue3-audit --samples KEPT_DIRECTORY > sample-values.tsv
```

The stored `analysis/issue3-*-{run-totals,sample-values}.tsv` exports come from that command. Run `analysis/issue3-recheck-exports.py` with the analysis directory as the working directory to reproduce the socket, layout and tail displays. Its inputs are the Rust exports, rather than a second benchmark-samples parser. It preserves integer totals and exact ratios until decimal display.

The standalone probe reader is `source/directcall-study/src/bin/compare.rs`; it reads this probe's own raw records and uses the shared `clocks` mean and comparison rule. Its primary cost is preparation plus callback, and its callback-only ratio remains a diagnostic column. The original 24-round source and the 96-round study source are both retained.

`issue3-analyse-numa.py` uses the normal v10 `bench-hashes compare` tool for the predeclared remote/local comparisons, with every measured cell judged together by the existing rule. It requires every run's recorded load to be quiet; its outputs are under `analysis/numa-analysis/`. Historical sample headers and values remain intact except for home-path redaction.

The faithful probe pins its core library to `27eacce3a5c2e03043f4fcd347c178a80f9d911c` and clocks to released benchmark `cade30fdb71682719f5fa3e586ff96146ae9fc25`. Cargo metadata verifies both selections. Local work compiled the probe and checked its expected input digest against an independent installed b3sum; timing belongs on the measurement host.

Executables are excluded. `excluded-executable-identities.tsv` retains the SHA-256 and BLAKE3 identities of excluded delivered binaries. Nested executable-hash files are identity records; the root manifests cover this archive's text artifacts. Paths are home-redacted.

</details>
