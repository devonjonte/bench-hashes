# Small batch calls, warm: instructions and cycles per call, bfbda19 against f1db8cd, i7-12700K

**Question (BLAKE3 #125):** the candidate f1db8cd reads a few percent
slower than bfbda19 on small batches in the bench (LentBatches 64-1024,
the fast state of small mt batches after a pause). Alignment, the wakes
and inlining are ruled out (`../inline-never-i7`, `../../2026-10-25/`).
Does the library's own code cost more per small call?

**Commits:** devonjonte/BLAKE3 bfbda19 (old API) and johnservil/BLAKE3
f1db8cd (performance API), plain release builds of the probes here
(`small_probe-*.rs`: 2,000,000 calls of `hash_many` over 1-64 64-byte
messages; `offset_probe-*.rs`: the input and output at chosen offsets of
page-aligned memory). The probes are not committed to either branch.

**Commands:** `run.sh` (instructions and cycles, user space, pinned to P
core 2, 5 processes each), `run2.sh` (4 messages: placement, and address
randomization on and off), then `run.sh` again (`run-repeat.stdout.txt`).

**Verdict:** the candidate's code costs no more per small call.
- Instructions per call: 748 -> 690 (1 message), 713 -> 702, 1230 -> 1219,
  2772 -> 2761, 10350 -> 10339 (64): the candidate runs fewer at every count.
- Cycles per call are level or lower at 1, 2, 16 and 64 messages.
- At 4 messages the cycles flip between about 324 and about 343 over
  minutes, for both commits and every placement. `run.sh` caught the
  candidate in the slow state (342 against 325). In `run2.sh` bfbda19 was
  slow too (345, and 346 with randomization off), and in the repeat its
  64-message figure was 3,860 against the candidate's 3,616. Same
  instructions, a state of the machine; it may be the core's other
  hardware thread, which was not watched.

**Reading:** the small-call differences in the bench come from the
states around the call (cold after a pause, and this machine-wide slow
state, which neighbouring pairs share: bench-hashes #81), with no extra
work in the library. This closes the search for a code cause on the i7.

**Posted:** BLAKE3 #125.
