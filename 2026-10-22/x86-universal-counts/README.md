# x86 hash_many: arbitrary input counts — matrix in progress

## Question and progress

Does each SSE4.1, AVX2 and AVX-512 hash_many implementation obey its caller
contract for every valid input count, through induction over full-width
passes and every remainder path?

**64 of 102 declared cases prove** at source
`14a716f35cbdf430fa845cc3dd9f5ee2c7b676cb`, branch
[candidate/devon-x86-counts](https://github.com/devonjonte/BLAKE3/tree/candidate/devon-x86-counts).
Fixed-counter blocks 1–10 are complete on all three ISAs and both ABIs;
block 11 SSE4.1/AVX2 also passed. The full matrix remains open. Each case
is universal over input counts; the number 102 enumerates the workload
shapes and conventions.

The complete matrix is fixed counters at blocks 1–16, plus incrementing
counters at 16 blocks, each ISA and Unix/Windows convention. These are the
caller's fixed-counter message/parent shapes and incrementing chunk shape.
The conservative address contract bounds count at `(2^64 - 1) / 32`, so
its output and pointer table fit a 64-bit region. Every remainder, including
zero inputs, is covered. Each read-only input has a separate region of
exactly its declared byte length and independent 32-bit array words.
Outputs, exact write ranges and calling convention are checked against
the shared compression specification. Rust dispatch stays outside this proof.

## Source and method

`prove_x86_loop.py` uses the existing executor, normalizer, generalized
state and worker harness. It states counter-derived state at `counter+W*K`,
including carries, and proves the successor domain and unsigned-rank progress.
Incoming masks are arbitrary. Windows cases assemble the actual MSVC source
with llvm-ml and link COFF with lld; Unix cases assemble the Linux source.

Each batch uses two fresh workers, each under a 6 GiB virtual-memory cap.
Light batches have 850-second complete-process-group deadlines. Larger
AVX-512 batches use 1800 seconds, based on the whole-chunk pilot's cost.
Completed stdout/stderr/supervisor logs and `progress.txt` preserve exact
case identities. Every completed batch here exited0. Periodic 120-second
faulthandler stacks describe a live proof's progress, separately from its
supervisor deadline and final result.

Earlier pilots and six wrong-kernel controls are preserved separately in
[the induction-domain record](../induction-domain/). This matrix reruns the
final source after helper and mask updates. [Progress discussion](https://github.com/johnservil/BLAKE3/pull/114#issuecomment-6341317459).

## Reproduce a bounded case

From the named source checkout, with CPython's Z3 package available:

```sh
EVIDENCE=/absolute/path/to/this/folder
ulimit -v 6291456
python3 "$EVIDENCE/run-bounded.py" 850 "$EVIDENCE/repro-avx2-one" \
  python3 -u "$EVIDENCE/run-count-proofs.py" "[('avx2', False, 1, False)]"
```

The driver accepts an explicit list of `(ISA, Windows, blocks, increment)`
tuples. `progress.txt` lists the remaining cases. No binaries or hardware
speed conclusions accompany these modeled-execution proofs.
