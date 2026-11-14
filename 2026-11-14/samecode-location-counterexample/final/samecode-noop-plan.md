# Does the corrected shortcut retain a useful early exit?

November14,10:00UTC. One workhorse build-only job, 30-minute bound; no timing.
Question: compare a real unchanged hashing-library pair, rather than only an
executable against itself, under both the old and corrected comparators.

Bench efe3dac3d74426053371be0c9bcf9c4dc1950ad9. Library:
f62bc6ac0bc1c86861659d61ffbf4e9546bc8aec ->
9c0ebbbce7cf0102c648b021b2395e7784b9a189.
The complete diff is AGENTS.md plus b3sum/src/linux_pipe.rs and b3sum/src/main.rs;
none is the hashing-library code the bench builds/calls.

Build both through the existing build-against path, at one library checkout and
one bench checkout, with fixed flags/toolchain. Retain exact provenance and both
binary digests. Invoke only provenance and the standalone samecode readers;
never check/regress or a timing mode. Compare original60e0f720 with locations
on, and corrected efe3dac3, using the same declared commit masks as check.

Expected useful control: both readers say Same. A difference is recorded as
lost/conservative early-exit coverage or a build/provenance issue to understand;
it does not trigger measurements, source masking changes or another search for
a preferred pair. This is one scoped positive control, not a population accuracy
claim. The already-published changed-data controls retain their separate scope.

10:10 setup correction: the first job stopped immediately, before any build,
at its b3sum-tool precondition (exit127). Preserve that delivery. The v2 recipe
delivers its exact compared binaries to the coordinator, whose existing tools
compute/check both fingerprints. No new remote tool or fallback is introduced.
Its bound is20 minutes, keeping the original overall question budget. The library
pair, build context and comparison question stay fixed. Binaries remain local
validation artifacts, excluded from the published data branch.

10:17: v2 also stopped before building: the assumed workhorse base BLAKE3 checkout
was absent. Two failed environment assumptions call for one explicit setup:
v3 creates both isolated source checkouts from their public repositories. Its
15-minute bound keeps the original question budget. This is the final setup
attempt; preserve all three deliveries and stop if it cannot complete.
