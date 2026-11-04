# The instruction-pointed second stage catches #119 (i7-12700K, November 4, 2026)

Question: with the suspects named first by instructions moved beyond 0.5%
among the solo cells of single-threaded contenders (bench 002a7b77, the
rule Zooko agreed to on bench-hashes #127 as John wrote it, after
2026-11-04/judge2-i7 showed the pool's caller counts are no evidence),
does `check` catch the #119 plant?

Command: `bench-hashes check --fork /home/agent/BLAKE3-rel019 --against f108640d --keep known119`
(the cells the change reaches, 426 at 4 pairs; then 8 suspects on 64 fresh pairs).

Verdict: **REGRESSION, exit 1.** The first stage found no cell slower by
wall; 11 st solo cells' instructions moved (3839 B +1.2% in all three
after-gap columns, 7935 B +2.6%, the 128 B stream and lent cells +2.2%,
the interleaved turns +3.1%), and the 8 largest went to the second
stage, where wall found two SLOWER on 64 pairs: IdleOneMessage 3839 B
+7.1% and OneMessage 7935 B +4.5%. Wall alone missed this plant in
every earlier check (2026-11-01/links-019-i7: 1 of 3; 2026-11-04/judge-i7:
0 slower).

Files: known119/ (sizes, the kept pairs of both stages, samples v10),
*.stdout.txt, *.stderr.txt.
