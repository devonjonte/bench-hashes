# hash_with into a kept heap slot, offset check on the i7-12700K

**Question:** does `hash_with(mode, input, &mut out)`, the kernel writing
the digest into a place the program keeps (a heap slot, the thread's for
its life), close or shrink the stack-offset windows of servil st's
shared 64 B cells, against #141's head alone (`2026-10-24/d3e3cbe-offset-i7`)?

**Commits:** devonjonte/BLAKE3 `exp/hash-with-out` f503409 (d3e3cbe +
the out-pointer chain); its bench devonjonte/bench-hashes
`exp/hash-with-out` 6859eafa (servil st's continuous, collection and lent
cells call `hash_with` into the thread-local `KEPT_DIGEST`; the per-message
calloc Sam Shackleton found is gone). That bench descends from the fork's
main; d3e3cbe's runs used John's main 3187e795: they differ in page and
tool code, not in cells.

**Commands:** as d3e3cbe's (offset_check.py from the fork's root, E from
`build-against ..` or built with `--features diag-align64`, each with the
patch to the checkout), under run-bounded.py (3600 s); load 0.5-1.6.

**Verdicts** (8-pair confirmations):

| run | servil st cells judged offset-sensitive | d3e3cbe alone |
|---|---|---|
| buffers as placed | shared ContinuousMessages 64 B +3.8% (+1792 against +1648) | lent 64 B +3.4%, continuous 64 B +4.0% |
| diag-align64 | shared LentMessages 64 B +5.1% (+3728 against +608) | none |
| diag-align64, again | shared LentMessages 64 B +4.8% (+3760 against +2336) | none (again) |

**Reading, this machine only:** writing the digest into a kept heap slot
removes no window, and with aligned buffers it shows one that d3e3cbe
alone does not, twice, at neighbouring offsets (one window). Its cause is
not measured: a guess is the slot's stores 4K-aliasing a later load. On
the i7 the change has no speed gain to claim.
