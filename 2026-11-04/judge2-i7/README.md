# The instruction-pointed second stage, first run (i7-12700K, November 4, 2026)

Question: does `check`'s second stage, with suspects named first by a
level cell's instructions moved beyond 0.5% (bench b0d8510d, the rule as
Zooko agreed to it on bench-hashes #127), catch the #119 plant?

Command: `bench-hashes check --fork /home/agent/BLAKE3-rel019 --against f108640d --keep known119`
(the cells the change reaches, as a real check runs), and the A/A
(`--against b5b988d8`, the working tree's own commit: "nothing to measure").

Verdict: the rule as first written read every level cell, and 96 moved,
94 of them blake3-servil-mt's, whose caller spins while it waits (in a
3-pair A/A of the same code, 7 mt cells moved 1-9%). The 8 suspect slots
went to those, and the plant's own cells (3839 B +1.2% in all three
after-gap columns, 7935 B +2.6%, the 128 B stream and lent cells +2.2%)
stayed out; the second stage judged the mt cells level. So the rule
reads the solo cells of single-threaded contenders alone, the largest
move first (002a7b77), run again as 2026-11-04/judge3-i7.

Files: known119/ (sizes, the kept pairs of both stages, samples v10),
*.stdout.txt, *.stderr.txt.
