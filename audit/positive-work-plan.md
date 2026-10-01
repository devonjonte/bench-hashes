# Positive actual-work controls: fixed before timing

Complement exact-artifact nulls with a small direct caller, using clocks and
shared readers/rules. This is diagnostic work accounting, separate from the
frozen benchmark's production workloads.

- Same executable per block; factors 1/2 select one/two completed hashes per
  logical request, each digest observed. Normalize by logical requests, so
  extra work remains visible rather than dividing it away.
- SHA-256 sha2 and servil single-threaded, plaintext byte i = i % 251,
  lengths 64, 2048 and 102400; independent anchors checked before timing.
- Thirty-two batches of about 2 ms per cell through clocks::measure, with
  raw time/work, starts, load windows and available thread counts retained.
- Factor order 1/2/2/1 on P CPU0, then 1/2/2/1 on E CPU16. One artifact.
  Thirty-second external process-group deadline per run. Busy/failed runs
  stay retained and invalidate that block's speed interpretation.
- Expected fast time ratio: 1.8-2.2 for lengths >=2048; 1.6-2.4 for 64 B,
  allowing fixed loop/observation overhead. Declare any miss, split change
  or unstable repeats as a finding. No retry to obtain a favorable ratio.

Completed work is counted independently of sample denominators, including
calibration. The helper has one calibration of the same call count as each
measured batch; assert observed completions equal (batches + 1) * calls *
factor. Preserve this accounting, then use the shared compare-runs tool.

Passing these controls validates this direct caller's selected work/timing
response, not the full benchmark's queues, gaps, calibration or statistics.
Native reference/fixed digest tests of the harness adapters are a separate
check. Thread cycles and energy remain unavailable on this Linux platform.
