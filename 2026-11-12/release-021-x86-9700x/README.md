# bench-hashes 0.21 at its tag on the Ryzen 7 9700X (Zen 5, 16 threads, AVX-512), November 12, 2026

**Question.** The release runs of 0.21 (tag v0.21.0+84236bf0, pin
BLAKE3-Servil 2037118c) on the overview's chosen AMD machine.

**Command.** `run.sh`, under the machine's lock (`stdout.txt`).

| run | result |
|---|---|
| full, b3sum | exit 0; load quiet |
| crowd | exit 0 |
| release check against 0.8, the long stream cells named (`check-long.*`) | no cell slower |
| the same over every cell (`check.*`) | 26 cells faster (one message of 3 KiB to 7935 B by 24 to 45%; collections by 11 to 16%); one flagged slower at four pairs: single-threaded 256 KiB after a pause, 4.1% |
| same-library check (`check-same.*`) | one cell flagged at four pairs: multithreaded batch of 8 after a pause, 3.7% |

**Reading the two flags.** Each is a first-stage verdict on four pairs.
The same-library one has one library on both sides, so it is the two
benches' difference or chance; it says how much weight the other carries.

**Published.** bench-hashes `next`
(`benchmark-results/AMDRyzen79700X8CoreProcessor.linux70042generic/`),
bench-hashes #163 and #187.

**Machine.** Ryzen 7 9700X, 16 threads, Linux 7.0.0-42, `performance`.
