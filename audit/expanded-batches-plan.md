# Expanded batch measurement and corrected x86 dispatch

October 2, 2026, about 04:30 UTC. The user explicitly authorizes adding batch
message lengths beyond 64 bytes when optimizing them. This is Devon's Linux
instrument version, source-separated from the upstream 0.10.0 freeze.

## Findings from the first experiment

The unqualified x86 full-run dispatch (retained `candidate.patch`) reduces six
whole-block messages by about 30% on CPU0 and 12% on CPU16, but removes the
padded fourth lane for batches of three. That costs CPU0 31–50% at 128–1024 B.
Reject that implementation as a ready contribution; preserve its 12-run ABBA.
Full-width groups were already passed to platform.hash_many, so describing the
benefit as newly filling eight lanes would overstate the result. The gain is
in remainder handling: the platform's tail versus separate hash_serial calls.
Broad after-gap differences and state shares also moved for unchanged SHA-256;
retain those results as context findings, not a no-regression guarantee.

## New instrument

Add `bench-hashes batches` for equal-length whole-block messages of
64/128/256/512/1024/2048/4096 bytes. Use the existing producer/delivery/hash
adapters, shared calibrated call counts, two-copy shared runner and speed
reader; emit v4 samples, raw count traces and source provenance. A length lives
in each point label, so unlike lengths never pool. Preserve original 64-byte
axes and the original frozen 2824fd0 artifacts. Expose owned queue and lent
synchronous families separately; no graph fabricated for an unmeasured axis.

Fresh default schedule: lengths64,128,256,512,1024,2048,4096;
counts3,6,8,16,64,129; lent and owned; solo and shared; 24 rounds (complete
participant-order cycles). SHA-256 control and servil st/mt subjects. Official
BLAKE3 optional: native batch kernel only through a chunk, loop above a chunk.
Fixture tests anchor each adapter's digests outside timing, unit counts,
queue cache separation and sample readback. Freeze after fixtures pass.

## Candidate sequence

1. Retain padded four-lane treatment for remainders of three on x86; let the
   existing platform handle other tails. Same cryptographic operation.
2. Add independently tested batched two-chunk tree from Devon's existing work
   only as a separate candidate; preserve counters0/1, flags and parent roots.
3. Supplementary CPU0/CPU16 ABBA (same frozen probe), default expanded-benchmark
   ABBA, and frozen14-point production diagnostic for each candidate. Old/new
   and same-side repeat outputs are computed by frozen Rust, every attempt
   retained. No favorable retries or retrospective pass for candidate1.
4. Require at least10% benefit in both repetitions for a targeted claim and
   record costs elsewhere, with default/pure/no_sme2 and published vectors.
   Timeouts/busy/unknown load remain inconclusive; no cryptographic relaxation.

This is the user's provisional optimization fallback, not completion of the
original reliance acceptance procedure. Work continues autonomously until
around12:30 UTC or an explicit stopping request; preserve a complete checkpoint.
