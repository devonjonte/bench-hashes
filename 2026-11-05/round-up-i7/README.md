# BLAKE3 #248, the lanes rounded up: the i7's check (November 5, 2026)

`bench-hashes check --fork BLAKE3-m3 (01c1beb5, candidate/devon-round-up-lanes) --against a2651d64`,
bench 5a3aa99d, the machine quiet (queue.py's gate), 51 min: 426 cells at 4 pairs, 8 suspects on 64.

Verdict: **no cell slower in either stage.** Faster in the first stage: brief idle 3 KiB -29.0% (st and
mt, every pair -28 to -31%); in the second stage (64 pairs): OneMessage 3 KiB -16.9%, IdleOneMessage
3 KiB -10.6%. Instructions +9% at 3 KiB (four lanes for three chunks: more work, less time), the
suspect rule's pointer. mutants*.txt: check.py on the change, 26 mutants all caught.

# rows-238-i7

BLAKE3 #251 (35d75dc2 against a2651d64), the same check: no cell slower in either stage.
