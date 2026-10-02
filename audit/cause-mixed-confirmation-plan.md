# Confirm the calibration intervention in the original mixed workload

The64process cold/warm queue intervention completes with allrunsquiet and
exacttrace/rawaccounting. Defaultcold sample means86–113us versuswarm461–947us;
P4cold129–251us versuswarm595–877us. Calling the same producer once before
calibration produces the predicted larger call budget. It also changes observed
caller cost:pooledwarm/cold~+7%default/~+4%P4,with every blockretained. Those
costs qualify any broad improvement claim. First-use calibration cost is a
supported budget mechanism; its effect on the original run intervals is open.

The next candidate adds that single untimed run_batch at the beginning of
calibrate_batch, for everycell, beforetheunchangedtime/adaptationloop. No
hashing,input,producerimplementation,clock,summary,tolerance orCI changes.
Preserve theexisting singleton remeasurement in this experiment to isolate
the added priming call. If adopting a coherent first-use rule later, assess
which redundant initialization handling can be removed under a new version.

Freeze one diagnostic artifact based on c3219e77 plus the priming call and
an explicit diagnostic-only CAUSE_PRIME_CALIBRATION=0|1 switch before the
unchanged calibration loop. Wrappers set0forbaseline and1forprimed and retain
that request. The same artifact isolates initialization from binary-layout
changes. Source/patch/SHAidentities stay retained before measurements. Use original14points/24rounds and16fullABBAblocks through
UNCHANGEDRustregressrunner/reader/mean/interval. Threepredeclaredchecks:
1.baselineagainstprimed,defaultplacement;
2.primedagainstprimed,defaultplacement;
3.baselineagainstprimed,separateP0/2/4/6,withsamefourCPUcapacityonbothsides.

The environment switch is a bounded causal-control mechanism in this isolated
diagnostic, with a mandatory declared mode. It supplies no production fallback
or compatibility layer. Adoption would keep one unconditional first-use rule
only after its evidence earns the cost.
Eachcheckretains64runs. Busy/unknownload andwidecontrols remaininconclusive;
no retries,tolerance changes or selected-cell exclusions. Percheckwholegroup
1200s;overall3600s or remainingtimebefore18:35UTC,whicheverless.

Compareactualsampleduration/callbudget and targetCIs/callermeans with the earlier
null and long-series receipts. Changesinworkload/context form partofthe effect.
The new artifact's freshnull supplies its ownscope; earlier evidence stays
source-specific. A quiet unchanged-code interval crossing3% reportsinconclusive,
not resolution clearance. Detectioncontrols remainthe earlierprototype'spilot;
no transfer offormalacceptancecounts tothiscandidate.

By18:35UTC stopandpublishthe actualoutcome: a scoped calibration-budget cause,
anyconfirmedrelationship tovariance,andremainingcells/causes thiseffortcould
not establish. Keepadversecostsvisible andavoidextendingthe study withnewknobs.
