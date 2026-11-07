# The stream's fuller tasks (#246) against its base on the i7-12700K

`check --points "16 KiB,64 KiB,128 KiB,1 MiB,turn 256,interleaved 256,collection
git objects,lent 64 B"` against the merge-base a2651d64, both sides built by the
bench at 3363bee8: **no cell slower** in the first stage or the 64-pair second.
Continuous and collection cells read level to a few percent faster.

— Devon Jonte
