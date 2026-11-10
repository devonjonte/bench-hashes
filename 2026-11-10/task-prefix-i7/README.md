# BLAKE3 #314 on the i7-12700K: a stream's task written by its prefix and handed on by reference (November 10, 2026)

**Question.** Does writing a stream's task as its header and the members
it holds make any stream cell slower, and what does it gain?

**Verdict, on the head that is the pull request (4bbdb0b1; sources as
63a89fb2).** The gate over thirteen points (`gate.sh`, `gate.stdout.txt`,
samples in `kept/`, `compare.md`): **no cell slower** in either stage, and
no level cell's instructions moved beyond +0.5%. Over 16 pairs on four
points (`v2.sh`, `kept-v2/`, `v2-compare.md`), the multithreaded stream:

| message | solo | shared one cache |
|---|---|---|
| 64 B | x0.978, level (13 of 16 pairs faster) | x0.979, level (12 of 16) |
| 256 B | x1.012, level (4 of 16) | x0.969, level (13 of 16) |
| 4 KiB | **x0.922, faster** (16 of 16) | x1.006, level |
| 16 KiB | **x0.869, faster** (16 of 16) | **x0.911, faster** (16 of 16) |

The single-threaded stream is level at 256 B, 4 KiB and 16 KiB. At 64 B
it reads **x1.011, 13 of 16 pairs slower**: level by the rule's 3%
margin, small and consistent. Its instruction count did not move.

## The variants, and what they showed

Each against `next` 0145287b, bench c2804417. The 64 B stream cells:

| variant | multithreaded, solo | single-threaded | files |
|---|---|---|---|
| the slice copy for every task; tasks by value | x1.021, level (13 of 64 faster) | x0.994 (4 pairs) | `gate-first-version.*`, `kept-first-version/` |
| a full task as one whole-struct copy, returning early | x0.987 (16 pairs); x0.999 (32 pairs) | x1.019; **x1.030, slower** (32 pairs) | `exp.*`, `kept-exp/`; `shape.*`, `kept-shape/` |
| the same, one `if` and `else` | x1.028 (3 of 16 faster) | x1.020 | `final.stdout.txt`, `kept-final2/` |
| header fields, then a fixed-size member array | **x1.050, slower** | x1.022 | `final-safe-variant.*`, `kept-final/` |
| V1: tasks run by reference; the slice copy for every task | x1.004 (8 of 16) | x1.014 (2 of 16) | `v1.*`, `kept-v1/` |
| V2: V1, and the open task handed over where it lies | x0.978 (13 of 16) | x1.011 (3 of 16) | `v2.*`, `kept-v2/` |

**What they say.** The copy inside `push` was never the cost. With a
1,640-byte task passed by value, each small change to `push` changed
what the compiler inlined on the stream's path, and with it whether a
whole-task copy was made: the cell moved 2 to 5% either way, in the
contender that calls `push` and in the one that never does. Passing the
task by reference, and handing the open task over where it lies, takes
those copies out of the compiler's hands; the simplest `push` is then
the best measured.

**Machine.** i7-12700K, Linux 7.0.0-42, mains power, governor
`powersave`; every check waited for a quiet machine and ran alone.
