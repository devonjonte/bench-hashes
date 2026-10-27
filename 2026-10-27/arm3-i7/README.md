# hash_four_at_a_time's arm 3 (three left over on a spare lane), i7-12700K

**Question (BLAKE3 #183):** the survivor `delete match arm 3 in
hash_four_at_a_time` is listed as speed, but no bench cell runs it (x86-64
batches of 128 B to 1 KiB messages, whole last blocks, a count of 4k+3).
Does the arm earn its place?

**Builds:** devonjonte/BLAKE3 `candidate/devon-no-portable` 8769d4b3
(**keep**); the same with arm 3 deleted (**delete**, `delete.diff`: three
left over hashed one at a time); the same with x86-64 always passing
every lane to the platform's `hash_many` (**whole**, `whole.diff`).

**Command:** `run.py`: `arm3_probe.rs` (`performance::hash_many` over
COUNT messages of LEN bytes, warm), pinned to P core 2, user-space
instructions and cycles per call, 5 rounds rotating the builds.

**Verdict:** keep the arm.
- Deleted, a batch with three left over costs x1.25 (19 messages) to
  x2.25 (3 messages of 1 KiB) the cycles.
- Whole `hash_many` is the simplest alternative, and costs x1.08 to x1.50.
- Counts of 4 and 8 run the same code in every build and read level,
  apart from one cell, 8 x 256 B: x1.07 with identical instructions, the
  machine state seen before (`../../2026-10-26/small-call-counts-i7`).

| count | len | delete | whole |
|---|---|---|---|
| 3 | 128 | x1.929 | x1.324 |
| 3 | 1024 | x2.245 | x1.497 |
| 7 | 256 | x1.564 | x1.210 |
| 19 | 1024 | x1.328 | x1.130 |

The survivor stays a speed row, now with its figure. The bench still has
no cell on this path, so a FROZEN point (a batch of 7 messages of 256 B,
say) would let the bench catch the mutant.

**Posted:** BLAKE3 #183.
