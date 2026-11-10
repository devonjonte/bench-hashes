# BLAKE3 #302 on the i7-12700K: the ring race's repair, its two versions, and the race itself caught

**Question.** Does the repair of the source ring's claim-then-copy race (BLAKE3 #302) slow any cell that goes through a source: the stream's (continuous, lent, collection) or the pipeline's (batches, receive)?

**Command.** `run.sh`: `bench-hashes check` (bench 0bb31ed5) on 26 points, against the base c7936a5f (BLAKE3 #329's head). The numbered folders hold each step's output and samples.

## The result in one place

| step | new side | verdict |
|---|---|---|
| 1 | 5191ab36: every task in a place its publisher names, the stream's too (its first entry's) | **64 B stream, shared: +6.8% slower** (64 pairs); the rest level |
| 2 | 43836b15 (experiment): the stream's places back in publication order, the ring of place numbers kept | 64 B stream **+6.9% shared, +7.5% solo** (32 pairs): the place order is not the cost |
| 3 | 25a9beb8: the stream on its ring of tasks, one place longer; the pipeline alone names places | 64 B stream **level** (32 pairs: solo x1.007, shared x1.019): the ring's word was the cost |
| 4 | 6d3f3880 (step 3's code and its mutation lists): the full gate | first round: **no cell slower** (98 cells); the confirmation of four suspects stopped at pair 35 of 64: **the old side crashed** (below) |
| 5 | 6d3f3880: the four suspects again, 32 pairs | **pipeline batch 16, shared: +3.8% slower** (31 of 32 pairs); pipeline batch 16 solo, batch 16384, stream 256 B and 16 MiB level (`5-final-suspects/compare.md`) |

## The design that landed in the pull request: the pipeline's ring of actions

Steps 1 to 5 priced a word a publication. The pipeline's task carries three words (its function, its context, the SME2 turn) inside a 1,640-byte Task that the publisher wrote and a worker copied at every part. Its source now holds those three words in the ring, atomics, read before the claim: nothing left to copy after it. Against the same base without a repair (rebased: c3e1f905, #329's head on `next` 61483cc1):

| step | new side | verdict |
|---|---|---|
| 6 | fcbdea52 (experiment) | probe, then the pipeline's gate: **no cell slower**; 32 pairs: batch 16 x0.869 solo, x0.911 shared |
| 7 | 203d92a2 (the final code; 887fa7cd is the same tree with its messages) | the full gate, 26 points, 98 cells: **no cell slower**; three suspects level over 64 pairs, the 64 B stream shared among them (x1.011) |
| 8 | 887fa7cd | 32 pairs on the cells that moved (`8-action-ring-final-32-pairs/compare.md`): **batch 16 x0.889 solo and x0.921 shared, faster; receive saturated x0.924 and x0.935, faster; receive 2 μs shared x0.948, faster**; batch 64 and receive 2 μs solo level; no cell slower |

## The race, caught

In step 4 the base's executable (`target/check/old/bench-hashes-10`, c7936a5f, which lacks the repair) stopped in the pipeline's ContinuousBatches 16384 cell: `thread 'blake3-worker-1' panicked at .../stream/receiver.rs:504:29: one task takes the published batch job` (`4-final-gate/gate.stderr.txt`). A batch's task ran twice: what #302 predicts when a claimer held before its copy has its slot written over. It is the second native sighting, after Sam Shackleton's Ice Lake gate (#296). With #329 the second run stops at a check; on `next` without #329 the batch job is a box, and the second run frees it twice.

## What it means

The repair costs the stream nothing, and the pipeline's small cells are 5 to 11% faster with it than without. The named-places version (steps 3 to 5) cost the pipeline's smallest shared batch cell 3.8%, for a word a task that its publisher writes and its workers read; the stream showed the same cost when it carried the word (steps 1 and 2). The ring of actions carries three words in place of that one and of the task's 26 cache lines.
