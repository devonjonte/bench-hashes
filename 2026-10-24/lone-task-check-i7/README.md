# fix/lone-task against servil, i7-12700K: no cell slower

**Question:** do the stream ring's 64-byte alignment (Sam Shackleton's
32ed697, BLAKE3 #144) and the lone-task test with `run_waiting` (62f7ca1,
BLAKE3 #140) slow any cell, before they land on the line?

**Commits:** devonjonte/BLAKE3 `fix/lone-task` 62f7ca1 (new) against
`servil` 5e5742a (old); the bench in the fork's `bench-hashes/` at
f4a8f4eb.

**Command:** `bench-hashes check --against servil --keep kept` from the
fork's `bench-hashes/`, under run-bounded.py (2400 s), the machine
otherwise idle (load 0.3 before).

**Verdict:** "regress: no cell slower" in both stages. The first stage's
suspects (servil mt's solo ContinuousCollection Nix files,
ContinuousMessages 64 KiB, 256 KiB and 16 MiB, ContinuousBatches 256 and
65536) went to the second stage's 16 fresh pairs, which judged every one
level (two remained suspects there, below the margin). The samples are in
`kept/` (first stage `run-*.tsv`, second stage `second/`), the output in
`check.stdout.txt`.
