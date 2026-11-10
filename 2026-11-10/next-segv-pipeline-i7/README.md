# `next` segfaults in the pipeline's batch cells on the i7-12700K (BLAKE3 #302)

**How it was found.** A speed check of BLAKE3 #328 (the build version; unrelated code) against `next` 85263b32, with bench-hashes f43ff077. In the confirmation round its **old side, `next` itself, stopped with signal 11 (SIGSEGV)** in the pipeline's ContinuousBatches 16 cell, writing nothing (`check.stdout.txt`, lines 7 to 10: the stopped-side report, new in that bench commit; `kept/second/run-001-old.stderr.txt`).

**Reproduced under gdb** (`gdb/loop.sh`): the same executable, `next`'s build, run on `continuous batch 16` and `continuous batch 64` until it stopped. Run 105 of at most 20 minutes' worth: `Thread 5 "blake3-worker-2" received signal SIGSEGV` in `blake3_servil::stream::receiver::execute_batch`, called from `lanes::Task::run` in `Pool::serve` (`gdb/crash-105-backtrace.txt`; the other workers idle in `serve`, the shared scenario's second copy awaiting an admission).

**What it is.** The crash is in the batch job's own function, on a pool worker: a batch task run on a job that is no longer there. That is what BLAKE3 #302's race does on `next`, where a batch's job is a box its task frees: a worker held between its claim and its copy has its ring slot written over, runs another task's job, and that job is then freed twice. With BLAKE3 #329 underneath (the job kept in its message slot) the same event stopped at a check, "one task takes the published batch job" (`../../2026-11-09/task-places-i7`, step 4). The attribution to #302 is an inference from the place of the crash and that earlier stop; no instrumented run shows the lap itself.

**Rate here.** One stop in the confirmation round's first run; one in 105 runs under gdb.

**The repair.** BLAKE3 #331 (with #329). Its controls hold a claimer after its claim while the ring laps it.
