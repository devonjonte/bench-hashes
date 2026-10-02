# Mean caller cost and fixed-block regression experiment

The user authorizes implementation after discussing bimodal summaries. This
candidate replaces the regression rule with total timed ns / completed units
and fixed-budget uncertainty. Source-separated branch candidate/devon-mean-
regression preserves historical instruments. Hashing and measurement workloads
remain fixed. The user's additional requirement makes graphs, reports, guide and compare
use the same shared raw caller-cost mean as the gate. Single-run graphs show
observed means and ranges; sixteen-block gate intervals describe cross-run
uncertainty. Historical graph contracts remain source-matched.

## Contract, committed before live collection

Sixteen fresh ABBA blocks (64 processes), each over the same fourteen points
and24rounds. Each block pools raw time/work from its two old runs and its two
new runs; the block value is the new/old time-per-unit ratio. Each block has
one vote in the arithmetic mean of16ratios. Fixed ABBA balances linear order
drift; temporal independence/exchangeability and representative block ratios
remain assumptions to validate. Original solo3% and shared10% tolerances stay.
Collect every declared block; one rule replaces early stopping, all-pair
conjunctions, selected fast clusters and conditional confirmation.

A two-sided Student-t interval over independent approximately normal block
ratios uses df15 and conservative critical value9/2 (4.5). For at most84tested cells,
Bonferroni bounds family error below5% under that model. This critical value
comes from statistical coverage; it defines uncertainty, rather than creating
performance states. Reproduce its tail with independent numerical integration
and record it. Check model assumptions/controls before claiming calibration.
Deterministic replay and synthetic anchors establish implementation correctness,
while fresh null/known-work controls establish this candidate's empirical scope.

All arithmetic is integer: raw u128 time/work totals; block ratios in parts per
million; mean and variance with exact sums; interval radius rounded outward
using integer square root. The critical radius uses the exact rational81/4.
The df15 two-sided tail at4.5 is0.00042329777;84times that is0.035557013,
within the declared5% family bound. Broadening for representational rounding is explicit.
Preserve raw records. shared clocks owns the mean/interval rule; the benchmark's
existing strict Rust v4 reader reads records. Python only orchestrates processes.

A cell whose whole interval exceeds1+tolerance reports slower. An interval
below1-tolerance reports faster. An interval inside the tolerance band reports
within tolerance. All other cells report inconclusive. Exit1 for any solo
subject regression; exit0 when all solo subjects are within tolerance or faster
and controls are within tolerance; exit2 for inconclusive solo subjects,
controls outside/overlapping the tolerance band, or busy/unobserved load.
Shared cells retain their reporting policy and every interval is printed.
Load abstention takes precedence; a moving control qualifies all subject calls.
A passing exit names the measured tolerance/scope. Fixed budget, no retries.

Every check keeps run requests/stdout/stderr/raw files in a named evidence
folder and a64-row manifest, including errors and load observations. Replay
uses the same reader/rule, with16four-run blocks in manifest order. Historical
files retain their original source tools and verdicts; exploratory replay stays
labelled retrospective and contributes zero fresh acceptance attempts.

## Initial validation, fixed before measurements

- Deterministic tests: identical, constant6/12%increase, mode-share shift across
  50%, unequal sample work, high block variation, exact threshold, more-than84
  cells, shape changes, missing/busyload. Independently fixed integer answers.
- Live pilots: two fresh identical-artifact full14-point checks, and direct
  known-work checks at0/6/12/100extra completed hashes per100logicalrequests,
  plus short and busyload controls. Existing independently anchored caller
  source and bytepattern retained; rebuild against this clocks source. Direct
  scope supplies plain-hash evidence; batch/queue positive coverage remains open.
- Each check bounded1200s; child processes inherit the owned campaign group;
  all outputs retained. Full pilot bounded10800s, short supervised tool calls
  poll completion to avoid harness request timeouts. Stop on execution defects;
  preserve statistical failures and finish declared pilots. No retuning.

Evaluate false calls AND detection AND inconclusive rates/runtime. A candidate
that merely abstains earns its cost only through useful real-change detection.
Full original acceptance includes freshnulls/positives/context/independent
reproduction and remains a separate campaign after the pilot meets its scope.
