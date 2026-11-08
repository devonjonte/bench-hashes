# A stream's ring slot is free once its task is copied out (BLAKE3 #296), i7-12700K

**Question.** Sam's Ice Lake gate for BLAKE3 #296 failed the `throughput::pipeline` doc example ("a task claims one queued job"). Is the cause the ring's claim-then-read window in `Source::take`, and what does the fix cost?

**Commits.** BLAKE3-Servil `next` 7ee5c1f8 (old) and `candidate/devon-ring-copied` eb3e9ba2 (new); bench-hashes 3f999e83.

**Reproduction (no samples kept; commands in the PR).** The doc example looped 2,000 times a process passes on the i7 at `next`. With a 200,000-iteration spin inserted between `take`'s claim and its read, `next` fails 5 of 5 processes (one with the Ice Lake message, receiver.rs:671); the fix with the same spin passes 5 of 5. The unit test `a_claimed_task_survives_until_its_claimer_copies_it` fails with the wait in `push` removed (it reads `Some(1)` for `Some(0)`).

**Speed.**
- `gate.stdout.txt`: `bench-hashes check --points "interleaved 256,turn 256,idle turn 256,brief idle turn 256,receive saturated,receive 2 us,receive 20 us,1 MiB" --when-quiet`, after `check-builds.sh` (every build passes): no cell slower, no instruction count moved beyond 0.5%.
- `pipe/`, `pipe-compare*.txt`: the `blake3-servil-pipeline` contender, which `check` leaves out, old and new alternating. Four pairs over three receive cells, all level; then twelve pairs of `receive saturated`, level (x1.009, 5 of 12 faster; CPU time x0.961). The runs were built with `bench-hashes build-against` from a checkout carrying an untracked probe example, hence the `dirty-` sigil; the library sources match the commits.

**Verdict.** The cause is confirmed and the fix costs nothing measurable here. Posted on BLAKE3 #296 and in the fix's PR.
