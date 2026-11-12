# bench-hashes 0.21 at its tag on the EPYC 9275F (Zen 5, 48 threads, AVX-512), November 12, 2026

**Question.** The release runs of 0.21 (tag v0.21.0+84236bf0, pin
BLAKE3-Servil 2037118c) on a machine of the newest x86-64 design measured.

**Command.** `run.sh`, under the machine's lock (`stdout.txt`).

| run | result |
|---|---|
| full, b3sum | exit 0; load quiet |
| crowd | exit 0 |
| release check against 0.8, the long stream cells named (`check-long.*`) | no cell slower, both stages |
| the same over every cell (`check.*`) | no cell slower, both stages; faster: one message of 3 KiB to 7935 B, collections |
| same-library check (`check-same.*`) | no cell slower |

**Published.** bench-hashes `next`
(`benchmark-results/AMDEPYC9275F24CoreProcessor.linux70042generic/`),
bench-hashes #163 and #187.

**Machine.** One EPYC 9275F, 48 threads, 384 GB, Linux 7.0.0-42, governor
`performance`; rented for bench-hashes' timing work.
