# x86-64's long ring at 2 MiB, on the i7-12700K (November 10, 2026)

**Question** (BLAKE3 #349): does a 2 MiB ring for a stream's long
messages on x86-64 bring back the two shared cells that the 8 MiB ring
cost, and does 4 MiB read better?

**Verdict.** 2 MiB brings them back, and 4 MiB is no better. Each
against `next` f4378b28 (8 MiB), bench c2804417, 16 pairs, the
multithreaded stream (`measure.sh`, `compare-2mib.md`, `compare-4mib.md`):

| cell | 2 MiB ring | 4 MiB ring |
|---|---|---|
| 4 MiB, shared one cache | 0.0686 → 0.0496, **27.7% faster** (16 of 16) | 0.0692 → 0.0503, **27.4% faster** (16 of 16) |
| 16 MiB, shared one cache | 0.0799 → 0.0611, **23.5% faster** (16 of 16) | 0.0805 → 0.0623, **22.6% faster** (16 of 16) |
| 16 MiB, solo | 0.0497 → 0.0473, **4.7% faster** (16 of 16) | 0.0509 → 0.0480, **5.7% faster** (14 of 16) |
| 4 MiB, solo | x1.027, level (4 of 16 faster) | x1.003, level |
| 1 MiB, both | level | level |

Before the 8 MiB ring the two shared cells read 0.0514 and 0.0628
(`../long-stream-shared-i7/`, the parent of 06f6e26d).

Head to head, 4 MiB against 2 MiB, 16 pairs (`head-to-head.sh`,
`compare-4-vs-2.md`): no cell slower, every cell level; shared 4 MiB
x1.014 (3 of 16 faster), shared 16 MiB x1.019, solo 4 MiB x1.004.

**Sides.** 2 MiB: John Servil's c133807a rebased on `next` (605c53e3;
landed with this record in its message). 4 MiB: the same with the one
constant changed (devonjonte/BLAKE3 `exp/devon-long-ring-4mib`, 54cc1e9a).

**Machine.** i7-12700K, Linux 7.0.0-42, mains power, governor
`powersave`; each check waited for a quiet machine and ran alone.
