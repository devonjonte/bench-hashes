# Two-input generated AVX2: third experiment

Question: does row-packed AVX2 recover the release baseline's 1536/2047-byte
performance, while retaining one generated parameter-block family?

The first candidate removed most of the 45–65% slowdown, but eight pairs
still detected +8.6% for single-threaded 1536 B after a pause. The second
candidate reduced message selection from up to seven instructions to at most
three; sixteen pairs still detected nine slower cells. Preserve both trials.

The next change adds the message to row a before adding row b, matching the
existing word-parallel generator and upstream assembly. Row a becomes ready
earlier than row b in the previous G half. This scheduling change can keep
one addition off the next half's dependent path. The arithmetic is unchanged.
Thirty-two assembled snapshot proofs and 92 native release tests pass.

Before examining the next measurements, declare:

1. Sixteen alternating fresh-layout pairs against release baseline
   c40892d2b426bf3c169fbe7bac3ab8ed0bcfd36b, same 28 research cells as the
   earlier trials. Keep every sample and log. The shared Rust comparison
   decides slow cells, with its existing 3% margin and 5% FDR.
2. Sixteen fresh-layout same-code pairs on this exact candidate snapshot,
   same 28 cells, as a control for this machine and harness.
3. Run the two jobs sequentially with no proofs or builds alongside them.
   Each job has a 1000-second process-group deadline.

A detected slowdown remains open. A control failure qualifies the harness's
verdict and requires investigation. A passing scoped experiment establishes
its declared i7 cells; the release's broader checks remain John's decision.
