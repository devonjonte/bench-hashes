# Preserve the samples a comparison means to read

November 14, 09:10 UTC. Budget: inspect/reproduce/patch/test by 10:45; stop or
record a narrower result if that needs a broader redesign. Base bench81e4b45a8.

Observed code paths:
- regress creates --keep with create_dir_all and writes run-NNN-SIDE.tsv from
  index1 again. Reusing a folder overwrites some records and leaves longer old
  runs behind. check --probe then enumerates every top-level run-* file.
- check --probe discards its compare child's status and returns0. A malformed
  saved record can therefore produce an error report followed by successful
  outer status.

Decision: fix these concrete recording/error-propagation defects without changing
workloads, sampling, statistical rules or follow-up selection.

Contract: an explicit --keep directory is absent or empty and belongs to this
invocation. Check it before expensive setup. Share the directory precondition
between check and regress. Keep the automatic disposable probe cache's existing
behavior. A valid comparison still yields probe success regardless of its speed
labels; a failed comparison propagates its status.

Reproduce with the actual extracted existing helper bodies, fixed files and a
short shell child: occupied-directory refusal and child-status tests must fail
before correction. Then verify new/empty folders, preserved existing bytes,
exact accepted old/new ordering, exclusion of retried records, and successful
and failed child statuses. No benchmark runs or physical-clock tests on i7.
Read the team runner's caller: it passes a fresh out/samples directory.

Complexity budget: two small helpers extracted from existing code, tests and the
updated --keep contract. Reuse existing subprocess and filesystem mechanisms.
No new flag, format, dependency, statistics or generic execution framework.
Run nextest/fmt under bounded supervision, then one deliberate fault control
against the restored implementation. CI covers supported platform builds/tests.
Performance collection is skipped: this changes setup and reporting only.
