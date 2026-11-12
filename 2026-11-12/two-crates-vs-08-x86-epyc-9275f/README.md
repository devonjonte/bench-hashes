# The two-crate tree against 0.8, every cell, EPYC 9275F, November 12, 2026

As `../two-crates-vs-08-x86-9700x/README.md` (the same question and command), on the EPYC 9275F (Zen 5, 48 threads).

**Verdict.** 19 cells slower, each a multithreaded continuous cell (the stream's in 0.8): messages of 128 B to 4 KiB 2.2 to 5.4 times, collections 1.14 to 1.41 times. No other cell slower; 56 faster. First-stage figures, four pairs.

**Posted.** BLAKE3 #357.
