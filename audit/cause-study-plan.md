# Find a controllable cause within two hours

The user requests a concrete cause or an explicit bounded stopping result.
Study starts October 2, 2026 at16:35UTC and stops by18:35UTC. A finding needs
both an observed mechanism and a controlled intervention that predictably
changes the corresponding cost/variation. The report records elapsed effort,
ruled-out explanations, scope and residual uncertainty. Publication/PR work
precedes this clock; further statistical tuning stays outside this study.

## Stage1: retained-record and source audit (first30minutes)

Targets: queued64 B and lent multithreaded1MiB, solo/shared, plus corresponding
SHA controls. Read complete raw records through the existing strict Rust reader
and shared mean helper. Report each run's full mean, first visit's cost/share,
remaining visits' mean, first/last quarter means and largest observation's time
share. These chronological cuts are diagnostics fixed here before analysis;
they establish observations, rather than defining a performance-state classifier.
Include all64quiet-null processes. Later analyze two other retained contexts
if needed; counts/flags stay explicit. Python supplies paths/process plumbing.

Source lead: normal benchmark calibration runs on the calling thread only;
the shared Duo copy threads first encounter their own thread-local producers/
queues during sampling. The supplemental batch command already performs an
untimed Duo warm call during calibration. Check actual allocation/first-touch
paths before adding telemetry. Means include those costs and may reveal a
first-use violation of the declared warmed producer workload.

## Stage2: one justified intervention (next60minutes)

If first-use costs explain a material part of the target intervals, compare
an unmodified artifact with a one-mechanism producer-priming candidate:
exercise the existing Duo call outside sampling during calibration. Preserve
calls, inputs, sample counts and work. Inspect whether solo costs change through
placement/context despite priming shared producers. Source change affects the
instrument and is explicitly measured as an instrument experiment; historical
records remain unchanged. Hashing stays1e50159/0cdbb94.

Use8fresh alternating old/new/new/old processes per context, default and
P-only0–15, at the same full14points/24rounds. Both blocks/control stages use
shared Rust means and raw counter traces. Bound each process120s and campaign
1800s. Preserve every outcome and busy qualification; zero favorable retries.
Add an allocation/first-touch deterministic fixture if the source mechanism
calls for one. Retain exact patches/binaries and any failed result.

If chronology gives weak support, instead test placement with the unchanged
artifact: default versus fixed separateP cores, caller/worker thread budget
explicitly fixed in a source-separated diagnostic. A simple producer/handler
reuses the APIs and fixed published/reference anchors. Optional external
/proc task counters record scheduled CPU time, ready-to-run time, context
switches and major/minor faults; observer effects receive traced/untraced
controls. Timing stays in shared clocks; external metadata describes execution
conditions and supplies no independent speed implementation. Counter access
failures count as capability findings. Select this alternate before collection
and name its exact contract/limits in a follow-up plan.

## Stage3: independently check the result (remaining30minutes)

Verify work accounting and a fresh confirming block for a supported candidate
within the time limit. Report each affected API/scenario and adverse cells.
A successful first-use finding explains its observed scope; worker scheduling,
placement, sustained drift and other open cells keep their status. A reduced
interval alone is evidence of the intervention's effect, while precise causal
attribution requires the code/counter/allocation mechanism to match it.

At18:35UTC stop experiments and publish either a scoped controllable cause
with reproducible evidence, or the explicit result that this expenditure
established no controllable cause. Do not extend by adding knobs or changing
acceptance thresholds. The original broad reliability assessment remains open.
