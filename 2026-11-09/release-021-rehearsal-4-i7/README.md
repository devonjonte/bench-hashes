# bench-hashes 0.21 release rehearsal 4, i7-12700K

**Question.** Do 0.21's release runs still pass after the candidate gained the `blake3-servil version` line and μ for microseconds (bench-hashes devonjonte `candidate/devon-release-021` 0bb31ed5, pin dcc8ccff)?

**Command.** `rehearse-4.sh`: the full run, the b3sum run (LAYOUTS=4), the crowd run, on a quiet machine.

**Result.** Every run exits 0 (full 504 s, b3sum 563 s, crowd 25 s); load quiet (0.13 CPUs on average). The samples carry `blake3-servil version: 0.8.0+b3c5….dcc8ccff…` (a library from before BLAKE3 #328: its version, then its commit) and the receive cells as `2 μs` and `20 μs`.
