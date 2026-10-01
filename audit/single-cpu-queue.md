## Reproduction

On x86_64 Linux (Intel i7-12700K, 20 logical CPUs, Rust 1.98.1), the queue burst regression at `3d02b0448b1eca55d53769a6d8ea640f96355deb` passes with normal affinity and hangs with affinity restricted to one available CPU. This source includes the `7270b21` lost-wakeup fix; its library code matches that commit.

```sh
git clone --branch candidate/api-plan-simple https://github.com/johnservil/BLAKE3.git
cd BLAKE3
git checkout 3d02b0448b1eca55d53769a6d8ea640f96355deb
cargo test --release --test api_plan --no-run
cargo test --release --test api_plan bursts_of_large_batches_after_pauses_complete -- --exact --nocapture
timeout -k 5s 10s taskset -c 0 cargo test --release --test api_plan bursts_of_large_batches_after_pauses_complete -- --exact --nocapture
```

Use a CPU allowed by the environment's affinity mask in place of 0 if needed. The restriction must apply before process startup, when the pool reads `available_parallelism()`.

I independently ran the **same built test executable** directly in both cases, without rebuilding:

- Normal affinity: 1 passed, 0 failed, completion about 0.15 seconds.
- `taskset -c 0`: prints `running 1 test`, remains blocked until the external 10-second supervisor terminates it (status 124).
- `a_handler_may_resubmit_its_buffer` also blocks under one-CPU affinity.
- One-shot published-vector/forms tests pass with one CPU.

The supervisor terminates the entire process group. Stack capture was unavailable: this environment denies gdb attach through ptrace. The reproduction was confirmed again after the initial audit.

## Likely executor-capacity hole

`Queue::new` (`src/queue.rs`) stores `efficiency.max_threads()` as its `max_threads`. `Efficiency::Time` permits more than one thread. The submission paths choose pool tasks from `inner.max_threads > 1`, independently of actual pool capacity.

`pool()` (`src/lanes.rs`) reads `available_parallelism()` and spawns workers with `for worker in 1..cpus`. With one available CPU that creates zero workers. On x86 there is also no SME2 executor. Tasks can therefore be queued with no executor; delivery waits for their completion.

A potential remedy is to select delivery-side serial hashing when the pool has no task executor, or provide an executor in that case. This is a source-based explanation to review, rather than a traced stack diagnosis.

This appears to be an additional capacity case, likely pre-existing. The normal multi-CPU lost-wakeup fix is a genuine improvement and remains adopted in my benchmark audit. No claim of introduction by `7270b21`, or of Mac/SME2 reproduction, is intended.

Public audit: https://github.com/devonjonte/bench-hashes/blob/candidate/devon-benchmark-audit/AUDIT.md
