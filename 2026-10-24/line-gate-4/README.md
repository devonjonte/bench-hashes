# Line gates, October 24 2026 (i7-12700K)

**Question.** Does the line stay as fast, and do its mutation lists stay
complete, through: the park/wake handshake moved to `src/park.rs` under
Shuttle with a dropped wake fixed (c95c5f8); every handshake atomic
SeqCst and the park simplified by its survivors (e2504be); John's servil
f418f07 merged (a20fb40)?

**Commits.** Line tip a20fb40 on devonjonte/BLAKE3 `servil`; speed
baseline 8bd5af6 (the previous tip).

**Commands.** `bench-hashes check --against 8bd5af6` (gate13: c95c5f8;
gate15: e2504be; gate17: a20fb40), each under `run-bounded.py 5400`;
`tools/mutants/check.py --write` (gate14 on c95c5f8, gate16 on e2504be).

**Verdicts.**
- gate13: 312 cells execute a changed line; none slower.
- gate14: exit 0; 658 survivors, 16 names new (park.rs); 49 time-outs.
- gate15: 312 cells; none slower (the owed-wake cascade removed).
- gate16: exit 0, 56 min; 645 survivors, 47 time-outs, each with a reason
  after 8dcae21 (two rows retired: wake_one's `& -> |` is caught by the
  new Shuttle schedule two_wakers_wake_two_workers).
- gate17: none slower after John's merge (cargo-c capi; QUALITY text).

**Posted.** johnservil/BLAKE3 #139 (round 3 comment), #140.
