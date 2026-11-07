# Why the 64 B stream cells' instruction count moved (bench-hashes #144, November 7, 2026)

servil st's lent and continuous 64 B cells read 10.92-11.36 instructions a byte
for the same code. One executable, fixed sample sizes, CPU 2:

| points in the process | kept buffer's offset to 64 B | instructions a byte |
|---|---|---|
| continuous 64 B alone | 48 | 11.345 |
| with 64 B, lent 64 B, continuous 4 KiB | 16 | 11.361 |
| with lent 64 B | 16 | 11.361 |
| with continuous 1 MiB | 0 | 10.923 |

(`p-*`: the probe build printing the offset.) With the lead bytes written once
(bench-hashes candidate/devon-pad-once, 4db9d9c1), every configuration reads
10.954 (`f-*`). Code layout had no effect: the count was identical to three
decimals across every layout of a side in the full gate.

— Devon Jonte
