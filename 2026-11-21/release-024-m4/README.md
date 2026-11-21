# The Apple M4 at bench-hashes 0.24.0, BLAKE3-Servil 0.10.0 (November 21, 2026)

**Question.** The timing Mac `mac-m4-timing` (Apple M4: 4 performance and 6 efficiency cores, 16 GB) took its first jobs today. Does it measure quietly, and does 0.10.0 (`2fd4ff6f`) read slower than 0.9.1 (`2c60420c`) on it?

**Verdict.** It measures quietly, and 0.10.0 reads no cell slower than 0.9.1 with one benchmark on both sides. The marks of the mixed-bench release check did not repeat.

| Job | What | Result |
|---|---|---|
| 3560 | full library run | ok; load quiet, 0.08 CPUs on average, 0.54 in the busiest window |
| 3561 | `b3sum` | ok; load quiet, 0.18 CPUs on average, 0.57 in the busiest window |
| 3562 | crowd | ok |
| 3563 | control: library 0.10.0 on both sides, benches 0.23 and 0.24 | no cell slower; no level cell's instructions moved beyond +0.5% |
| 3564 | release check: old side bench 0.22, new side bench 0.24 | 9 slower, 59 faster: `st ContinuousMessages` 64 B to 1 KiB +5.6% to +6.0%; `mt LentMessages 256 B` +5.5%; `mt LentBatches 4096` +5.1%; `mt ManyMessages 8192` +6.3%; `mt OneMessage 512 KiB` +6.3% |
| 3565 | those points by name, bench 0.22 on both sides, 16 layouts | **no cell slower** |

So the marks of job 3564 come from the difference between benches 0.22 and 0.24 on this machine, or from four pairs' luck. Which benchmark change moves the single-threaded small-message cells on the M4 is unexamined; the M6 does not show it (job 3553).

**Commits.** bench-hashes 0.24.0 `3f3ef25130feadb67da742924dd6cfdc4c7886fb`; 0.23.0 `cade30fdb71682719f5fa3e586ff96146ae9fc25`; 0.22.0 `97c0fbcbedb8fe8f8395115647684dfde75d67a3`. BLAKE3-Servil 0.10.0 `2fd4ff6f643ef04f98f7a2e5f8ca0f096298827a`; 0.9.1 `2c60420c2bccbf6073e35e668691d98520f9b096`.

**Commands.** Each folder holds the job file (`job.json`), `verdict.json` and `runner.log`. The samples and outputs are in the public `mac-runner` exchange under `results/`, in folders of the same names.

**Posted:** ops #22 (private).
