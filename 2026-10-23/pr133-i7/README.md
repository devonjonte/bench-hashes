# BLAKE3 #133 on the i7-12700K (October 23, 2026)

Sam Shackleton's PR (`825bb6b`, mutation testing on an AVX-512 machine)
run on the i7-12700K (20 CPUs, 14 GiB, Linux 7.0, no AVX-512), as the PR
asked, with Devon's two `check.py` fixes on top (`3394a99`,
`candidate/devon-pr133-scratch`): worktrees under the repository's `tmp/`
(not `/tmp`, a tmpfs here) and a data-memory cap sized to the machine.

- `suites.*`: every suite in CONTRIBUTING at `825bb6b`: 100 and 99
  nextest tests, 22 doc tests, 3 vectors, 4 C API, every build passes.
- `check.stdout.txt`, `check-supervisor.txt`: `python3 tools/mutants/check.py`
  at `3394a99`, 6 shards, bounded 9000 s; exit 0, "646 survive, each known
  and explained", 37 places caught by the clock alone, 55 minutes.
- `tests.tsv`: every test's outcome and time on every mutant (the record
  the check keeps).
- `check-oom-attempt*.stdout.txt`, `check-as-cap-attempt.stdout.txt`,
  `check-floor-1-supervisor.txt`: the failed runs at `825bb6b` unmodified
  (two killed the sandbox: worktrees in tmpfs), with a 2.2 GiB
  address-space cap (rust-lld crashed: 355 of 357 unviable), and with a
  data cap of (RAM − 2 GiB)/6 (the supervisor's memory floor killed it at
  1 GiB available: several runaway mutants at once).
