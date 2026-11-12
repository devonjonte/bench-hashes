# The stream's 1 MiB cell on two EPYC 7443: the removal's "cost" is one binary's luck (BLAKE3 #368), November 12, 2026

**Question.** The first pipeline's removal read the multithreaded stream of
1 MiB messages 8 to 15% slower alone on this machine (six checks, two
people). Which part of the change does it?

**Answer.** None of its logic. The base (0a23cb70), as bench 4fcff35f
compiles it, is the outlier: about 0.150 ns/B alone, where every other
compilation of the same stream reads 0.164 to 0.175, the removal among
them. Hold the compilation still in any of three ways and the removal
reads level with its base.

All checks: point "continuous 1 MiB", default layouts, 64 pairs in the
second stage; medians of the kept runs alone, ns/B (old side, new side):

| check (folder) | verdict | alone: old, new |
|---|---|---|
| removal's first half (its modules deleted, lanes.rs untouched) against the base, bench 4fcff35f (`split-368`, `inline-368` 3) | slower alone 15.2% (64 pairs); first run +14.9% (4 pairs) | 0.150, 0.171 |
| removal's lanes.rs half alone (`split-368` 2) | level | |
| base with take_task and run_task never inlined against the base (`inline-368` 1) | slower alone 15.3% | 0.154, 0.175 |
| first half with the two always inlined against the base (`inline-368` 2) | slower: alone 9.3%, one cache 33.0% | |
| both sides with the two never inlined (`pinned-368`) | level | 0.171, 0.171 |
| first half against the base under a bench whose stream loop is a function of its own (`ownfn-368`) | level | 0.164, 0.168 |
| the whole removal against the base under that bench (`ownfn-368/removal.*`) | level | 0.163, 0.166 |
| 6fc30a3d with push inlined against 6fc30a3d (`push-368` 1) | same code | |
| 6fc30a3d against its parent (`push-368` 2) | one cache +10.5% | |

**What differs in the binaries** (built on the i7 for inspection): between
the base and the first half, outside the deleted modules, two functions
on the stream's path: the library's `stream::Storage::run_waiting` (2,333
bytes against 1,001: before, take_task inlined into it copies the whole
1,656-byte task) and the bench's `hash_continuous_messages` (16,305
against 16,529; one function holding every contender's loop). Under the
own-function bench run_waiting still differs and the stream's loop is
4,922 against 4,918 bytes.

**Scratch branches** (my forks, never to land): BLAKE3 `exp/devon-368-r1`,
`-base-pinned`, `-r1-pinned`, `-r1-inlined`, `-push-inline`; bench-hashes
`scratch/devon-368-stream-own-fn`.

**Machine.** Two EPYC 7443, 96 threads. **Posted.** BLAKE3 #368.
