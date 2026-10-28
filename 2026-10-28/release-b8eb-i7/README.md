# 0.8 at b8ebc5a7 on the i7-12700K: the x86 list, and the Batch API's cost per call

**Commits:** johnservil/BLAKE3 b8ebc5a7 (hash_many inline(always), Batch
counts its messages when asked); b52735e9 (Batch's methods #[inline]);
83d59db2 (the old API, `hash_many(mode, &[Block], len, out)`).

**Commands:** `check.py --write` at b8ebc5a7 (`mutants.*`); `probe.py`:
warm `hash_many` over COUNT 64 B messages, **the length read at run time**
(as the bench passes it), P core 2, three builds rotating, 7 rounds.

**Verdicts:**
- The x86 list at b8ebc5a7: exit 0, 639 survive, 32 time out, none new, and
  `--write` changes no row: the merged list (#207) holds.
- Per call: b52735e9 runs 17 instructions more than the old API at every
  count; b8ebc5a7 runs exactly the old API's count, cycles level
  (x0.999-1.002; 64 messages x0.936). The earlier probe
  (`../release-b527-i7`) passed the length as a constant, which the
  compiler folded: it could not see this cost.

**Posted:** BLAKE3 #125.
