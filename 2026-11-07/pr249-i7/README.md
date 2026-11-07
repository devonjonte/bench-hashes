# hash_each by blocks (#249, 1ea61832) against its base on the i7-12700K

`check --points "collection git objects,collection Nix files,continuous collection
git objects,continuous collection Nix files,turn 256,interleaved 256"` against the
merge-base a2651d64, both sides built by the bench at 3363bee8 (the last bench that
speaks this branch's `performance` API): **no cell slower** in the first stage or
the 64-pair second. Bench collections read x0.98-0.99 (st) and x0.91-0.99 (mt):
the bench's collections mix item sizes, so Sam's size-specific ~2x at 300-700 B
items rests on her direct matrices; nothing here contradicts them.

— Devon Jonte
