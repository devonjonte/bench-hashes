# Lane rounding rebased onto servil tip, gated on the i7-12700K (November 6, 2026)

`candidate/devon-round-up-lanes` (7 commits) rebased onto servil 8d6525c3 with no
conflicts. Suites: 182 pass. A change's mutation check: 44 mutants, no new survivor,
89 s. The speed gate (`check --points "1536 B,2 KiB,2304 B,3 KiB,3839 B,4 KiB,8 KiB,
16 KiB,idle 3 KiB,idle 3839 B,brief idle 3 KiB,brief idle 3839 B,lent 64 B,turn 256,
interleaved 256"`, 4 pairs then 64 on the suspects): **no cell slower**; judged faster
at one-message 3 KiB (x0.86-0.87, 7 of 7 pairs), brief-idle 3 KiB x0.72, idle 3 KiB
x0.76-0.78. 1536 B and 2304 B read x1.02-1.06, level by the judge.
