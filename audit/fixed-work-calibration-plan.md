# Stage3: matched fixed logical work before another detector change

User requests reliable6% detection and efficient progress under the written
reliance agreement. **NO-GO remains**, optimization paused. Failed affinity and
mean-pair experiments stay preserved. The mean-pair experiment is set aside.

## Small shared measurement change

The v2 bulk caller calibrates100-hash blocks to2ms; processes often choose1or2
blocks, differently across sides. This observed work/context mismatch motivates
one change: extract the existing shared clocks batch timing body as
`measure_calls(batches,calls,f)`. Existing `measure` retains its calibration and
calls this body. An explicit-call probe uses the SAME timer/counter/load body,
with fixed calls per sample. No second timer/statistic/sample reader or speed
splitter; original current benchmark `regress` four-plus-four/all-pairs policy.

Standalone known-work caller v3:100 logicalrequests/block,100+k observedhashes,
fixed per-sample blocks64B500,2048B30,102400B2, on BOTH sides and for BOTH SHA256
control/servil st. Constants selected from prior operation cost before measuring,
not tuned from freshresults. One untimed warm-up batch has the same fixedwork;
exact completion counts include it. Digest anchors unchanged. Same CLI arguments
and v4 sample schema; work-control metadata version3 identifies newprocedure.
No sleeps/padding/retries. The directcaller is distinct from production queued/
shared/MT paths and supplies no sensitivity claim for them. Linux cycles remain
unavailable through this clocks implementation; perf availability is a separate
finding, not hash measurement evidence here.

## Separate fresh calibration,56 processes

Fourteen ABBA blocks in fixed order: defaultnull,CPU0null, then three repetitions
of k6default,k6CPU0,k12default,k12CPU0.128 batches,oldk0/newklevel,SHA256extra0.
CPU0 is explicit `taskset -c0` on this solo caller; default remains0-19.
All raw outputs/counts/commands/artifact/source identities retained. Rust compare
pools old/new byblock and separately old-old/new-new. Python decodes no samples.

Declare an exploratory E=6% target for these solo caller configurations, with
k12 as2E. Qualification perconfiguration requires **every** block/per-size effect
inside nominal +/-10% (1054..1066 at6;1108..1132 at12), every same-code repeat and
null ratio971..1029 inclusive (strictly belowE/2=3%), and observedquietload. Report
SHA256 control repeat/effect behavior too. No median-only rescue. Failed
configuration(s) retain failed status. This new plan does not revise earlier
E=3%/default-affinity results or the written finite criteria.

If neither configuration qualifies, stop before live-gate pilot. This saves a
long campaign on an unqualified intervention. If a configuration qualifies,
commit its calibration outcome BEFORE held-out collection; retain the other
configuration as failed rather than switching it silently.

## Conditional held-out pilot, not acceptance

For EACH qualified configuration, run exactly4nulls,8k6 positives,4k12 positives,
short8-batch null,busy128-batch null/two CPUworkers. Actual original Rust gate;
wrappers preserve everychild raw before temporary-directory deletion and select
only explicit caller CLI/affinity. Process counts follow actual gate early stopping;
retain each initial/confirmationstage. Require no nullfaster/slowercalls,8/8
k6 holds at EACHsize,4/4k12 at EACHsize,negativecontrols2. Count abstentions as
misses. Every timeout/failure retained; no favorable replacements. Calibration
failure means conditionalpilot remains unstarted, not passed.

Each calprocess bounded120s,eachgatecheck180s; separate stagecampaigns1800s.
All supervision covers processgroups; busyworkers share supervisedgroup and
finallycleanup. Standard bounded perfcheck before sharedclock codecommit;
sharedclocks/tests/anchors plus benchmarktests. Preserve any no-verdict rather
than rerunning it as a validation pass. Freshcode/artifacts committed before
measurements. Explicit matchedwork does not establish generalproduction
reliability: finite66nulls/60valid/zerofalsecalls,30+30positivecounts,12ABBA/3sessions,
matchedproduction/directcaller families, reviewer and independentoperator still
required by `reliability-assessment.md` before a relevant LIMITEDGO.
