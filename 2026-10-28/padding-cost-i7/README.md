# The cost of checking hash_many's padding in every build (BLAKE3 #205), i7-12700K

**Question:** Zooko holds 0.8 over #205 (nonzero padding after a message
gives a wrong digest, unchecked in release builds). What does checking it
in every build cost?

**Commits:** old johnservil/BLAKE3 83d59db2 (0.8's version commit, with
one docs-only commit, #203); new devonjonte/BLAKE3 `exp/devon-padding-checked`
12c75ec5: `many::assert_slots` checks the padding with `assert!`, reading
each slot's last block as eight words, the message's bytes masked off
(first version 48ed9ae6: a byte-by-byte fold; `run-v1-fold.stdout.txt`).
A test plants a nonzero byte at every padding position at every length.

**Commands** (run-bounded.py, October 28, 04:40-06:10 UTC):
- `run.py`: warm `hash_many` calls over a Batch, pinned to P core 2,
  user-space instructions and cycles per message, 7 rounds alternating.
- `check/`: `bench-hashes check --against 83d59db2` (bench 0.18.1), the
  cells coverage chose (every hashing cell), two stages.
- `confirm.sh`: the three cells the second stage leaned on, 24 pairs, A/B
  (`confirm-ab/`) and old against old (`confirm-aa/`).

**Verdict:** the check costs about 30 instructions (5 cycles) a message
whose length is not a multiple of 64, and nothing otherwise.

| messages | length | cycles a message, new/old |
|---|---|---|
| 1024 | 1 B | x1.019 |
| 1024 | 33 B | x1.020 |
| 1024 | 100 B | x1.012 |
| 1 | 100 B | x1.033 (the mask set up for one message) |
| 1024 | 200 B | x1.006 |
| 256 | 1000 B | x1.002 |
| 1024 | 64 B | x1.000 (not checked: no padding) |

No bench cell has an odd length, so the check finds no cell slower
(both stages). Read whole, three mt cells leaned slower at 16 pairs
(x1.08-1.15). At 24 pairs they read x0.91-1.03, inside the A/A spread
(x0.92-1.02); one of them never calls hash_many.

**Posted:** BLAKE3 #205.
