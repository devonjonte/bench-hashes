# Mutation checks on x86-64 for BLAKE3 #219's first four families (i7-12700K)

The whole `tools/mutants/check.py --write` runs behind PRs #225, #226,
#227 and #228 (johnservil/BLAKE3), each on the stack's top at the time:
`check.stdout.txt` (family 1, 58 min), `check3.stdout.txt` (families 1-3,
50 min, the last of three attempts), `check4.stdout.txt` (families 1-4
with sme2_sized and the park test, 48 min, the last of five attempts;
earlier attempts stopped on stale rows or a Shuttle-build failure of a
test since gated). Each `run*.stdout.txt` is a run's exit and time.
`known-x86_64.txt`: 604 rows at the start, 485 at the end; no new
survivor in any run.
