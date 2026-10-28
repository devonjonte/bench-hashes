# A stream's fill that may write short (BLAKE3 #204), i7-12700K

**Question:** Zooko holds 0.8 over #204 (`submit_with`'s fill leaving part
of its room unwritten gives a wrong digest, no error). Is the hazard
real, and what does a fill that reports its count cost?

**Commits:** old johnservil/BLAKE3 83d59db2 (0.8's version commit), bench
0.18.1 2c9633ae; new devonjonte/BLAKE3 `exp/devon-fill-like-read` c09e2100
(`fill(at, room) -> usize`, called again until the room is full, as a read
loop; a fill returning 0 before the message's end panics), bench
devonjonte `exp/devon-bench-fill-count` 946555d2 (its six fill closures
return `room.len()`).

**Reproduction** (`short_fill.rs`, on 83d59db2): a fill that writes all but
the last 1000 bytes of each room, after a message that left 0x5A in the
ring: **the digest differs from the message's hash, with no error.**

**Commands** (run-bounded.py, October 28): `check --against 83d59db2
--old-bench 2c9633ae --cells all` (`check/`); then the second stage's
three leaning cells, 24 pairs, A/B and old against old (`confirm.sh`).

**Verdict:** no cell slower in either stage. Every stream cell, the only
ones that call fill, reads level (x0.95-1.03). One cell leans at 24
pairs: mt IdleManyMessages 16 (after a pause), x1.110 (6 of 24 faster)
against x1.025 old against old, judged level. It runs no stream code, and
it is the cell whose cold starts are bimodal (bench-hashes #81).

**Posted:** BLAKE3 #204.
