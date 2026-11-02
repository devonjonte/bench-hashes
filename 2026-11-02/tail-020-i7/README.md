# Every shared sample contended (#105) and crowd: A/A of every cell (bench 0.20 candidate 69cda51d)

**Question.** With the copy that finishes first hashing on until the
other finishes (d09640a4) and `crowd` added (69cda51d), does the bench
judge a library against itself clean, every cell?

**Commits.** bench `candidate/devon-shared-mt-only` 69cda51d (PR #115);
the fork at 0.8, b5b988d8, against its own working tree.

**Command.** `run.sh`: `check --fork /home/agent/BLAKE3-rel019 --against
b5b988d8 --cells all --keep aa`, under `run-bounded.py`. A first attempt
lost its second-stage verdict to a busy window (0.65 CPUs of other load
for one second); this is the rerun.

**Verdict.** `no cell slower`, both stages (4 pairs, then 64 pairs on 8
suspects), 2025 s. i7-12700K, Linux 7.0.0-42, mains, powersave/EPP
performance.

**Posted.** bench-hashes PR #115.
