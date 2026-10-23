# bench-hashes 0.17.0 (October 23, 2026): the i7's first runs

Release `v0.17.0+1b480eed20d11d7cd1417384e4a9d540b0e321be` on
devonjonte/bench-hashes main (`885ffa3c`), the decisions of Zooko's on
October 23: a cell's figure is its mean with every sample counted (the
trim of October 19 withdrawn: `clocks::summary::mean` on Devon's line,
`7f9f1f7`, whose test is the six-sample fixture), samples v7 so a file
says which rule it is read under, a 1536 B point in OneMessage and
IdleOneMessage (one chunk and a half), and the overview with plain names,
compared bars, drab SHA-1/MD5 and a phone's layout.

Here: the i7-12700K's full run (96 rounds, eight contenders, quiet, 0.28
CPUs busy) and b3sum run (official 1.8.2 beside the fork's b3sum at the
line's `082afa3`, four layouts each, 0.27 CPUs busy), as published, and
the commands' logs. The M4's, the VM's and the EPYC's rows on the overview
await runs under 0.17; their 0.16.1 maps stay linked.

A run at 14:50 UTC under the candidate was discarded: it ran beside a
six-shard mutation check (busy in 91 of 258 windows) and its map writer
stopped on a v6 b3sum file; both the mistake and the writer's fix are in
the history.
