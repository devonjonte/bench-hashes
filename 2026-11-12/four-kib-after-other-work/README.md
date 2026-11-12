# convenience::hash of 4 KiB after other work on Zen 5 (BLAKE3 #376): what was found, November 12, 2026

**Question.** The 0.9 gates read this cell 5 to 6% slower than 0.8 on
three Zen 5 machines (64 pairs each). Why?

**Found, by counting under Intel's emulator on the i7** (`sde64 -icx -mix
-top_blocks 1000000` over a probe that calls `convenience::hash` 2,000
times; the code of the blocks run every call):

| a 4 KiB call | 0.8 | the 0.21 pin | next | the candidate |
|---|---|---|---|---|
| instructions | 7,521 | 7,550 | 7,619 | 7,562 |
| cache lines of code run | 103 | 115 | 120 | 105 |
| of it, compress_chunks_parallel, bytes | 690 | 1,238 | 1,242 | 974 |
| compress_parents_parallel, bytes | 390 | 758 | 792 | 396 |

The growth is lane rounding (`hash_many_rounded`, BLAKE3 #248) inlined
into the two functions, on a count (4 chunks) that rounds nothing.

**The candidate** (devonjonte/BLAKE3 `candidate/devon-exact-lanes-direct`,
747770a4 on next 73ee859e) sends one or two inputs and a count that is a
kernel's width straight to the kernel, the rounding out of line.

**Measured** (`*/exact-lanes`: the candidate against next, one bench,
pinned, 16 pairs a machine; the pairs' geometric mean, new over old):

| | 3 KiB | 3839 B | 4 KiB | 4470 B | 8 KiB | 32 KiB |
|---|---|---|---|---|---|---|
| EPYC 9275F | +1.4% | +0.3% | -3.5% | -3.4% | -2.9% | -3.8% |
| Ryzen 9700X | +3.8% | +2.7% | +1.0% | -0.3% | -0.7% | -1.6% |
| EPYC 9255 | +1.4% | +2.0% | -0.7% | -0.9% | -2.6% | -3.2% |
| all 48 pairs, with the standard error | +2.2 ± 1.1 | +1.7 ± 1.0 | -1.1 ± 1.1 | -1.5 ± 1.0 | -2.1 ± 1.2 | -2.9 ± 1.0 |

**So:** the code a 4 KiB call runs did grow by a sixth, and putting it
back gives about 1 to 3% to the counts that are a width and costs the
counts that round about 2%. It does not account for 5 to 6%. The gate's
reading crosses two benches (0.8 under its own), and no library builds
under both, so the benches' own part in it is not separated.

Also here: the Xeon pairs' repeat of one gate cell (multithreaded 3 KiB
after a brief pause, +88% at four pairs): no repeat on either pair.
