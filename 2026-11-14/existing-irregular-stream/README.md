# Check the existing irregular-stream coverage first

November 14, 2026. Before adding a workload, source inspection found that the
existing single-threaded saturated receive case already feeds irregular fragments
through the shared incremental adapter. Its 16 MiB input matches the existing
continuous 16 MiB cell. Both copy into the kept 64 KiB buffer and consume every digest.
Receive cycles 1448/4096/16384/65536-byte fragments; continuous uses 64 KiB pieces.
No new harness code or point is needed for this first question.

Question: does that existing case expose John's whole-group/staged-tail fix,
while the aligned case and an unchanged-code comparison provide context?

- Benchmark da6fe3c478e3e25c23ab05514a1723e1e20f5e2f, one source for both sides.
- Library 8041bd858586abafa0857fb4ec5ed1f0767f67a4 → ab256b0d9ebb44eececd71ce0ae37113e75634a5.
- Points: `continuous 16 MiB,receive saturated`; blake3-servil-st only.
- Three fresh-layout pairs per question: fixed/fixed control, then parent/fixed.
- Existing check --probe/reporting and clocks rules; EPYC 9275F host lock,
  unchanged default memory policy, current quiet preflight, 30-minute job bound.
- --old-bench explicitly names the same benchmark for the unchanged control;
  that bypasses the intentional no-change early exit and measures its variation.
- Keep driver logs beside new/empty kept directories. Retain all raw runs/retries.

The old/new estimate within each cell is the primary comparison. Comparing the
two cells also crosses their workload phases, so that ratio alone cannot isolate
fragmentation cost.

This is a coverage/sensitivity probe, not full-procedure calibration or a release
gate. Level leaves uncertainty. It does not resolve the full-run costs retained
in the library commit. Available counters are recorded; absent counters remain
an attribution limit. If the existing workload supplies the evidence, reuse it.
Add a new case only after identifying a specific remaining gap. No repeat campaign
is planned to obtain a preferred label.
