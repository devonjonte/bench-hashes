# Mean caller-cost pilot: implementation works; broad 3% clearance remains open

The new summary measures total timed nanoseconds divided by completed work.
Graphs, reports, guide, batch command, descriptive compare and the gate share
`clocks::comparison::Work`. The current viewer names its values `mean` and
requires `bench-hashes mean viewer v1`. Historical median viewers use their
original source; the new viewer has one declared contract.

The fixed gate estimates the mean of sixteen ABBA block ratios and a
model-based simultaneous uncertainty interval. Its independence/normal-ratio
assumptions and coverage are in [the committed plan](../../mean-regression-plan.md).
Solo tolerance is 3%; shared reporting tolerance is 10%.

## Outcomes: every declared attempt retained

| Check | Whole exit | What the cell evidence establishes |
|---|---:|---|
| First full identical-artifact null | 2 | Five processes observed busy load; browser verification overlapped early blocks. This attempted check stays retained as load-qualified evidence. |
| Second full identical-artifact null | 2 | All SHA-256 controls within tolerance; zero subject faster/slower calls; 15 solo subject intervals inconclusive. |
| Direct known-work null | 2 | SHA-256 64 B control interval spans −6.36% to +7.37%; 64/2048 B subject cells within tolerance, bulk inconclusive. |
| Six extra hashes per 100 logical requests | 1 | 64 B +6.03% [5.29, 6.77], 2048 B +6.18% [5.51, 6.85] detected; bulk +4.92% [1.21, 8.64] inconclusive. Controls within tolerance. |
| Twelve extra hashes per 100 | 1 | All three subject sizes detected; bulk +11.03% [6.42, 15.63]. Controls within tolerance. |
| Twice the hashing work | 2 | All subject estimates near +100%, with intervals above the regression tolerance; one SHA-256 control interval crosses its tolerance, so subject findings remain descriptive. |
| Short caller, eight batches | 2 | Unobserved load, expected qualification. |
| Busy caller, two CPU workers | 2 | Busy load, expected qualification. |

Each check completes its fixed 64-process budget: **512 process attempts**.
These are pilot attempts. The direct caller covers plain hashing at 64, 2048
and 102400 bytes; queued/multithreaded positive controls remain separate work.
The two production nulls have distinct prototype artifacts, while each check
uses exactly the same artifact on both sides. Every positive/control check
in the later sequence uses one unchanged artifact. Known work specifies
completed hashes; its wall-time effect is estimated from observations.

The quiet full null's wide intervals show why unconditional passing would
exceed this experiment's evidence: queued 64 B is +1.16% [−8.01, +10.33],
lent multithreaded 1 MiB +1.90% [−6.48, +10.28]. Means remove the clustering
cutoffs; process variation still affects useful resolution. A reliable,
useful full-scope 3% detector therefore remains a validation goal.

## Source and reproducibility

`raw-pilot.tar.gz` contains every original request, raw v4 sample file,
counter/accounting trace, process output/exit, block totals and decisions.
It also contains exact retained pilot benchmark source from the build side,
shared comparison source, the independently anchored caller source and lock,
and nine deterministic whole-gate fixtures. `receipt.json` records its SHA-256,
size, process counts and complete decision text. Extract into a new directory.

`pilot.json`, source manifests and patches name measured artifacts and source
identities. `frozen/` executables stay in the local validation archive; their
SHA-256 hashes are published. The current `mean` viewer is a later naming/
renderer cleanup, and its source identity describes that revision. It shares
the same caller-cost/interval arithmetic with the pilot. Raw pilot records and
prototype source retain their actual original identities and field names.

The primary pilot executable SHA-256 is
`2a334afb94ea0bac77e7bc32e0bce2d7af2d9bf952372cf04054ecd177e4451a`;
caller `ed93319764110d3442604f5f1f24963ac12638ab64621e96e07e26d71c8396b6`.
Hashing remains the Linux candidate at 1e50159; the new shared mean helper
adds statistical code and leaves hashing/timing functions unchanged.

Current source builds through a pinned public Devon fork dependency, so
standalone `cargo build --release --locked` works. A patched enclosing build
uses the fork's tool, which derives the patch URL from the selected benchmark's
manifest. Provenance verifies the declared URL and explicit revision. Original
upstream John URLs remain in historical records where they were actually emitted.

## Verification and bounds

- 29 benchmark Rust tests; 25 clocks tests, three ignored: pass.
- Nine independently fixed whole-gate fixtures: pass.
- Full/quick SVG zoom, units, direct selection and hover checks: pass.
- Real-browser input/selection/data-preservation and guide summary: pass.
- Current producer/viewer/tests name means consistently; strict format guards
  and a Rust assertion reject legacy summary fields.

Every live check has whole-process-group supervision; timeout/cancellation
reaches its children. The code and evidence are offered as an experimental
Linux contribution. Original reliance acceptance remains unpassed; native Mac,
ARM and automatic positive-control coverage for every production API remain
outside this pilot. Assess detection, abstention and runtime together before
adoption. The user's next bounded study targets a controllable cause for the
widest process variation, with a recorded stopping outcome.
