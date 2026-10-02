# SIMD for already-gathered queue messages

October 2, 2026, about 05:35 UTC, before source changes. Streaming callers
receive priority. Queue::messages already gathers up to64 short messages into
a task; only64-byte members currently use SIMD. Equal-length128/256/512/1024-
byte members still hash serially one message at a time.

Reuse the existing typed platform.hash_many root operation for equal-length
whole-block members on x86. Keep arbitrary/unequal lengths on the existing
scalar path,64-byte behavior unchanged in meaning, and all output ownership,
completion counters, handler order, queue concurrency and thread budgets
unchanged. Factor the existing64-byte mechanism rather than introduce another
one. The gathered task supplies independent messages at counter0 with
CHUNK_START|CHUNK_END|ROOT. No message data changes, no crypto weakening.

Baseline d0574e7 against the candidate, frozen expanded benchmark runtime6047dcd,
clocks2a2cb9c. Before commit: stock14-point diagnostic, fresh normal-benchmark
ABBA at continuous64 B/1 KiB/16 KiB/64 KiB/1 MiB and matching lent points,
24 rounds, default and P-only placement (8 processes). Compare each pair and
same-side repeats through Rust. A target gain requires10% in both corresponding
1 KiB queue fast ratios, with states/shares and repeat variation separately
reported. Other queued and lent cells stay visible; no favorable retries.

Independent reference tests must exercise gathered equal lengths and mixed
length fallback, all modes, output count/order and exact expected digests;
existing one-CPU, concurrency, no-allocation and resubmission tests stay active.
Run default,pure,no_sme2,official vectors,docs and ASan. Preserve every outcome.
ARM stays on the existing selection; its layout is untested by this Linux work.

The prior48 placement processes show large changes in same-code queue split
medians and shares even under restricted affinity. Those results do not close
queue/context costs or establish physical state matching. Provisional Linux
optimization continues under user authority; the original reliance procedure
remains unpassed. A useful code-path gain does not certify all queued states.
