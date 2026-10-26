# My open PRs together on John's candidate, i7-12700K: every cell level, every mutant known

**Question:** do #176 (wake_one alone), #177 (Arm reasons), #179 (word
conversions) and #182 (the wide kernels' x86 rows), merged onto johnservil/BLAKE3
`candidate/release-0.8` f448bb3, hold together?

**Commits:** devonjonte/BLAKE3 `night/devon-integration`: e8b659b for the
speed check (#176, #177, #179), f14f312 for the mutation check (with #182).

**Commands,** each under run-bounded.py, October 26:
- `speed-run.sh`: `check --against origin/candidate/release-0.8 --cells
  all --pairs 8` (05:41-06:12 UTC; its mutation step stopped at once on a
  duplicated row, corrected in f14f312): **no cell slower**, both stages.
- `mutants-run.sh`: `check.py` at f14f312 (06:13-06:52): **646 survive,
  each known and explained; 35 time out, each known.** Then the gate of
  #181 (every unsupported target stops): passed (`targets-gate.stdout.txt`).

An earlier speed check (04:14, e8b659b) had no verdict: the machine was
busy during 3 runs, from my own rebase builds beside it.

**Posted:** BLAKE3 #182.
