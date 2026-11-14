# Short incremental-hasher lifetimes: coverage and controls

November 14, 2026. [Coverage tracker](https://github.com/servil-software-factory/bench-hashes/issues/209),
[candidate PR](https://github.com/servil-software-factory/bench-hashes/pull/214),
[library Hasher investigation](https://github.com/servil-software-factory/BLAKE3/issues/387).

## Question and source

Does a benchmark that times a fresh hasher expose short-message costs hidden
by long streams, while preserving the meaning of existing workloads?

- Candidate: `2c8676842feab053fa7855d4cb3393bdea26ed4a`.
- Baseline benchmark: `8d9eb92ada887ed57b4d2102d3f913344067f84a`.
- Library pin for instrument controls: `f62bc6ac0bc1c86861659d61ffbf4e9546bc8aec`.
- John's finalize comparison: `c5d8331c7c3c89ac4890693f0c096336291d2639`
  to `0932d4a610e2dcc96e16af424f8d75d12cd4b360`, with one benchmark.

The library diff removes a by-value `final_output` hop and inlines finalize
wrappers that finish through `&mut self`. This study changes no library code.
The six new points cover 64 B, 1 KiB and 4 KiB after other work and under
sustained synchronous calls. Each operation creates a hasher, updates once,
finalizes and consumes its digest. Input preparation matches the one-shot
baseline; Servil receives no expected message length. Existing streams and
new cells share one incremental API adapter.

## Correctness

190 release tests and formatting pass locally and on the workhorse. Nine
focused debug tests (incremental and receiving) pass on the workhorse.
Published `abc` vectors anchor outputs. Axis-size differential checks,
nonzero padding, lifecycle accounting and selector tests supplement them.
Emptying Servil st's updates fails three tests; discarding its results fails
four. Both controls were restored and the suite passes. Original logs stay
in `validation/`, including the first compile's missing enum-match arm.

A map rendered from an accepted native-Mac sample passes the browser check:
six charts, documentation links, toggles and touch. Desktop and phone views
were reviewed; the new row identifies a fresh hasher's complete lifetime.

## Scope and load

Three predeclared questions use four fresh-layout pairs per side, without
an adaptive second stage. `code/plan.md` and the delivered scripts give the
exact commands. The comparison output comes from the existing Rust reader;
all eight comparisons, including the follow-up below, reproduce the delivered
output byte for byte.

1. **Unchanged candidate code**, on six new points and six one-shot/lent
   baseline points.
2. **Baseline/candidate benchmark**, on seven common old points only,
   including stream/receive calls affected by factoring and Pipeline calls
   whose source is unchanged.
3. **John's finalize change**, on the same scope as question 1.

EPYC uses both Servil forms, solo gap cells and both shared mt placements:
36 cells for questions 1/3, 24 for question 2. All 24 runs report quiet load,
with at most 0.03 CPUs of other work. Wall time and process CPU time are
available; cycle, instruction and energy evidence are absent.

Mac jobs 3119–3121 run both Servil forms with OS-placed shared mt calls:
30 cells for questions 1/3, 19 for question 2. The same-code job retried two
busy pairs under the existing rule (peaks 1.88 and 1.50 CPUs). Their four
original files remain under `samples/retried/`. All 24 accepted Mac files
report quiet load, with a peak of 0.74 CPUs. The later two questions needed
no retries. This is the mixed-use Mini on mains, low-power mode off. Its
calling-thread cycle/instruction counts are available; worker cycles and
energy are unavailable. Different platforms' scopes and compilers remain
qualifications.

## The new cells expose the finalize improvement

Selected single-threaded solo ratios, after/before; lower is better. Every
entry below is marked faster by the rule, within this pilot's scope.

| size | EPYC after work | EPYC sustained | M6 after work | M6 sustained |
|---|---:|---:|---:|---:|
| 64 B | 0.758 | 0.717 | 0.815 | 0.599 |
| 1 KiB | 0.862 | 0.947 | 0.893 | 0.835 |
| 4 KiB | 0.861 | 0.904 | 0.916 | 0.889 |

Sustained process CPU-time ratios closely track these elapsed-time ratios.
The multithreaded form also improves substantially, including its shared
calls. M6's after-work mt 1 KiB point is 10.9% lower but level under the rule;
retain that distinction. One-shot baselines are all level, with some sizeable
cold point-estimate movement. These are finite-scope observations, not an
equivalence claim for every baseline or a general release acceptance.

Complete tables:
- [EPYC finalize](x86-epyc-9275f/pilot/kept-finalize/comparison.md).
- [M6 finalize](apple-m6/3121-probe-incremental-finalize.20261114T053427Z-mac-m6/samples/comparison.md).

## Instrument controls and the remaining decision

Both new-cell A/A comparisons label all cells level. Some cold point estimates
move several percent (EPYC one-shot 64 B about 11%). Four-pair level results
leave uncertainty; they do not establish small-effect sensitivity.

The common-cell harness comparisons also label all cells level. Solo readings
are generally close, and the directly refactored stream/receive paths show
no large slower reading. **EPYC shared Pipeline point estimates rise roughly
7–23%.** The Git collection under one cache is slower in all four pairs.
M6 shared readings are smaller and mixed. The short-cell A/A excludes the
Pipeline workload, so it cannot explain the EPYC finding.

The bounded follow-up repeated that exact context with candidate/candidate
and baseline/candidate pairs. Its predeclared question is in
`code/shared-followup-plan.md`; all 16 additional runs report quiet load.

| shared Pipeline workload | first A/B ratio | common-context A/A | repeated A/B |
|---|---:|---:|---:|
| one cache: 1 MiB messages | 1.182 | 1.167 | 0.947 |
| one cache: Git collection | 1.231 | 1.141 | 0.962 |
| one cache: receiving saturated | 1.159 | 1.057 | 0.960 |
| two caches: Git collection | 1.066 | 1.009 | 1.097 |

The large one-cache readings change direction on repetition, while unchanged
code also moves substantially. The two-cache Git estimates stay 6.6–9.7%
higher; that remains an unresolved reading. Every row is level under the
rule. The complete follow-up tables remain beside the original comparison.

A locked, non-timing inspection captured the existing first-pair executables'
provenance, symbol sizes and selected disassembly (`x86-epyc-9275f/callers/`).
The Pipeline timed callers for messages, collection and receiving retain
2169, 2299 and 2771 bytes respectively. Listed Pipeline helpers and the Duo
worker entry also retain their sizes. The inspected collection entry uses
the same stack layout and setup operations, with relocated addresses. This
is limited compiler evidence, not binary equivalence or a timing explanation.

Decision: the tested workload addition supplies useful missing coverage and
makes the real finalize change observable on both platforms. Land it with
these limits explicit. Keep shared-Pipeline precision in the
[context audit](https://github.com/servil-software-factory/bench-hashes/issues/210).
The evidence supports no blanket unchanged-speed claim. A library decision
that depends on a modest shared-Pipeline difference needs stronger controls;
this study changes neither the rule nor the Pipeline to seek a passing label.

## Display-only invocation failure

After its three successful comparisons, the EPYC job's display command used
`--all --points`, while this CLI requires explicit `--contenders` with points.
It stopped before measuring, exit 134. The original script and error remain
in `x86-epyc-9275f/pilot/`. A separate bounded display job uses the explicit
eight Linux contenders, with identical source pins. That corrected job
completed successfully and reports quiet load (zero other CPU load in its
recorded windows). Its samples, report and map are under
`x86-epyc-9275f/snapshot/`. No comparison was rerun to repair this invocation.
The Mac sample already supports browser review.

## Reproduction

`code/archive.py` copies local completed bundles, retains retries and invokes
`bench-hashes compare` on accepted old/new files in run-number order. It
checks plain-text replay against the original report, then writes the
Markdown tables. It implements no measurement or statistical rule.

Sample files stay unchanged. SHA-256 and BLAKE3 manifests cover every file
other than the manifests themselves. Original scopes, failures, code pins,
commands and qualifications stay beside the results.
