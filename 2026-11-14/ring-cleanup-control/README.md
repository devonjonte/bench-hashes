# A failed Ring assertion can hang during cleanup

November 14, 2026. Diagnostic for the
[mutation-budget investigation](https://github.com/servil-software-factory/BLAKE3/issues/380).

## Observation

`Ring::drop` drains the queue through `pop_front`. A mutation that prevents the
length from falling can therefore hide an assertion failure during unwinding:
the assertion fires, but the damaged destructor keeps the test from returning.

This small fixture uses the exact Ring source from BLAKE3-Servil
**ab256b0d9ebb44eececd71ce0ae37113e75634a5**. One slot holds a zero-sized token whose
Drop yields. Repeated token reads involve no uninitialized bytes or owned
allocation; cleanup has an observable operation. Both test forms pass with the
original source.

The listed mutation `self.len -= 1` → `self.len /= 1` produces:

| Test ownership | Nextest result | Reported test duration |
|---|---|---:|
| Ordinary Ring | assertion prints, then TIMEOUT | 15.002 s |
| Ring inside ManuallyDrop | assertion returns as FAIL | 0.003 s |

The protected test still performs explicit ordinary cleanup on its successful
path. Restoring the source makes both tests pass again. The mutant's two processes
both exit through nextest with 100; the log distinguishes timeout from assertion.
These are operational test-run durations, not hash-speed measurements.

## Scope and next decision

This proves the cleanup mechanism in a controlled source-extracted case. It does
not establish the full library suite's outcome or mutation-run speed. The actual
suite already terminates running tests immediately after the first failure; that
mechanism should be reused.

Next, Devon will assess a small test-only change: keep failed Ring assertions from
invoking damaged cleanup and assert queue length at operation boundaries. Preserve
the existing destruction check on the passing path. Measure the actual selected
suite before changing any timeout row. Sam retains testing-policy ownership.
Production code and global timeouts remain unchanged.

## Reproduction

`ring-control/` is the complete dependency-free fixture. `ring-original.rs` and
`source.json` bind the copied source with both digests. `run-ring-control.sh` runs
baseline, ordinary fault, protected fault and restoration under nextest.

`nextest.toml` takes the library mutants profile's fail-fast and 15-second timeout
policy. Its project-specific binary filters stay with the library: copying those
filters first caused nextest to stop with 96 because this small fixture has no
pool-fairness binary. That setup failure is retained. `profile-policy.json` records
the extracted policy.

Run the script under a 120-second process-group supervisor. Logs retain the failed
assertion before the timeout. Fixture sources are restored; binaries and target
caches are excluded. Home prefixes are redacted in recipes/logs. Both manifests
cover this archive, excluding themselves.
