# Selected context changes some queue measurements

Predeclared in [the protocol](../../context-sensitivity-plan.md). The same
null executable (SHA-2566d032dc2ffe48c3027a8fc9cc9ed41ad1e2cbbdc5b098d8dbbee9ab3677860ae),
P-only affinity0-15, three contenders and120 explicit rounds run A1/B1/B2/A2
then B3/A3/A4/B4. A selects three owned queue points; B additionally selects
lent1 MiB and lent pieces64 MiB. The artifact and cryptographic work at the
three common points stay fixed. All eight finish, read quiet, and pass full
report/trace accounting and complete per-point balance (A:12 cells /720
sampled dispatches; B:24 cells /1440 dispatches).

B's process lasts about16 seconds against A's1.5. Its input allocation,
calibration and preceding work differ as well as its selected neighbors.
These are context-sensitivity controls; attributing the effect to one immediate
predecessor, lingering, allocator or frequency would exceed them.

## Common points, B/A fast time ratios

The second column uses the opposite-order block's reciprocal direction,
rounded from its printed permille ratio. Raw medians and both speeds remain
in ABBA.txt and BAAB.txt.

| servil mt workload | ABBA B/A | BAAB B/A, approximate |
| --- | ---: | ---: |
| Owned1 KiB, solo | 1.044 | 1.075 |
| Owned batch16, solo | 1.093 | 1.072 |
| Owned batch4096, solo | 1.015 | 1.012 |
| Owned batch16, shared | 1.139 | 1.098 |

Batch16's within-context fast repeats stay within about1.5% solo and2.4%
shared. Its difference is appreciably larger and has the same direction in
both blocks. SHA-256 common points stay within about1.8% in these pooled
comparisons; its individual repeats also remain visible. Batch4096 splits
change and its same-context repeats vary, so this comparison supplies no
new claim that that cell is predictable.

This demonstrates a selected-workload dependence for these observed queue
cells. It supplies a useful experimental lead while the causal mechanism
and representativeness for users stay open. It neither establishes that
another code change caused an earlier slowdown nor erases those slowdowns.

## Regression confirmation scope

perf_regress narrows confirmation to initially slower points. That changes
the surrounding workload, and this experiment shows surrounding selection
can change a common point even with one executable. A confirming narrow
run and a broader initial run therefore answer related, distinct questions.
A narrower passing result cannot alone dismiss a repeatable mixed-workload
cost. This implication requires maintainer review and a direct test of the
gate's full policy; the current controls do not simulate a candidate-induced
carryover change or all adaptive execution paths.

Next: separate allocator/calibration/history factors where feasible, test
roster/order reversals with fixed allocations, and review the gate and
statistical grouping. Frozen calls remain unchanged; optimization stays draft.
