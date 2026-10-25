# The over-read fix's cost (55b62ad, #92), servil's own kernels on both sides, i7-12700K: none measurable

**Question (#168):** what does 55b62ad (the AVX2 and AVX-512 batch kernels'
two- and four-input loads kept within each input) cost? Its own check ran
official's kernel on both sides.

**Commits:** new, devonjonte/BLAKE3 `candidate/devon-kernel-names-john`
bfbda19 (#164, with the fix); old, `exp/devon-overread-unfixed` a137c68
(the same with 55b62ad's load changes undone: upstream 1.8.7's bytes once
the rename is undone; the guard-page tests fault). Both under servil's own
names, so both run servil's own kernels. Bench 5be5f236 on both sides.

**Runs:**
1. `check --against a137c68 --cells all` (4 pairs, then 16): "no cell
   slower" in both stages.
2. `small/`: `regress` on the check's 20 relinked layouts a side, servil
   st and mt, batches of 2, 3, 4, 6 and 12, warm and after a pause, 23
   pairs: **every cell level**, 9 to 17 of 23 pairs faster
   (`small/compare.txt`).

**Reading:** on AVX2 the fix costs nothing measurable; servil's kernel and
upstream's run alike. The first stage's 4-pair ratios on these cells move
±10% from run to run, so they support no figure alone: the figures of
`../names-only-i7` (+4% to +19%) were such ratios, and this run does not
bear them out. AVX-512 is the EPYC's to measure (asked on #168).

**Posted:** BLAKE3 #168.
