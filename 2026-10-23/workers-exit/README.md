# workers.each stops promptly (BLAKE3 #131), October 23, 2026

Source `0f6ba89` (`candidate/devon-workers-exit`, on servil `83ab942`):
`each` kills and joins the workers still running when the run stops.

- `workers-failfast-repro.py`: one item raises, one sleeps 60 s. Before
  (`af5b8684`, data/2026-10-22/process-group-supervision): the stop waited
  for the sleeper, 60 s, past a 4 s external deadline. After: 0.07 s
  (`workers-failfast-after.txt`).
- `workers-early-stop-repro.py`: the caller closes the generator after the
  first result while a 30 s item runs. Before, with servil's workers.py:
  30.1 s (`workers-early-stop-before.time.txt`). After: 0.26 s, no child
  left (`workers-early-stop-after.txt`).
- `workers-exit-helpers.*`: `tools/verify/test_helpers.py` at `0f6ba89`
  under z3, bounded: 4 tests pass (this source's helper set).
