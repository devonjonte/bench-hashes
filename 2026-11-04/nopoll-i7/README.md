# Deletion trial: the caller parks at once (no SPIN_BEFORE_SLEEP / YIELD_EVERY polling), i7-12700K

**Question** (BLAKE3 #234, Zooko's refined plan on #219: where a knob's
benefit is in doubt, delete it and let the check decide). Does a caller
that parks at once for its last pieces, instead of polling 200 us with a
yield every 20 us, slow any cell?

**Commits.** New side: `exp/devon-no-caller-poll` 35c5a53b (ad2fe6f9 as
pushed) on top of `candidate/devon-mutants-scheduling` 0d6fc148, the old
side. bench-hashes 0.20.0 (74e3edaf), `check --cells all`.

**Verdict.** First stage: no cell slower (4 pairs). Second stage, 64
pairs on 8 suspects: **6 cells slower**: servil mt IdleManyMessages
16384 +4.9%, 32768 +3.1%, 65536 +4.7%; ManyMessages 16384 +4.3%;
OneMessage 512 KiB +6.1%; IdleOneMessage 1 MiB +5.3%; most pairs
positive in each. The caller's poll before sleeping pays on the pool's
one-shot calls, where the last pieces finish within the poll.

**So:** SPIN_BEFORE_SLEEP and YIELD_EVERY stay, with #234's tests (the
rule's first outcome).

**Posted.** BLAKE3 #234.
