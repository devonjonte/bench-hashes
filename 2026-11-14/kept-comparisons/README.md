# Protect saved comparison records and propagate probe failures

## Question and result

A populated `--keep` directory can contain results from an earlier invocation.
The old collector starts its run numbers at one again, overwriting matching
names while leaving higher-numbered files behind. A probe enumerates all those
accepted top-level files. Separately, its final report ignored the comparison
child's failed status and returned success.

Candidate **60e0f7206902a8be45b27754643d447ddc2a0553**, based on
**81e4b45a84e60f06b0ad93509403c5c33b2ad2c4**, gives `check` and `regress` one shared
new-or-empty directory precondition before setup. The invocation owns that
directory; driver logs go beside it. Existing records stay untouched. The probe
returns its comparison child's status. Its automatic disposable cache keeps its
existing behavior. Workloads, timing and statistical rules remain unchanged.

**Both new tests failed on the original behavior. All 193 release tests passed
after correction**, with sixteen machine/ignored tests skipped. Formatting and
diff checks passed. The two negative controls preserve their failure output:
accepting a populated directory and returning zero when the child exits seven.
The corrected test also exercises child exit101, normal exit0, exact old/new
ordering, exclusion of retried pairs, new/empty folders and file preservation.
Both command entry points reject occupied directories before any load reading,
checkout or child process. The team runner and offset-check caller already use
fresh `samples` subdirectories.

## Reproduce

The failing case first extracts the two existing bodies into helpers, preserving
their behavior, and adds the tests. From the base commit, apply
`kept-uncorrected-formatted.patch`, then run:

```sh
cargo nextest run --release --locked \
  -E 'test(kept_results_require) | test(a_probe_compares)'
```

Expect both tests to fail. On candidate60e0f720, run the same tests or the full
`cargo nextest run --release --locked`; expect success. The tests use fixed files
and a short `/bin/sh` child that records arguments and exits with a chosen status.
They perform no performance collection. Original failing and corrected logs,
bounded queue summaries and recipes are retained here. Home paths in logs and
recipes use `<development-home>`; source patches retain their bytes.

The original failures serve as the negative controls. The corrected test's
explicit failed children exercise failure handling again, so another equivalent
source mutation would duplicate that evidence. Performance collection is skipped:
the change affects setup and reporting, with timed calls untouched.

Tracking: [Preserve saved comparison runs and propagate probe failures](https://github.com/servil-software-factory/bench-hashes/issues/217).
Devon owns final CI and landing. SHA-256 and BLAKE3 manifests bind this record.
