# Do the "equally correct paths" shortcuts earn their places? (x86, i7)

**Question** (Zooko, October 24): a mutation survivor nobody can test is
a line to consider removing. Four x86 shortcuts have two correct paths
and many survivors; is the faster path's code worth keeping?

**Commits.** devonjonte/BLAKE3 line 08ffe77; each branch `ab/NAME` is it
with one shortcut off (`stubs.py`): spare-lane 72e9605 (`spare_lane`
None), across-from 10e393f (`across_from` None), pair-takes 0aa1f99f
(`pair::takes` false), many-early 412996fc (`hash_many_on`'s one-block
path off). Measurements only: no branch is landed.

**Command.** `ab-sweep.py`: `bench-hashes check --against 08ffe77`
(two stages, bench-hashes 1bc45a7a), one at a time, quiet i7-12700K.

**Verdict.** Each shortcut earns its place:
- spare_lane off: 7935 B +29.4% (after other work), +52.8% (after a pause).
- pair::takes off: 1536 B +21.7% to +29.0%, servil st and mt.
- hash_many_on's early path off: batch cells +21.5% to +234% (lent
  batches of 16-1024 messages about 3x).
- across_from off: level, but the check chose 14 cells and none hashes a
  batch of 2-15-chunk messages, the case it serves; its commit (2478d66)
  measured 0.35-0.52x on a P core, 0.53-0.86x on an E core. No FROZEN
  cell covers it, so no check can guard it.

`feed`'s first-subtree value runs on SME2 only (Arm): John's M4.

**Posted.** WORK-STATE; the survivors' reasons in tools/mutants/known-x86_64.txt.
