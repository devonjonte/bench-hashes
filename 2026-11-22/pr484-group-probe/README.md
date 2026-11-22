# The group call on separately borrowed short messages, before and after BLAKE3 PR #484 (November 22, 2026)

**Question.** The review of [BLAKE3 PR #484](https://github.com/servil-software-factory/BLAKE3/pull/484) (drop `arrayvec` and `cfg-if`) measured `TreeHasher::try_hash_group_on` 5.0% slower for a group of two 64-byte messages at the change's first form (`c753f206`, finding 9). Does the repaired form cost anything there?

**Verdict.** No: the repaired form is faster for small groups and level for large ones. A group of two 64-byte messages takes 0.654 of the time it takes at `next` on both machines (74.3 to 49.1 ns on the Ryzen 9700X, 93.7 to 62.0 ns on the EPYC 9255). The gain shrinks as the group grows, and sixty-four 64-byte messages read within 1% either way in all four runs.

**Why.** Two things, read in the machine code of a release build (`old-group.s` is the probe's `group` function at `next`, `new-group.s` at the PR's tree). At `next` the table of up to 128 message pointers is collected into an `Option<ArrayVec>` and then copied whole out of it, 1,028 bytes for every group. The repaired form fills the table where it stands. The first form's fill also loaded and stored the vector's length at every element, the likely source of its 5%. The repaired fill keeps the length in a register.

## Commits

- Old: BLAKE3 `next`, `0509bc84fc0a7e54a069c582b29f59cacd7a74ca`.
- New, the last run: `ee5d9e4193fda64009845611c4e22f458904aee7` (devonjonte/BLAKE3, branch `experiment/devon-484-group-probe`), tree `9fbefead556479acd46ee07687a1542f27ca0255`. The PR's head `dcee2bf5c13da3ef83a51179eab291cc513528fd` has that tree and another commit message.
- The three earlier runs measured the earlier forms named in the table at the end.

## Method

`probe.rs`: one program, built against each commit, that calls `try_hash_group_on` on `count` separately borrowed messages of one length and checks each digest once against `convenience::hash`. Each cell is the median of 15 rounds of about 20 ms. Each host's `run.sh` is the job as submitted, through `bench-submit` (one job at a time on a host): it builds both programs, then runs eight pairs, the order alternating (old new, new old), each run pinned to CPU 2. `read.py FOLDER` prints the tables below: the median of the eight runs at each commit, and the geometric mean of the eight pairs' ratios.

Limits: a probe. `Instant` timing, no load windows, no cycle counts. It times the core call with two small closures, and says nothing of a whole Pipeline submission.

## Results: the PR's tree (`probe-4`)

Ryzen 7 9700X:

| Group | old, ns | new, ns | new / old | pairs: least to greatest | pairs slower |
|---|---|---|---|---|---|
| 2 x 64 B | 74.3 | 49.1 | 0.654 | 0.634 to 0.674 | 0 of 8 |
| 3 x 64 B | 120.5 | 96.9 | 0.800 | 0.782 to 0.831 | 0 of 8 |
| 4 x 64 B | 78.8 | 61.0 | 0.767 | 0.717 to 0.802 | 0 of 8 |
| 8 x 64 B | 91.1 | 79.4 | 0.868 | 0.818 to 0.909 | 0 of 8 |
| 16 x 64 B | 99.5 | 93.9 | 0.946 | 0.882 to 1.018 | 2 of 8 |
| 64 x 64 B | 357.2 | 359.6 | 1.008 | 0.996 to 1.021 | 7 of 8 |
| 2 x 128 B | 136.4 | 114.3 | 0.833 | 0.820 to 0.846 | 0 of 8 |
| 2 x 1024 B | 1002.4 | 978.3 | 0.976 | 0.973 to 0.978 | 0 of 8 |
| 16 x 1024 B | 1161.9 | 1158.1 | 0.996 | 0.991 to 1.001 | 2 of 8 |

EPYC 9255:

| Group | old, ns | new, ns | new / old | pairs: least to greatest | pairs slower |
|---|---|---|---|---|---|
| 2 x 64 B | 93.7 | 62.0 | 0.654 | 0.633 to 0.676 | 0 of 8 |
| 3 x 64 B | 152.0 | 121.4 | 0.794 | 0.774 to 0.812 | 0 of 8 |
| 4 x 64 B | 99.3 | 76.8 | 0.774 | 0.763 to 0.787 | 0 of 8 |
| 8 x 64 B | 114.1 | 98.8 | 0.866 | 0.861 to 0.873 | 0 of 8 |
| 16 x 64 B | 123.8 | 116.2 | 0.936 | 0.899 to 0.950 | 0 of 8 |
| 64 x 64 B | 442.6 | 445.5 | 1.003 | 0.982 to 1.018 | 6 of 8 |
| 2 x 128 B | 173.3 | 144.1 | 0.827 | 0.813 to 0.841 | 0 of 8 |
| 2 x 1024 B | 1266.8 | 1236.6 | 0.976 | 0.973 to 0.978 | 0 of 8 |
| 16 x 1024 B | 1439.5 | 1434.1 | 0.996 | 0.992 to 0.997 | 0 of 8 |

Three messages take longer than four at both commits. The likely reason is the rounding of three inputs up to four lanes (`hash_many_rounded`); this probe did not look into it.

## All four runs

The ratio new / old for the smallest and the largest group of 64-byte messages:

| Run | New commit | 9700X, 2 x 64 B | 9700X, 64 x 64 B | EPYC 9255, 2 x 64 B | EPYC 9255, 64 x 64 B |
|---|---|---|---|---|---|
| `probe` | `908a5029` (the first repaired form) | 0.660 | 1.007 | 0.654 | 0.995 |
| `probe-2` | `127ab697` (comments changed) | 0.646 | 1.003 | 0.659 | 1.000 |
| `probe-3` | `1e7f7d4d` (the redundant capacity assertions removed, a test added) | 0.642 | 0.999 | 0.651 | 0.998 |
| `probe-4` | `ee5d9e41` (an alias renamed; the tree of the PR head) | 0.654 | 1.008 | 0.654 | 1.003 |

**Posted:** the commit message and the reply on [BLAKE3 PR #484](https://github.com/servil-software-factory/BLAKE3/pull/484).
