# Profile of the ring fix's stream cost (BLAKE3 #306), i7-12700K

**Builds.** `bench-hashes build-against` (bench 49f45960) for BLAKE3-Servil d60b6053 (`next` before the ring integration) and 0df4fa7e (the frozen ring integration), plus probes from the diffs here: `stride.diff` (d60b6053 with the slot one word longer), `sep.diff` (0df4fa7e with `next` in an array of its own), `inl.diff` (0df4fa7e with push, push_waiting and take_claimed inlined); `nohb` is my fork's exp/devon-ring-stream-no-handback.

**Findings** (servil mt, continuous 64 B):
- `perf annotate`: in both builds about 92% of the stream's publish time sits at the instruction after its SeqCst fence, the drain of the 1,656-byte task's stores (a Task is 1,656 bytes; its write and its read each copy it whole).
- `perf c2c`: modified-line hits (Load Local HITM) 530 before, 492 after, in samples of the same size: no rise in cache-line contention.
- `quick-ab.txt`: one build a variant, five alternating runs, so link layout is held fixed and the figures carry its effect: base 0.276 ns/B, ring 0.297; slot size alone 0.287 (bimodal); `next` in a separate array 0.304. In an earlier set of four, inlining (0.300) and skipping the stream's hand-back (0.2945, 0.2995 inlined) recovered nothing clear.

**Verdict.** The cost is reproducible (about +8% at 64 B) but not located: no added contention, no inlining effect, and the size-alone probe sits within layout noise. Posted on BLAKE3 #306.
