# How this experimental benchmark measures

This source-separated Linux candidate summarizes caller cost with **total
measured nanoseconds divided by completed work**. Graphs, reports, the API
guide, comparisons and the regression detector share that calculation
in `clocks::comparison::Work`. Its reliability pilots are underway; the
[experiment plan](MEAN-VALIDATION-PLAN.md) defines their scope; the
[review proposal](MEAN-PROPOSAL.md) separates the original pilot from this
current-upstream port.

## What a measurement includes

The benchmark calls each implementation through its own APIs and observes
results so the compiler retains the hashing work. Each implementation's tests
establish digest correctness. Inputs use reproducible bytes and each shared
copy receives its own buffer.

The original workload contract lives in [FROZEN.md](FROZEN.md). It covers:

- **After other work:** the program hashes, runs a fixed other program and
  reads128MiB of memory for at least1ms, prepares the input, then times the
  next hash call. Preparation has its own timing and remains outside the
  hashing measurement.
- **After idling:** the same sequence with a1ms sleep in place of other work.
- **Nonstop, hand over buffers:** inputs pass through owned buffers, with
  producer, submission and result handling inside the measured workload.
  Servil uses its queue; synchronous contenders use their own entry points
  through the same producer. Approximately1MiB or1024buffers stay in flight,
  whichever is fewer, and their return channels/queues persist across samples.
- **Nonstop, wait for each call:** inputs are read into kept buffers, lent
  through synchronous APIs, then reused after each call returns. Reads and
  hashing take turns. Batches keep their output storage.
- **Pieces:** a64MiB message arrives through64KiB incremental updates.

Nonstop workloads run alone and with two simultaneous copies. Each copy's
time and completed work contribute to the shared caller-cost estimate. The
samples within that paired interval share execution conditions; regression
uncertainty treats an entire repeated experimental block as one observation.

## Timing and sampling

Shared `clocks` code owns clock reads, calibrated timing, load observations
and cycle counts. Small calls run in calibrated batches; raw records retain
the elapsed integer nanoseconds and the integer bytes/messages covered.
Wall times stay unscaled. Available per-thread counters supply separate
cycles/instructions per core kind. Available counts cover the calling thread; helper-thread work and energy
need additional observations. This upstream port's Linux backend supplies
no per-thread cycle evidence. The original Devon Linux pilot used its own
explicitly named PMU backend; those source identities retain their scope.

Contenders participate in a balanced order design for each use case. Points
rotate across rounds. Producers and result storage persist across samples,
and calibration initializes the implementation outside measured samples.
Both synchronous calls and queue handling include the work specified by their
workload. The frozen contract test checks calls, axes and scenarios against
FROZEN.md.

The shared load observer records other programs' activity in time windows.
A busy or unobserved run supplies descriptive measurements; the regression
detector reports it as inconclusive. The present record format establishes
the observer's available window evidence. Whole-interval load coverage and
physical performance-state identity require their own validation.

## One caller-cost summary

For samples with times `t` and completed units `w`, the point estimate is:

    mean caller time per unit = sum(t) / sum(w)

Every completed unit contributes. A change in the share of slow observations
changes the estimate according to its effect on callers. Variable sample
work receives its corresponding weight. Arithmetic means of normalized sample
rates coincide with this quantity when samples have equal work.

The calculation retains integer totals and rounds at display. Graph axes
convert to floating point only for coordinates. Throughput is the reciprocal
of this mean time. Tooltips include the observed timing range and sample
count. Each dot summarizes its run; its range describes observations within
that run. The regression interval describes variation across fresh run
blocks. Timing distributions and chronology remain in the raw sample file.

**Choose plots** opens a table with one checkbox per measured plot. Each
checkbox acts independently. Clear starts a fresh selection; Show all restores
every plot. Shape marks name the kernel used, contender names toggle their
lines, and the input strip narrows the horizontal range.

## Automatic regression decisions

`bench-hashes regress OLD NEW` collects sixteen **old/new/new/old** blocks.
Every process uses the same fourteen nonstop points,24rounds and contender
roster, preserving each point's workload context. The fixed budget replaces
early stopping and conditional confirmation. It retains all requests, raw
samples, counter traces and console output in `regression-results/`.

For each cell, a block pools the two old runs' raw time/work and the two new
runs' raw time/work, then calculates the new/old mean-time ratio. The detector
estimates the arithmetic mean of16block ratios, giving each block one vote.
Thus its uncertainty unit is the experimental block, with its process and
scheduling variation.

A Student-t interval with15degrees of freedom and critical value4.5 covers
that mean under independent, approximately normal block ratios. A Bonferroni
bound across at most84two-sided intervals gives a model-based family error
bound of approximately3.56%. Cross-cell dependence is allowed by that bound;
block independence and the ratio model remain substantive assumptions.
Fresh controls must establish the method's empirical scope on this host.
The shared Rust implementation uses exact integer sums/squares and an outward-
rounded integer square root. Each printed interval states this model scope.

Solo tolerance is3%; shared reporting tolerance is10%. A whole interval above
the upper tolerance reports slower; one below the lower tolerance reports
faster; one inside the band reports within tolerance. Other intervals report
inconclusive. SHA-256 control intervals must fit their tolerance bands before
subject decisions supply evidence.

- **Exit1:** a solo subject's interval establishes a regression.
- **Exit0:** every measured solo subject is within tolerance or faster, with
  controls within tolerance. Shared outcomes remain printed.
- **Exit2:** busy/unobserved load, inconclusive controls, or inconclusive solo
  subjects. Retained subject estimates still describe the observations.

`regress --records MANIFEST.tsv` replays64recorded paths in declared ABBA
order through the same reader and rule. `compare OLD.tsv... -- NEW.tsv...`
prints descriptive pooled caller-cost means using that same work calculation.
Its sample files preserve source-matched historical data; retrospective
comparisons receive their interpretation from the reader and plan named.

## Interpreting results

Results include the API, producer and result handling of each workload.
Compare corresponding workloads and repeat each implementation. A persistent
change can reflect code, scheduling, placement, clocks, contention or their
interactions; diagnosing its cause calls for controlled interventions and
observations of the threads doing the work.

The empirical reliability assessment includes unchanged-code false calls,
known-change detection, inconclusive rates and runtime cost. Unit tests and
model-based intervals contribute implementation evidence; fresh calibration
and validation contribute measurement evidence. Published gains retain their
measured Linux scope, with adverse cells and earlier failed controls preserved.
