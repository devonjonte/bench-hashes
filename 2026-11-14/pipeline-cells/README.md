# Pipeline benchmark integration: correctness and scoped pilot

November 14, 2026. [Candidate PR](https://github.com/servil-software-factory/bench-hashes/pull/213),
[workload tracker](https://github.com/servil-software-factory/bench-hashes/issues/169).

Question: how does BLAKE3-Servil's Pipeline serve the existing owned-message,
batch, collection and receiving workloads, beside synchronous calls using
the same library?

## Source

- Pin-only synchronous baseline: `d1c20fdfcf75918e5a144f235a27484a3de1dc32`.
- Pipeline adapter: `4b90fe8502c52de09d70efb23db056862820a8d9`.
- Candidate including the CI package-index repair:
  `55436819e59a20eaa47a79f81e6594872ea40ff4`.
- Library throughout: `f62bc6ac0bc1c86861659d61ffbf4e9546bc8aec`.
- Experimental extra-work control: `7090f6b14bd70471b2236620b856556c61ac4477`.
  This branch adds one serial hash per sixteen room-fed messages while
  preserving useful output. It is never a production candidate.

## Contract and correctness

Pipeline rooms receive continuous messages and collection items directly.
Batches own their input and digest storage, returned together after hashing.
Receiving accumulates the original scheduled fragments directly into rooms,
committing full rooms until the final partial room. All results are consumed
before the sample ends. Construction occurs in calibration; each producer
keeps its state. Existing synchronous lent-buffer cells remain baselines.
Separate asynchronous `owned`/`lent` workloads are outside this first scope.

The candidate passed 185 release nextest tests, with 16 machine tests
excluded, and formatting. Five new tests cover fixed vectors, room boundaries,
fragment waits and completion, returned batch storage, and independent
concurrent producers. The release suite passes again after restoration of
the deliberate input-corruption control.

The control replaced the room producer's `copy_from_slice(piece)` with
`fill(0)`. Three tests failed: fixed vectors, room boundaries, and concurrent
producers. The last aborted during unwinding because its Pipeline still
held worker tasks, consistent with the library's fail-stop contract. Original
logs retain that outcome. No control remains in the candidate.

Initial compilation found a wrong test argument type (`Some(2)` instead of
`NonZeroUsize::new(2)`), corrected before the passing runs. Debug compilation
later reached the local supervisor's memory floor and stopped, exit 137.
The release suite in that same job had already passed. The bounded workhorse
job completed at 01:07 UTC: all five new tests pass with debug assertions
active (serial compilation, debug symbols disabled), and all 185 release
tests and formatting pass. `workhorse/` holds the original commands and logs.
Local tests are correctness checks on the interactive i7; no performance
timing ran there.

## EPYC pilot results

Both measurement jobs completed under the host lock on EPYC 9275F:

1. `pipeline-pilot-55436819`: candidate/candidate and synchronous/Pipeline,
   four fresh-layout pairs per question.
2. `pipeline-added-work-7090f6b1`: candidate/extra-work control, four pairs,
   after testing that the control preserves the outputs.

All 24 measured runs report quiet load; the busiest recorded window was
0.04 CPUs of other work. Wall and whole-process CPU time are available.
Cycle, instruction and energy counts are absent. Each comparison takes four
fresh-layout pairs, without an adaptive second stage. `code/archive-results.py`
replays all three comparisons through the candidate's Rust reader; each
plain-text result reproduces the delivered comparison byte for byte.

### Scope correction, November 14

The original plan called this solo-only. The command actually measured
**19 named points in each of three scenarios**: solo, two callers under one
cache, and two callers under different caches. All three questions used
that same actual scope: 57 cells per run. The original plans remain intact,
with this correction beside them. CPU pinning in `regress` applies to calls
after gaps; these continuous solo samples were OS-placed. The shared copies
used the placements recorded in each samples header.

### Pipeline versus synchronous calls, same library

Selected solo readings from the [complete Rust table](x86-epyc-9275f/pipeline-pilot-55436819/kept-api-change/comparison.md):

| workload | elapsed-time ratio | rule's verdict | process CPU-time ratio |
|---|---:|---|---:|
| message 64 B | 1.458 | level | 2.912 |
| message 4 KiB | 0.411 | faster | 1.643 |
| message 64 KiB | 1.592 | slower | 3.153 |
| message 1 MiB | 1.321 | slower | 2.668 |
| batch of 16 messages | 1.839 | slower | 4.344 |
| batch of 256 messages | 1.635 | slower | 3.425 |
| batch of 4096 messages | 1.213 | slower | 3.590 |
| collection: Git objects | 0.890 | level | 2.166 |
| collection: Nix files | 0.799 | faster | 1.597 |
| receiving: saturated | 0.692 | faster | 1.379 |
| receiving: 2 μs arrivals | 0.659 | faster | 1.248 |
| receiving: 20 μs arrivals | 1.000 | level | 1.483 |

Ratios are Pipeline/synchronous, lower better. These compare caller/API
choices in one library version, rather than a library-version regression.
Even the faster cases use more process CPU time. The unchanged lent-call
wall ratios are close to one. Their CPU cost can still move: lent 1 MiB
reads 1.406 times as much process CPU time with the Pipeline-capable bench.
Kept Pipelines change the process environment beyond their own cells.

Shared results show the same main trade-offs: batches slower in both
placements, 4 KiB messages and receiving faster. Large-message shared
readings vary more. Keep their complete tables and pair spreads in view.

### Controls and limits

The [unchanged-code comparison](x86-epyc-9275f/pipeline-pilot-55436819/kept-samecode/comparison.md)
labels all 57 cells level. Some shared point estimates move by over 10%,
so this is limited evidence of precision, especially for small effects.

The [extra-work control](x86-epyc-9275f/pipeline-added-work-7090f6b1/kept/comparison.md)
raises each solo message cell's time in all four pairs. Geometric-mean
increases are 9.5–18.5%, yet all four solo cells remain level under the
57-cell rule. Only shared-one-cache 4 KiB passes the slower threshold,
at +21.2%. This demonstrates weak four-pair sensitivity even at some
meaningful observed costs. Level provides no assurance of equivalence.
The plant's five output/delivery tests pass before it measures.

The large API differences merit investigation. Claims about small changes,
universal Pipeline speed or release acceptance need further evidence.
No comparison rule changes follow from this pilot.

## Caller review and next action

`CALLER-REVIEW.md` records the source review. The adapter uses owned batch
storage, performs one producer copy, consumes every digest and recycles
returned storage. Sample sizes cover several rounds of the bounded input
buffers. The review found no demonstrated adapter defect that explains the
large costs. Worker handoffs, room processing and retained Pipeline sources
remain concrete library/caller interactions to investigate, with their
causes still open.

Devon owns the benchmark and its follow-up controls. John reviews the
library costs in [the caller-cost issue](https://github.com/servil-software-factory/BLAKE3/issues/389)
and chooses a library change. The adapter has landed on `next`;
its benchmark records these costs while library optimization proceeds.

## Native Apple M6 pilot

Mac jobs 3117/3118 completed on the mixed-use Mini at 02:27 and 02:32 UTC,
on mains power with low-power mode off. Both use the same 19 points and
four layouts, with Servil st and mt, plus OS-placed shared mt calls. This
is 57 cells including the single-threaded form, unlike the EPYC's 57 cells
from mt under three placements. `code/mac-plan.md` preserves the declaration.

The A/A job encountered one busy pair (peak 2.90 CPUs); the existing check
retried that pair once. The original two files remain under `samples/retried/`.
All eight accepted A/A files report quiet load (peak 0.98 CPUs). The API
comparison's eight files report quiet load without retries (peak 0.63 CPUs).
No new job was submitted to seek a quiet verdict. This remains a scoped
workstation pilot. The records carry calling-thread cycle/instruction counts
and whole-process CPU time; energy and worker-cycle counts are unavailable.

Both [A/A](apple-m6/3117-probe-pipeline-samecode.20261114T022214Z-mac-m6/samples/comparison.md)
and [API comparison](apple-m6/3118-probe-pipeline-calls.20261114T022743Z-mac-m6/samples/comparison.md)
reproduce the delivered Rust output byte for byte. A/A labels every cell
level, with some sizeable point-estimate movement (shared collections up to
19%). The unchanged st cells in the API comparison are all level.

Selected solo mt results, Pipeline/synchronous, lower better:

| workload | elapsed-time ratio | rule's verdict | process CPU-time ratio |
|---|---:|---|---:|
| message 64 B | 0.466 | faster | 3.024 |
| message 4 KiB | 0.230 | faster | 2.169 |
| message 64 KiB | 0.259 | faster | 2.348 |
| message 1 MiB | 0.274 | faster | 2.213 |
| batch of 16 messages | 0.288 | faster | 1.730 |
| batch of 256 messages | 0.308 | faster | 2.164 |
| batch of 4096 messages | 0.400 | faster | 2.591 |
| collection: Git objects | 0.205 | faster | 2.044 |
| collection: Nix files | 0.227 | faster | 1.695 |
| receiving: saturated | 0.160 | faster | 1.736 |
| receiving: 2 μs arrivals | 0.355 | faster | 1.500 |
| receiving: 20 μs arrivals | 1.000 | level | 0.834 |

Shared mt results also improve substantially in these owned workloads,
except the arrival-limited 20 μs case, which stays level. These observations
support a large caller benefit on this Mac and preserve the opposing EPYC
costs. They establish no universal Pipeline advantage or energy improvement.
The unchanged lent 1 MiB solo cell reads 8.7% faster with 12.8% greater CPU
time. Keep that finding beside the explicitly changed calls; its cause
remains open.

## Promotion decision

Correctness/liveness checks, the caller review and both platform pilots
support landing the benchmark adapter. The change exposes the intended API
and its costs. Library speed acceptance is a separate decision, and the
large EPYC losses remain open with John. The integration adds no statistical
rule, accepted-regression list or adaptive verdict override.

Candidate `4a3d25a768be1215546aaaad94ee5e2454026550` merges the already-landed
workload-context documentation into the measured candidate. Only
CONTRIBUTING and METHODOLOGY changed in that merge; the measured calls and
comparison code are identical to `55436819e`.

All six final CI checks passed. The adapter landed on `next` as
[`8d9eb92ada887ed57b4d2102d3f913344067f84a`](https://github.com/servil-software-factory/bench-hashes/commit/8d9eb92ada887ed57b4d2102d3f913344067f84a).
The merge request returned HTTP 502 after updating the branch; the PR's
state remained open. Devon verified the landed commit and exact tree, then
closed the PR manually with that explanation. Integration tracker #169 is
closed; library costs remain tracked separately.

SHA-256 and BLAKE3 manifests cover the files other than the manifests themselves.
