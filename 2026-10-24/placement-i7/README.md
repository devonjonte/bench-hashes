# Buffer placement within a cache line, on the i7-12700K (bench-hashes #65)

**Question** (Sam Shackleton's EPYC finding): do #65's stack-offset
windows need the caller's buffer to cross a cache line on Intel too, and
does 256 B pay for a buffer 16 or 48 bytes into a line?

**Builds.** johnservil/bench-hashes f4f347c1 (servil b94e2fac, as Sam's
base) with her allocator options (samshackleton-tech/BLAKE3 13328aeb,
`line-placement/bench-hashes-allocator-options.diff`), applied by hand
where one hunk's context moved (`alloc-applied.diff`): default glibc,
`diag-align64`, `diag-line-offset` built with BENCH_DIAG_LINE_OFFSET 16,
32, 48. Binaries' digests in `binaries.*`; the binaries are not kept.

**Command.** `sweep.py` under run-bounded: for each build, the duo
threads' stack through one page in 16-byte steps, lent 64 B and 256 B,
servil st, solo and shared, P cores, 96 rounds; each cell's ten worst
offsets rescanned twice; slow = the lowest of three readings at least
1.08x the cell's median.

**Verdict.**

| placement | shared 64 B slow offsets | worst | 256 B medians |
|---|---|---|---|
| default | 4 (3344-3392) | 1.10x | 0.722 / 0.717 solo |
| 0 (align64) | 0 | 1.07x isolated | 0.722 / 0.718 |
| 16 | 4 (2704-2752) | 1.11x | 0.723 / 0.718 |
| 32 | 4 (2704-2752) | 1.09x | 0.723 / 0.717 |
| 48 | 0 at the bar | 1.07x at 2688 | 0.722 / 0.718 |

The windows need a line-crossing buffer on the i7 as on the EPYC. The
256 B cost of a buffer 16 or 48 into a line does not appear here. Solo
is flat throughout (only new threads' stacks move).

**Posted.** johnservil/bench-hashes #65.
