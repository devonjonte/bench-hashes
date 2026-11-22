# The group call on separately borrowed short messages, before and after BLAKE3 PR #484 (November 22, 2026)

**Question.** The review of [BLAKE3 PR #484](https://github.com/servil-software-factory/BLAKE3/pull/484) (drop `arrayvec` and `cfg-if`) measured `TreeHasher::try_hash_group_on` 5.0% slower for a group of two 64-byte messages at the change's first form (`c753f206`, finding 9). Does the repaired form cost anything there?

**Verdict.** No: the repaired form is faster for small groups and level for large ones. A group of two 64-byte messages takes 0.644 of its time at `next` on the Ryzen 9700X (75.9 to 49.1 ns) and 0.651 on the EPYC 9255 (94.2 to 62.0 ns). The gain shrinks as the group grows, and sixty-four 64-byte messages read within 1% either way in all five runs.

**Why.** Two things, read in the machine code of a release build (`old-group.s` is the probe's `group` function at `next` `0509bc84`, `new-group.s` at the repaired form). At `next` the table of up to 128 message pointers is collected into an `Option<ArrayVec>` and then copied whole out of it, 1,028 bytes for every group. The repaired form fills the table where it stands. The first form's fill also loaded and stored the vector's length at every element, the likely source of its 5%. The repaired fill keeps the length in a register.

## Commits

- The last run, `probe-5`: old is BLAKE3 `next`, `3bfbbd07201e0be3fbb5f942bb2568aeea46faf3`. New is `ea282e84983bcb14497470681874cb1f51be73e7` (devonjonte/BLAKE3, branch `experiment/devon-484-group-probe`), tree `9d92157c5ff15c2ab1d55529923c931d8c936793`. The PR's head `1101353806af5a8c13bfbfda487b3a832f8b39da` has that tree and another commit message.
- The four earlier runs measured the change's earlier forms against the `next` of their hour, as the table at the end names them.

## Method

`probe.rs`: one program, built against each commit, that calls `try_hash_group_on` on `count` separately borrowed messages of one length and checks each digest once against `convenience::hash`. Each cell is the median of 15 rounds of about 20 ms. Each host's `run.sh` is the job as submitted, through `bench-submit` (one job at a time on a host): it builds both programs, then runs eight pairs, the order alternating (old new, new old), each run pinned to CPU 2. `read.py FOLDER` prints the tables below: the median of the eight runs at each commit, and the geometric mean of the eight pairs' ratios.

Limits: a probe. `Instant` timing, no load windows, no cycle counts. It times the core call with two small closures, and says nothing of a whole Pipeline submission.

## Results: the PR's tree (`probe-5`)

Ryzen 7 9700X:

| Group | old, ns | new, ns | new / old | pairs: least to greatest | pairs slower |
|---|---|---|---|---|---|
| 2 x 64 B | 75.9 | 49.1 | 0.644 | 0.616 to 0.663 | 0 of 8 |
| 3 x 64 B | 122.4 | 96.9 | 0.790 | 0.768 to 0.806 | 0 of 8 |
| 4 x 64 B | 79.3 | 61.1 | 0.767 | 0.750 to 0.777 | 0 of 8 |
| 8 x 64 B | 91.2 | 79.6 | 0.870 | 0.858 to 0.884 | 0 of 8 |
| 16 x 64 B | 99.6 | 93.9 | 0.941 | 0.929 to 0.948 | 0 of 8 |
| 64 x 64 B | 356.7 | 357.0 | 1.006 | 0.988 to 1.027 | 5 of 8 |
| 2 x 128 B | 137.9 | 114.3 | 0.826 | 0.806 to 0.839 | 0 of 8 |
| 2 x 1024 B | 1003.3 | 978.3 | 0.975 | 0.972 to 0.977 | 0 of 8 |
| 16 x 1024 B | 1161.3 | 1156.5 | 0.996 | 0.993 to 0.999 | 0 of 8 |

EPYC 9255:

| Group | old, ns | new, ns | new / old | pairs: least to greatest | pairs slower |
|---|---|---|---|---|---|
| 2 x 64 B | 94.2 | 62.0 | 0.651 | 0.627 to 0.673 | 0 of 8 |
| 3 x 64 B | 152.4 | 121.4 | 0.791 | 0.769 to 0.809 | 0 of 8 |
| 4 x 64 B | 99.6 | 76.9 | 0.773 | 0.757 to 0.786 | 0 of 8 |
| 8 x 64 B | 114.2 | 98.8 | 0.866 | 0.828 to 0.903 | 0 of 8 |
| 16 x 64 B | 124.1 | 116.2 | 0.934 | 0.889 to 1.007 | 1 of 8 |
| 64 x 64 B | 444.3 | 440.2 | 0.994 | 0.969 to 1.002 | 3 of 8 |
| 2 x 128 B | 174.2 | 144.1 | 0.825 | 0.811 to 0.841 | 0 of 8 |
| 2 x 1024 B | 1267.4 | 1236.5 | 0.975 | 0.974 to 0.978 | 0 of 8 |
| 16 x 1024 B | 1440.5 | 1434.4 | 0.995 | 0.991 to 1.001 | 1 of 8 |

Three messages take longer than four at both commits. The likely reason is the rounding of three inputs up to four lanes (`hash_many_rounded`); this probe did not look into it.

## All five runs

The ratio new / old for the smallest and the largest group of 64-byte messages:

| Run | Old | New | 9700X, 2 x 64 B | 9700X, 64 x 64 B | EPYC 9255, 2 x 64 B | EPYC 9255, 64 x 64 B |
|---|---|---|---|---|---|---|
| `probe` | `0509bc84` | `908a5029` (the first repaired form) | 0.660 | 1.007 | 0.654 | 0.995 |
| `probe-2` | `0509bc84` | `127ab697` (comments changed) | 0.646 | 1.003 | 0.659 | 1.000 |
| `probe-3` | `0509bc84` | `1e7f7d4d` (the redundant capacity assertions removed, a test added) | 0.642 | 0.999 | 0.651 | 0.998 |
| `probe-4` | `0509bc84` | `ee5d9e41` (an alias renamed) | 0.654 | 1.008 | 0.654 | 1.003 |
| `probe-5` | `3bfbbd07` | `ea282e84` (rebased on the new `next`; the tree of the PR head) | 0.644 | 1.006 | 0.651 | 0.994 |

**Posted:** the commit message and the reply on [BLAKE3 PR #484](https://github.com/servil-software-factory/BLAKE3/pull/484).
