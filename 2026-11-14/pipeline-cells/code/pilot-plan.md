# Pipeline candidate pilot — declared November 14, 2026

Question: what does the new room/batch caller cost, beside the retained synchronous caller,
with the same library and fixed selected workload context on EPYC 9275F?

Baseline bench d1c20fdfcf75918e5a144f235a27484a3de1dc32 (pin only).
Candidate bench 55436819e59a20eaa47a79f81e6594872ea40ff4.
Library on both sides f62bc6ac0bc1c86861659d61ffbf4e9546bc8aec.

One locked job, bounded to 45 minutes, runs:
1. Same candidate source on both sides, four fresh-layout pairs.
2. Baseline versus candidate, four fresh-layout pairs.

Scope held identical across both questions:
- owned and lent messages: 64 B, 4 KiB, 64 KiB, 1 MiB;
- owned and lent batches: 16, 256, 4096 messages;
- continuous collections: git objects and Nix files;
- receiving: saturated, 2 microseconds and 20 microseconds.
Single contender, Servil mt; check's solo scope. These questions use the existing
probe path with --layouts 4, so there is no adaptive second-stage context change.
Raw samples, CPU time and available counts go through the standard reader.
Counter absence is reported as absence. Busy/abstaining/error runs stay evidence.

This first pilot establishes gross behavior, successful completion and an A/A control.
It supplies no release acceptance or equivalence claim. Small effects wait on a
known-extra-work control in exactly this context; its experiment must be declared
before collection. Large Pipeline costs also stay visible, whatever the A/A reads.

After reading the pilot, test the known-extra-work control and the shared scenario
where they can change a decision. Cross-platform gates follow a reviewed candidate.
No system memory policy or affinity redesign is introduced.
