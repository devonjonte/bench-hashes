# The i7-12700K's 0.8 full run with BLAKE3 official, multi-threaded

**Question:** Zooko's call (October 27): every comparison with official
is like for like, so the release's full runs measure official in both
its forms. What does the i7 read?

**Commits:** library johnservil/BLAKE3 934dee89 (0.8.0+f7ce4e4e); bench
devonjonte/bench-hashes `candidate/devon-official-mt-all` a6848d81 (bench
0.18 at 67bae864 plus `blake3-official-mt` in `--all`, bench-hashes #94),
built by `bench-hashes build-against ..` (its report names blake3-servil
0.8.0+f7ce4e4e at 934dee89, and BLAKE3 official mt: blake3 1.8.7).

**Command:** `EXE --all` from a scratch directory, under run-bounded.py,
nothing else running (October 27, 21:54-21:58 UTC, quiet: 0.25 CPUs busy
on average). The b3sum files are the release run's (`../release-08-i7`),
which this change does not touch; the map is drawn from both.

**Verdict:** a full run with both official forms, 4 min 15 s (4 min 8 s
without official mt).

| cell | servil multi-threaded | against official, one thread | against official, multi-threaded |
|---|---|---|---|
| 128 MiB | 12 GB/s | x3.2 (the release run) | x1.1 (11 GB/s) |
| 64 KiB messages, one after another | 22 GB/s | x4.6 | x7.5 (2.9 GB/s) |

An earlier attempt at 21:49 ran bench 0.18 unchanged (the change was not
yet committed); it measured no official mt, and was deleted.

**Posted:** BLAKE3 #125, bench-hashes #94.
