# Stage A: the six-sample trim hides this intermittent mode

The unmodified candidate's Rust `compare` follows the predeclared arithmetic
on all60 cells:

| case | cells | outcome |
|---|---:|---|
| null,6/24 samples |20|all level at x1.000|
| uniform6% extra,6/24 |20|all slower at x1.060|
| intermittent,6 |10 phases|all level at x1.000|
| intermittent,24 |10 phases|all slower at x1.043 orx1.087|

These phases are deterministic inputs, not independent statistical trials.
At six samples, six phases contain one doubled-time sample; four contain
none. The trim removes the sole slow sample whenever present. All ten
retained means equal1000, even though their pooled raw time is10% higher.
At24, two/three slow samples leave one/two after trimming, producing
24000/23 or25000/23. The program prints their rounded fixed-point ratios.

**The implementation follows the declared rule. The rule loses a recurring
slow mode at the six-sample budget.** The data therefore blocks a reliance
claim that this budget preserves that mode's cost. Live acceptance remains
held while the policy tradeoff is reviewed. No live speed measurement or
uncertainty calibration was performed; the reader explicitly prints that
these unmeasured fixtures are no evidence of speed. `compare` exits0 on
completion; its exit code is separate from its printed slower judgments.

## Reproduce

Plan committed before execution: `ddfed246f83b753f2306206153133f5b1d46f88d`.
Use benchmark source`61afea44ac45fc94f0a91d5e150b56689891f074`, clocks
`99d34d94db14eac01a9c652e0a4858055502b08f`. Our CLI SHA256:
`3fafc7bf9e67f8bedcc2af6f2d9ba8fc79f4d5709c56c10fd65516e716cea640`.

```sh
python3 generate-fixtures.py
/path/to/bench-hashes compare fixtures/old-*.tsv -- fixtures/new-*.tsv
```

`generate-fixtures.py` only writes prescribed inputs. All parsing, selection,
fixed-point means and judgments run through the existing Rust implementation.
`stage-a.stdout.txt` retains every judgment and its load qualification.
