# Consistency diagnostic counterexample: shared physical core

Check the premise behind "a hash on the cores alone no slower shared" on a
known resource-sharing topology. A core-only implementation still shares
execution resources, caches and bandwidth with another hardware thread.

Reuse null artifact6d032dc2ffe48c3027a8fc9cc9ed41ad1e2cbbdc5b098d8dbbee9ab3677860ae.
Select sha256 and sha256-ring, lent1 KiB/lent64 KiB,120 explicit rounds and
existing clock traces. Read CPU topology; run twice with affinity0,1 (SMT
siblings), then twice with0,2 (different physical P cores). Each process has
an external120-second deadline. Preserve quiet/busy/missing-load outcomes,
raw reports, checks, traces and exact accounting. Shared bootstrap bands are
already excluded from inference; read the actual speeds and repeats.

Prediction: both correct core-only hashes can slow in shared mode on siblings;
the consistency report can flag the relation without implying a contender or
benchmark defect. A topology change gives a comparison, not proof that all
other machine state is controlled. Freeze calls/inputs and keep all outcomes.
No patch silently suppresses the observation. The proposed remedy is to label
relations with their premises and treat them as diagnostic expectations,
separately from exact accounting invariants, for maintainer review.
