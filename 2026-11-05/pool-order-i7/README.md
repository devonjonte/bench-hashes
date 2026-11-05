# Serving the pool's sources in turn costs the shared cells 6-16% (i7-12700K, November 5, 2026)

Question (BLAKE3 #240, #241): does a worker's walk of the sources beginning
after the slot it served last (fairness in the order of service) cost
anything against the walk from slot 0 every time (the lowest source whole)?

Command: `bench-hashes check --fork /home/agent/BLAKE3-m3 --against 06f6e26d`,
bench cc3fdb00, the fork at 807cca52 (the rotation, Sam's run_one_from seam
and the const assert); 426 cells at 4 pairs, then 8 suspects on 64 fresh pairs.
check-1-busy.*: the first attempt, no verdict (other programs busy: the user
at the machine); check.*: the verdict, the machine idle (0.13 CPUs busy).

Verdict: **REGRESSION, 6 cells slower**, all shared (two mt programs at once,
one cache): LentMessages 1 MiB +15.6% (every one of 64 pairs), 4 MiB +13.8%,
LentBatches 16384 +7.1%, MerkleTree 4096 +6.4%, 16384 +5.8%, 65536 +13.3%.
Solo cells level; instructions moved in the st 64 B stream and lent cells
(-3.6%, the layout effect seen before). Reading: with the lowest source
served whole, each call gets the whole pool and finishes soon, and its
caller submits the next; served in turn, each call waits for the other's
pieces before its last one finishes, so both callers submit fewer calls.

Consequence: #241 keeps the order as it was, states it and tests it;
the rotation is on `exp/devon-pool-rotation` in devonjonte/BLAKE3.
