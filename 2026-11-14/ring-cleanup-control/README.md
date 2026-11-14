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

The test-only candidate **8a6c53a790b5a093eccb9e709047f66ddd9b72af**, on branch
`candidate/devon-ring-assertions`, adds count assertions and ManuallyDrop to the
existing Ring test, preserving the passing-path destruction check. Its production
prefix before the test module is byte-identical to the base.

The actual thread-crate mutation runner on the workhorse already caught all three
selected variants before the change. It catches all three afterward too:

| Mutation | Before test phase | After test phase |
|---|---:|---:|
| push `+=` → `-=` | 0.452 s | 0.452 s |
| pop `-=` → `+=` | 0.603 s | 0.602 s |
| pop `-=` → `/=` | 0.602 s | 0.603 s |

These are single operational observations, rounded for presentation from the
retained cargo-mutants fields. They establish no overall latency improvement.
Builds cost about 1.9–2.0 s per variant separately. Both unmutated baselines pass.
The new Ring test reports direct assertions for the two pop faults; previously
it was interrupted for the first and segfaulted for the second. In the push case
it is interrupted after another test catches the fault, so it supplies no outcome.

**Decision:** hold the candidate for review, with its diagnostic improvement and
its unchanged whole-test-phase result explicit. The fixture's 15-second saving
is not a claim about the library suite. Further Mac/list work belongs to Sam's
review. No global timeout, known list or production behavior changed.

`pilot/` keeps both complete arms and setup failures. The first attempt missed
the check module's import path; the next completed the baseline but stopped on
its own overstrict clean-tree check after the runner wrote its declared `tmp/`
records. The final invocation continued the candidate arm with that scratch
folder allowed, preserving the original baseline. The existing runner/profile,
selector, caps and three named input mutations stayed fixed.

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
