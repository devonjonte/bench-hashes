# Archived proof-development notes

Zooko requested publication of the existing work, then a pause while John
builds [Bob's check](https://github.com/johnservil/BLAKE3/issues/130).
This folder retains the earlier count/parent/mask experiments, failed
attempts, solver diagnostics, prototype Python and mutant assembly sources.
Compiled objects and binaries are excluded.

These records describe development history. Sources varied between attempts;
some exploratory intermediate states lack a standalone commit receipt. They
supply context for the published fixes, with no additional completed cases
credited to the final matrix. Periodic faulthandler stacks are diagnostic
snapshots; final status and source scope determine each run's meaning.

## Source-matched results and code

- [Universal x86 counts](../x86-universal-counts/): **88/102** final-source
  cases at `14a716f35cbdf430fa845cc3dd9f5ee2c7b676cb`;14 remain. The interrupted
  block15 AVX-512 batch contributes no completed results.
  [Archived CLI/docs](https://github.com/devonjonte/BLAKE3/tree/71b4dd2e4c920b74821085ffbad2480b39175308):
  17 prior helper tests, actual CLI proof smoke test pending.
- [Induction domain/rank](../induction-domain/),
  [proposal](https://github.com/johnservil/BLAKE3/pull/126): successor
  assumptions and advancing rank, with six planted faults rejected.
- [Arbitrary incoming masks](../avx512-mask-inputs/),
  [proposal](https://github.com/johnservil/BLAKE3/pull/128):232 finite cases.
- [Independent SME2 parent bytes](../sme2-parent-independent/),
  [proposal](https://github.com/johnservil/BLAKE3/pull/129): concrete groups1/2,
  parent induction2..2^40 groups and XOF induction, two wrong strides rejected.
- [Generated AVX-512 partial experiment](../avx512-partial/): assembled
  proofs, native/SDE tests and instruction-model checks. Dispatch stays
  unchanged; native AVX-512 speed was outside the local machine's scope.
- [Generated two-input AVX2](../x86-pair-repair/): all three trials' assembled
  proofs and native tests. Performance has separate qualifications in
  [the corrected-rule reanalysis](../x86-pair-trim-reanalysis/).

Each source-matched folder holds its own commits, commands, logs and scope.
The existing proposals remain available for John's review. This archive
requests no further proof development or merging of the unfinished CLI.
