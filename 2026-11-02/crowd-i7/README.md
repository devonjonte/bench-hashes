# bench-hashes crowd on the i7-12700K: 20 programs at once (bench-hashes #116)

**Question.** `bench-hashes crowd` (new in the 0.20 candidate, 69cda51d
on `candidate/devon-shared-mt-only`): one program a CPU, each a process
with its own pool, the two multithreaded contenders at 1 KiB and 64 KiB
streams, 3 rounds of 2 s. What does the machine do in all, and how
unevenly are the programs served?

**Commits.** bench 69cda51d; blake3-servil 0.8 (b5b988d8); blake3 1.8.7.

**Command.** `run.sh`: `bench-hashes crowd --rounds 3` (20 programs).

**Result** (`full.stdout.txt`; the mean is per program, the total and
the ratio the median round):

| | ns per B a program | the machine | luckiest/unluckiest |
|---|---|---|---|
| servil mt, 1 KiB | 0.901 | 22.5 GB/s | x7.53 |
| servil mt, 64 KiB | 0.694 | 28.8 GB/s | x3.62 |
| official mt, 1 KiB | 1.001 | 20.0 GB/s | x1.05 |
| official mt, 64 KiB | 1.200 | 16.7 GB/s | x1.56 |

Official mt keeps a 1 KiB message on the calling thread, so each of its
20 programs takes one core and the OS serves them evenly; servil mt's 20
pools of 20 workers share the machine unevenly. A trial with 4 programs
read 38.9 GB/s at 64 KiB (the many-programs probe: 38.4).

**Posted.** bench-hashes #116 (with the PR #115 note).
