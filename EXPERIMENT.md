# Experimental detector — failed validation

This branch is an exploratory policy patch, **not an accepted reliability fix**.
The eight-pair arithmetic-mean rule produced false regressions in both fresh
identical-artifact production self-checks. It also missed/abstained on several
near-6% direct-caller controls. NO-GO remains; use the preserved upstream rule
for further diagnostics rather than adopting this experiment.

Plans and all evidence are published on Devon's measurement-trust branch at
`audit/results/six-percent-repair/README.md`. Source experiment1d9509c; the
following documentation commit changes no measured code. Existing hashing,
clock, workload and reader implementations were unchanged.25Rust unit tests
pass, which establishes the implemented policy rather than its reliability.

The benefit of the mean-pair mechanism falls short of its false-call and runtime
costs. Keep the evidence, set this experiment aside, and investigate measurement
provenance/calibration before another decision-policy change.
