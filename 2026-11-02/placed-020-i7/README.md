# Placed shared copies: A/A check of every cell (bench 0.20 candidate a40c26db)

**Question.** The shared scenario's two copies are now pinned to chosen CPUs
(two physical cores under one last-level cache; on the i7, CPUs 0 and 2),
as a layer `shared-one-cache`. Does the placed build judge a library
against itself clean, every cell?

**Commits.** bench-hashes `candidate/devon-shared-mt-only` a40c26db
(PR #115); the fork at 0.8, b5b988d8, against its own working tree
(`/home/agent/BLAKE3-rel019`, a022ca1a).

**Command.** `run.sh`: `check --fork /home/agent/BLAKE3-rel019 --against
b5b988d8 --cells all --keep aa`, under `run-bounded.py` (4 h cap).

**Machine.** i7-12700K, Linux 7.0.0-42, mains, governor powersave, EPP
performance; tailscaled and nym-vpnd pinned to CPUs 16-19.

**Verdict.** `no cell slower`, first stage (8 runs, 4 pairs, 157 s each)
and second stage (64 pairs on the 8 suspects, 7.9 s each); 1964 s in all.
Two of the suspects are placed shared cells (ContinuousMessages 64 B and
128 B); both cleared. The per-pair cost matches #115's unplaced build
(158 s), since the i7 has one cache and measures one placement.

**Posted.** bench-hashes PR #115.
