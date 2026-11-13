# bench-hashes 0.22 at its tag on seven machines, November 13, 2026

**Question.** The release runs of bench-hashes
`0.22.0+d7723f110a6f519cccb2e4ab8f2a18be7a4f4d41` (tag commit `97c0fbcb`),
measuring BLAKE3-Servil `0.9.0+73ee859efce085d28f1c2b22c35a5703403476f7`
(commit `bf2da8b957f5e0c80babb57952de3e53f95c921a`).

**Command.** Each x86-64 folder's `run.sh`, under the machine's lock on the
six measurement hosts and from the queue on the i7: the full run, crowd,
b3sum, the release check of the single-threaded contender against 0.8
(every cell, `check-core.*`), and the same-library check of this bench
against 0.21's (library 2037118c on both sides, `check-same.*`). The Apple
M6 ran the full run, b3sum and crowd as Mac jobs 3111 to 3113, with no check.

| machine | full run's load | b3sum's load | core against 0.8 | this bench against 0.21's |
|---|---|---|---|---|
| EPYC 9275F | quiet | quiet | no cell slower | no cell slower |
| Ryzen 9700X | quiet | quiet | 3 slower: one message 4 KiB +7.3%, 16 KiB +3.2%, four long messages +4.3% | no cell slower |
| EPYC 9255 | quiet | quiet | 5 slower: one message 2304 B to 64 KiB, +3.1% to +6.3% | no cell slower |
| EPYC 7443 pair (`x86-avx2`) | quiet | busy in 2 of 1095 windows | 1 slower: a turn of 256 messages +14.9% (4 pairs) | 1 slower: one message 256 B +11.0% (64 pairs, from -27.9% to +84.3%) |
| Xeon 6330 pair (`x86-icelake`) | quiet | busy in 3 of 1121 windows | 1 slower: six messages +4.2% (4 pairs) | no cell slower |
| i7-12700K | quiet | quiet | 1 slower: 16 KiB after a brief pause +10.8% (4 pairs) | no cell slower |
| Apple M6 | busy in 2 of 393 windows | busy in 8 of 454 windows | not run | not run |

**Reading.** The Zen 5 cells of one message at 4 KiB belong to the cost
already recorded for 0.9 (BLAKE3 #376). The others are reported on
bench-hashes #205 for John's judgment; none was looked at again by name
here. The five rented x86-64 hosts counted no instructions (asked for in ops),
so their verdicts are wall time's alone; the i7 counted them. The M6's home prefix reads
`<runner-home>`; every measured value is as recorded.

**Published.** bench-hashes `next` df96f117 (`benchmark-results/`, the
overview), pull request #207; tracker #205.
