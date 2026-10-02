# Upstream refresh before further optimization

Checked October 2, 2026 at18:38UTC, then independently tested the highest-risk
queue fix. Published Devon hashing remains source-separated; the proposed
backport lives in `/home/agent/BLAKE3-upstream-refresh`, based on1e50159.
Current main/source branches keep their original work and evidence.

Fetched upstream BLAKE3 servil a926404/candidate8c89c31; benchmark mainf564f67e
(version0.11.0),candidate dc1b35ee. Upstream additions include correctness,
allocation/startup guarantees, I/O handling and Arm-specific optimization.
The new mean PRs have no John comments at this check; earlier freeze guidance
retains its source/version scope.

## First adoption priority: queue reference safety

Upstream0c928f9 reaches a slot's atomic next field through that field alone
and publishes a raw slot pointer. The older whole-slot references claim access
to neighboring mutable state while delivery/workers use it. This is a focused
ownership correction, preserving atomic ordering and digest behavior.

Independent matched smoke test on Devon1e50159:

- Before: same upstream queue round-trip fixture, original runtime code,
  Miri reports an invalid borrow tag in queue delivery (exit1).
- After: only0c928f9runtime+fixture patch, same Cargo.lock and Miri flags,
  round-trip test passes (exit0).
- Flags: pure, four simulated CPUs, ignore process-lifetime thread leaks.
  Borrow/race checks remain active. Initial after-run without leak exemption
  reaches Miri's exit-time outstanding-thread check; retained separately.
- Fixed-source release:82library+15API+oneone-CPU+oneallocationtest pass.
  The intentional handler-abort test prints its expected panic.

Evidence/logs and exact patch under
`/home/agent/bench-hashes-validation/upstream-refresh-20261002/`.
Recommended: backport this safety correction before new performance changes,
then validate the larger queue Miri fixtures0a57e27/3ee947f with bounded runs.
The source is staged in the isolated review branch, with historical baseline
preserved. It is a proposed adoption, pending the complete backport/check step.

## Other useful changes, ordered by benefit

1. **Allocation reservation and portability**,ad20a52: reserve room per queue
   lifetime for the double-hold handshake, rather than grow lists during a
   delivery race. Also repairs debug guard-page length overflow, no-std test
   gating, an unnecessary mutable binding and deprecated atomic update usage.
   The atomic load/store replacement is justified only under the existing
   sleep lock; preserve that invariant. Backport focused changes/tests.
2. **Initialization completes its allocations**,f75e6a6/3a8327f/9450ad2/6039657:
   initialize synchronization objects, start delivery alongside workers, and
   return after their thread startup. The final delivery-start fix completes
   the preceding guarantee. Treat these as one reviewed startup contract.
3. **Prefault benchmark storage**,441ad427: write nonzero buffers/output storage
   when created. This directly addresses lazy zero-page faults. Ensure creation
   and warm-up occur outside timed samples on every executing thread; the
   observed calibration defect and shared-copy initialization need their own
   coherent rule. This changes the instrument and starts fresh comparisons.
4. **Reader correctness**,5739af6 with its wider-reader prerequisite a39fb7c:
   hash bytes already read before returning a reader error. Review retry/error
   fixtures and Linux streaming cost together; the1MiB allocation is deliberate.
5. **Test portability**,07a0ef6: express affinity masks as native unsigned longs,
   preserving bit numbering on big-endian targets. Keep Devon's existing
   allowed-CPU selection and timeout supervision.
6. **CLI child accounting**,779cd2d/4153dfb: count reaped child CPU as own work
   in child-process benchmarks. Useful for futureCLI measurement. Review live-
   child scope and Unix FFI/32-bit ABI before adoption; our current in-process
   hashing comparisons gain little from adding that layer alone.

## Preserve useful differences

API removal a9ff56b drops thread budgets/Efficiency. That is an owner interface
choice with real caller implications; keep Devon's existing contract while
reviewing it deliberately. Whole-upstream merge could also replace Devon's
x86 batch/queue improvements. Selective backports preserve their tested scope.

Input/code prefetch, SME2/NEON extended-output and related trees are chiefly
Arm-specific. Their source guards and current evidence provide little immediate
x86 benefit. The latest b3sum cached-file mapping strategy is promising CLI work,
with file/race/error and Linux evidence needed for its scope. Neither group is
an urgent dependency of the next library optimization.

Recommendation: adopt verified safety/allocation/startup and instrumentation
correctness first, preserve API/workload contracts, then freeze fresh sources
and remeasure contenders. Mean-detector general-reliance acceptance remains
open; passing suites and maintainer measurements contribute their stated scope.
