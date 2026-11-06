# Servil tip against the 0.8 release on the i7-12700K (November 6, 2026)

Question: where does servil tip (8d6525c3) stand against the 0.8 release
(b5b988d8) on the road to 0.9? Command (bench-hashes `next` 415e7df3, the
old side built by the bench at the #128 merge, 3363bee8, which speaks
0.8's API and writes samples v10):

    bench-hashes check --fork BLAKE3-m3 --new servil-tip --against b5b988d8 \
      --old-bench 3363bee8 --points "64 B,256 B,1 KiB,3 KiB,4 KiB,16 KiB,64 KiB,1 MiB,idle 64 B,idle 1 KiB,idle 3 KiB,lent 64 B,turn 256,interleaved 256"

Verdict: **no cell slower** in the first stage (4 pairs) or the second
(64 pairs on 5 suspects). Readings (4 pairs, all level): one-message
3 KiB and 4 KiB x0.95 on both contenders; the rest within a few percent
either way. The loosest cell, servil mt's 1 KiB call after a pause at
x1.175 on 1 of 4 pairs, went through the second stage and read level.
`tools/check-builds.sh` on the same commit: every build passes.

— Devon Jonte
