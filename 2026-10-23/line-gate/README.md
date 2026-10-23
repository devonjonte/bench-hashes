# Devon's line of the fork: the gate on 87b4fd5 (October 23, 2026)

devonjonte/BLAKE3 `servil` at `87b4fd5`: John's `servil` `8e968d5` plus
the landings of #127, #132, #126, #128, #129 and Sam Shackleton's #133
(with the check.py fixes of `3394a99`), each a merge naming its source.

- `gate-suites.*`: 100 and 99 nextest tests, 22 doc tests, 3 vectors,
  4 C API, every build, the proof helpers under z3: all pass.
- `gate-mutants.*`: `python3 tools/mutants/check.py`, six shards, bounded
  9000 s, on the i7-12700K: exit 0, 646 survive each known and explained,
  one name confirmed alone; about 55 minutes.

No kernel changed, so bench-hashes' speed check is skipped (it would
compare identical machine code).
