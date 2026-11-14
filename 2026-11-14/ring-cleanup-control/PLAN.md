# First deterministic-failure diagnostic: Ring cleanup

Question: can an assertion about a broken Ring be hidden by unwinding through
that same Ring's Drop, which drains it by calling pop_front?

Inspect the exact Ring at BLAKE3-Servil ab256b0d9ebb44eececd71ce0ae37113e75634a5.
Use a tiny source-extracted test crate, no hashing and no library edits. The
single-slot ring contains a zero-sized token whose Drop yields: repeated token
reads have no uninitialized bytes or owned allocation, and cleanup has an observable
operation. Plant the listed pop_front mutation `len -= 1` → `len /= 1`.

Compare two otherwise equal tests: ordinary ownership versus ManuallyDrop around
the ring, with explicit normal-path cleanup after the count assertion. Both must
pass before the plant. Under the plant, determine whether the ordinary assertion
waits for nextest's existing mutants timeout while the protected assertion fails
at once. Restore the source and require both tests to pass again. Keep the existing
nextest profile and its15-second limit. Bound the whole diagnostic to120seconds.

This establishes a possible cleanup mechanism, not the outcome or latency of the
complete mutation check. If supported, propose a small test-only change and measure
its effect through the actual selected-test runner before changing any known list
or policy. Sam owns those decisions. Production code and global timeouts stay put.
