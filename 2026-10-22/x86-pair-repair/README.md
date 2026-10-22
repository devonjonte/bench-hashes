# Generated two-input AVX2: a partial repair, with remaining costs

Can one whole chunk and a partial chunk use the generated,
proved parameter-block family while recovering the release baseline's speed?
The earlier [critical-size check](../x86-generated-critical/) found 45–65%
slowdowns at 1536/2047 bytes in John's generated candidate.

The latest two-input candidate is 28–35% faster than that
candidate across the eight 1536/2047-byte cells (the paired comparison's
geometric means). Its sixteen-pair comparison against the release baseline
and its sixteen-pair same-code control each detect no slower cell.

**Remaining costs keep the broader no-regression claim open.** Raw
1536/2047-byte ratios against the release baseline range from +1.6% to
+12.7%. Single-threaded 3839 B after a pause reaches +20.3%, and 4470 B
+14.6%. Against its parent, the check detects **7935 B single-threaded after
a pause +5.1%**. That path uses the existing eight-lane kernel; its compiled
caller and code-layout interactions need investigation. The candidate stays
under review.

Discussion: [generated x86 assembly](https://github.com/johnservil/BLAKE3/issues/90).
This is an i7-12700K research experiment, with 28 named cells. The release's
other workloads, platforms, and acceptance procedure retain their own scope.

## What changed

`blake3_partial_avx2_pair` keeps two messages in each YMM register's two
128-bit halves: four state rows and four message rows. It reuses `Params<2>`,
the existing generator, snapshot mechanism, differential tests and assembled
proof. Dispatch uses it for one whole chunk and more than 64 partial bytes.
The existing four/eight-lane kernel bodies stay unchanged.

Three versions preserve the investigation:

| Version | Change | Check against release baseline |
| --- | --- | --- |
| 1 | Row-packed pass; select scheduled words with shuffles/blends | 8 pairs: one slower cell, st 1536 B after pause +8.6% |
| 2 | Select each four-word message vector with at most three shuffles | 16 pairs: nine slower cells |
| 3 | Add the message to row a before adding row b, matching the existing generator's dependency schedule | 16 pairs: no slower cell detected; raw costs above remain open |

Version 3 also has sixteen same-code pairs, with every cell level, and
sixteen pairs against John's generated candidate, with eight faster cells
and the 7935-byte slower cell above. The A/B and same-code jobs were declared
in [the plan](pair-v3-plan.md) before their measurements.

## Source identities

- Release baseline: `c40892d2b426bf3c169fbe7bac3ab8ed0bcfd36b`.
- John's generated candidate / all three versions' parent:
  `7e508243248ea42eac7e9511f3f851e4062ad271`.
- [Version 1](https://github.com/devonjonte/BLAKE3/tree/evidence/devon-x86-pair-1):
  `0c5de915cce9c6dc889a410db079bee21db5655c`.
- [Version 2](https://github.com/devonjonte/BLAKE3/tree/evidence/devon-x86-pair-v2):
  `3ac30da85fe5f9e4c9ceab6f4c20e1d9b8831b4b`.
- [Version 3](https://github.com/devonjonte/BLAKE3/tree/evidence/devon-x86-pair-v3):
  `848f9fdd094fbea4a1c6d4012b2ed698d2225d71`.
- [Research benchmark](https://github.com/devonjonte/bench-hashes/tree/probe/devon-generated-points):
  `3b45d0002b1f79d319eaf51a9c704b02a4e4ab1a`.

The three code records are the exact working-tree snapshots made by `check`.
Version 1 includes an incidental formatting change to an empty ARM test
module, restored in versions 2/3. The x86 changes leave ARM machine code
unchanged; its speed gates cannot measure this change.

## Correctness evidence

Every version passed **32/32 assembled proofs**: snapshot blocks 0–15 on
Unix and Windows. These cover arbitrary input bytes and initial chaining
values, per-lane counters, lengths and flags, final/snapshot outputs and
memory/ABI checks.
Each version passed the native release suite, **92/92**.

The native instruction checker agreed on **176 register-only forms ×200
reproducible states** for version 2. Version 3 uses exactly those forms,
reordering two additions. Its 112 AVX-512-only forms were skipped on this CPU.
The checker is from `35db939f00fbdbce18ef22d7bfac9e57352d5cb0`; imports and
assembly use the candidate's `tools/verify`. Version 1's build matrix passes;
the later assembly changes preserve its interfaces. Windows evidence here
is assembled proof, alongside native Linux execution.

Run `prove-partials.py avx2_pair 0 16` from the candidate checkout, with its
`tools/verify` dependencies installed, to reproduce the 32 proof cases.
Use a complete process-group deadline, as for the original 300-second runs.

## Measurement and records

The research benchmark declares seven sizes in FROZEN.md:
1 KiB, 1536, 2047, 2304, 3839, 4470 and 7935 B. Single/multithreaded,
after work and after a pause, give 28 cells. Shared clocks, load checks,
fresh relinking, alternating order and Rust comparison remain unchanged.
Each pair has a distinct link layout on each side. Every pair was accepted;
no other proofs, builds or measurements ran beside the benchmark.

From the benchmark checkout nested inside the contender:

```sh
cargo run --release -- check \
  --against c40892d2b426bf3c169fbe7bac3ab8ed0bcfd36b \
  --cells all --pairs 16 --keep RESULTS
```

Version 1 used `--pairs 8`. The control uses `--against
848f9fdd094fbea4a1c6d4012b2ed698d2225d71`; the parent comparison uses
`--against 7e508243248ea42eac7e9511f3f851e4062ad271`. Each job was bounded
at 1000 seconds with `run-bounded.py`. The reports use source-matched
`bench-hashes compare OLD... -- NEW...`, passing files in run-number order.

Five run directories contain **144 sample files** and five size manifests.
Samples preserve raw wall times, calling-thread core/cycle counts and load
windows. These short-call rows carry no process-CPU or energy measurements.
Wall times remain unscaled. Comparison text, full
check logs, native/model/build/proof logs and the predeclared plan accompany
them. No binaries are stored here. Power reports: mains, powersave CPU
governor, performance energy preference.
