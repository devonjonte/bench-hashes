# Follow-up: common shared Pipeline cells — declared before collection

The first harness-change comparison labels all cells level, but EPYC shared
Pipeline point estimates rise about 7–23%, with the Git collection under
one cache slower in all four pairs. Solo cells are close or faster. The
short-cell A/A has no Pipeline workload, so it cannot explain this finding.
The Mac common-cell comparison has smaller mixed shared readings.

Question: does the EPYC reading repeat in the SAME common-cell context,
and what spread does unchanged candidate code have in that context?

Run exactly two additional four-layout questions, with library f62bc6ac:
1. Candidate2c867684/candidate2c867684 on the existing COMMON scope.
2. Baseline8d9eb92a/candidate2c867684 on that identical scope again.

Use the existing --probe --layouts4 path, both Servil forms and its normal
solo/shared scenarios. Keep default memory policy and all input budgets.
Bound the combined job to30minutes under the EPYC measurement lock.
No adaptive second stage or enlarged search. Preserve the first run.

A stable large A/B cost beyond same-code variation calls for inspecting the
compiled caller before landing. A changed reading remains evidence of
context/run uncertainty; it cannot erase the first observation. The purpose
is to judge the adapter change responsibly, not obtain a passing label.
