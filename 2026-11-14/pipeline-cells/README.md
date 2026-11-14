# Pipeline benchmark integration: correctness and scoped pilot

November 14, 2026. [Candidate PR](https://github.com/servil-software-factory/bench-hashes/pull/213),
[workload tracker](https://github.com/servil-software-factory/bench-hashes/issues/169).

Question: how does BLAKE3-Servil's Pipeline serve the existing owned-message,
batch, collection and receiving workloads, beside synchronous calls using
the same library?

## Source

- Pin-only synchronous baseline: `d1c20fdfcf75918e5a144f235a27484a3de1dc32`.
- Pipeline adapter: `4b90fe8502c52de09d70efb23db056862820a8d9`.
- Candidate including the CI package-index repair:
  `55436819e59a20eaa47a79f81e6594872ea40ff4`.
- Library throughout: `f62bc6ac0bc1c86861659d61ffbf4e9546bc8aec`.
- Experimental extra-work control: `7090f6b14bd70471b2236620b856556c61ac4477`.
  This branch adds one serial hash per sixteen room-fed messages while
  preserving useful output. It is never a production candidate.

## Contract and correctness

Pipeline rooms receive continuous messages and collection items directly.
Batches own their input and digest storage, returned together after hashing.
Receiving accumulates the original scheduled fragments directly into rooms,
committing full rooms until the final partial room. All results are consumed
before the sample ends. Construction occurs in calibration; each producer
keeps its state. Existing synchronous lent-buffer cells remain baselines.
Separate asynchronous `owned`/`lent` workloads are outside this first scope.

The candidate passed 185 release nextest tests, with 16 machine tests
excluded, and formatting. Five new tests cover fixed vectors, room boundaries,
fragment waits and completion, returned batch storage, and independent
concurrent producers. The release suite passes again after restoration of
the deliberate input-corruption control.

The control replaced the room producer's `copy_from_slice(piece)` with
`fill(0)`. Three tests failed: fixed vectors, room boundaries, and concurrent
producers. The last aborted during unwinding because its Pipeline still
held worker tasks, consistent with the library's fail-stop contract. Original
logs retain that outcome. No control remains in the candidate.

Initial compilation found a wrong test argument type (`Some(2)` instead of
`NonZeroUsize::new(2)`), corrected before the passing runs. Debug compilation
later reached the local supervisor's memory floor and stopped, exit 137.
The release suite in that same job had already passed. The bounded workhorse
job completed at 01:07 UTC: all five new tests pass with debug assertions
active (serial compilation, debug symbols disabled), and all 185 release
tests and formatting pass. `workhorse/` holds the original commands and logs.
Local tests are correctness checks on the interactive i7; no performance
timing ran there.

## Pilot status

Measurement jobs were queued under the host lock on EPYC 9275F:

1. `pipeline-pilot-55436819`: candidate/candidate and synchronous/Pipeline,
   four fresh-layout pairs per question.
2. `pipeline-added-work-7090f6b1`: candidate/extra-work control, four pairs,
   after testing that the control preserves the outputs.

Each question uses the same predeclared 19-cell selected scope. The exact
commands, bounds and interpretation are in `code/pilot-plan.md`,
`code/added-work-plan.md` and their shell scripts. The existing probe path
avoids adaptive second-stage context changes. This is a solo pilot; shared
and cross-platform conclusions require their own evidence.

**Performance verdict pending.** The scripts request standard raw samples,
CPU time and available counts. Busy/abstaining/error results stay in the
record. Small effects remain unresolved until the controls support an
interpretation at their observed size. The added byte-work fraction does
not prescribe its wall-time cost, and large-effect detection alone cannot
validate small-effect sensitivity.

Delivery is to local `bench-hashes-validation/inbox/`. Results will be added
here after inspection, retaining original logs and source-matched reader
output. The candidate remains a draft until review and measurements finish.

SHA-256 and BLAKE3 manifests cover the files other than the manifests themselves.
