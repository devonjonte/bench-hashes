# One caller-cost mean, shared by plots and the gate

This review branch proposes total timed nanoseconds divided by completed work
as the primary summary. `clocks::comparison::Work` supplies the graph, text
report, API guide, descriptive comparison and regression block ratios. The
companion BLAKE3 helper branch adds that code beside existing clocks modules.
Current viewer fields are named `mean` and require the declared format
`bench-hashes mean viewer v1`. Historical records use their source-matched
viewers. The original workload calls, axes and scenarios stay unchanged.

## Why this quantity

A single mean accounts for every observed operation. Changing the share of
fast and slow timings changes caller cost continuously. The rule removes
cluster classification and its gap, minimum-share and speed-ratio cutoffs.
A single-run graph displays its observed mean and range. A regression check
estimates variation across repeated experimental blocks using the same raw
work calculation.

## Gate proposal and assumptions

The included experimental gate collects sixteen full old/new/new/old blocks,
retaining every process request, sample, trace and exit. Each block pools two
old runs and two new runs, then supplies one new/old time-per-work ratio.
The mean block ratio and a model-based Student-t interval decide slower,
faster, within tolerance, or inconclusive. The fixed budget replaces early
stopping and conditional confirmation. Solo tolerance remains3%, shared10%.

The interval assumes independent approximately normal block ratios, df15,
critical4.5, and at most84simultaneous cells. Bonferroni bounds family error
at about3.56% under that model. Model assumptions and useful detection need
fresh empirical validation. Interval arithmetic, including outward rounding,
is shared Rust integer code. SHA-256 control intervals must fit their bands;
busy/unobserved load and uncertain controls qualify the subject findings.

## Existing evidence and its scope

[Devon's complete Linux pilot](https://github.com/devonjonte/bench-hashes/tree/candidate/devon-mean-regression/audit/results/mean-regression)
retains512process attempts, source/artifact identities and raw records:

- Quiet full unchanged-code check: zero subject change calls,15solo cells
  inconclusive. All SHA-256 controls within tolerance.
- Six extra hashes per100logical requests:64/2048 B detected,bulk inconclusive.
- Twelve extra hashes per100:all three sizes detected.
- Twice the work:subject intervals establish the increases, while one
  uncertain SHA-256 control makes the whole check inconclusive.
- Short/busy callers:expected load qualification. A first production null
  with browser overlap is retained as busy evidence.

Those measurements used Devon's older, explicitly named Linux hashing source.
This focused port preserves current upstream hashing and API changes; its
source/fixture/build tests provide implementation evidence. Fresh performance
and reliability campaigns for the current upstream source remain necessary.
The original general-reliance acceptance remains open, including model scope,
near-margin detection and independent reproduction. Native Mac/ARM evidence
retains its own source identity.

## Adoption

The review branch pins the published companion helper commit in Cargo.toml
and Cargo.lock so standalone builds work. After an owner decision and helper
integration, pin the resulting upstream helper commit, update version/docs and
start fresh comparisons. The fork's build tool derives local patch URLs from
the benchmark manifest. Review may adopt the shared mean and then assess this
fixed-budget gate's runtime and inconclusive rate separately, keeping every
consumer's primary statistic coherent.
