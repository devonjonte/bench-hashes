# bench-hashes 0.21 at its tag on the EPYC 9255 (Zen 5, 48 threads, AVX-512), November 12, 2026

**Question.** The release runs of 0.21 (tag v0.21.0+84236bf0, pin
BLAKE3-Servil 2037118c) on this machine.

**Command.** `run.sh`, under the machine's lock (`stdout.txt`).

| run | result |
|---|---|
| full, b3sum | exit 0; load quiet |
| crowd | exit 0 |
| release check against 0.8, the long stream cells named (`check-long.*`) | no cell slower |
| the same over every cell (`check.*`) | no cell slower, both stages; 20 cells faster |
| same-library check (`check-same.*`) | no cell slower, both stages |

**Published.** bench-hashes `next`
(`benchmark-results/AMDEPYC925524CoreProcessor.linux70038generic/`),
bench-hashes #163.

**Machine.** EPYC 9255, 48 threads, Linux 7.0.0-38, governor `performance`.
