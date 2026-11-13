# Ode's Adler-32: the generated machine-code proof, November 13, 2026

## Question and result

Does Ode produce a proof that the original Adler-32 machine code meets its
intended modular-arithmetic contract?

**Yes.** Lean checks the generated theorem, for every input and permitted entry
state:

```lean
Proof_adler32.adler32_meets : ∀ (input n : BitVec 64) (bytes : List (BitVec 8)),
  Abi.Meets Code_adler32.prog 0x100000 (Adler32.contract input n bytes)
```

The lifted x86-64 program terminates without a modeled fault, returns the specified
Adler-32 checksum, preserves the calling convention, and leaves memory outside the
permitted stack area unchanged. The contract grants 64 bytes; the generated proof
uses 40. Its usability theorem has a concrete nonempty input as witness.

The 171-byte, 55-instruction assembled object is byte-for-byte identical to the
original experiment's object. No new timing was needed. The compact spelling
benchmarked beside it remains tested only; it has a different object and cannot
inherit this theorem.

## Source and command

`devonjonte/BLAKE3`, branch `experiment/devon-ode-adler`, commit
**2aa3d245305b494143223b341e564642a4eb2d20**, based on Sam's
**9a1ff09ec5f5f0d75139f02a4f7c1f4c81104666**.

From `tools/verify/machine/`:

```sh
sh experiments/adler32/build.sh NEW_OUTPUT_DIRECTORY
```

The project build generates the assembly, lifts the object, generates the proof,
checks it, observes the object and compares the two paths' assembled objects. A
failed proof stops the build before the output directory is published. Development
can opt out explicitly with `--skip-proof`; that report remains unverified.
The low-level structural observer still describes itself as proof-unchecked.

Underlying proof-driver command:

```sh
cd lang
SOURCE=../experiments/adler32/adler32.ode ODEMOD=AdlerOde ./prove_fn.sh adler32 0x100000
# Fresh check, bypassing the target cache:
lake env lean Proof_adler32.lean
```

## What the author supplied

The source names the contract, an invariant (current sums followed by remaining
bytes give the whole checksum), `decreases n - i`, a lemma opening the next byte,
and the lemmas carrying the four subtraction paths and closing the result.

`Lemmas_adler32.lean` has 133 lines of supporting lemmas. They connect conditional
subtraction on bounded words to modulo 65521, carry the invariant through a byte,
and pack the final checksum. The generator writes the 272-line machine proof.

The proof generator needed three extensions: variant expressions, byte-load
values in read-only loop branches, and normalization of a saved register at offset
zero. The assembly printer is unchanged. Existing `push`, `pad` and `merge` proofs
regenerate and check; generated files for them remain unchanged.

## Trust and scope

This theorem is about the lifted program on Ode's x86-64 model. LLVM objdump and
the existing lifter remain trusted in the object-to-model link. Lean reports its
three standard axioms **plus 32 native bv_decide axioms** (listed in AXIOMS.txt).
This does not yet meet Sam's goal of independent checking with only the three
standard axioms. Hardware behavior beyond the model is outside the claim.

Input and length are public. There is no constant-time or exact execution-work
bound in this theorem. The correctness definition is the experiment's readable
RFC 1950 modular-arithmetic contract, not a theorem importing zlib's implementation.

## Controls and records

- `artifact/`: generated code and proof, assembly, layout, disassembly, report and
  full proof log from the committed build. No binary build products are published.
- `checks/`: fresh direct Lean run, seven passing project tests, the existing-proof
  regressions and the two proof-audit attempts.
- `controls/`: each changed source/contract and its log. The unchanged and restored
  controls also run Lean directly, bypassing the target cache.

Wrong seed, overread and wrong result-contract variants fail the machine-code
proof. A contradictory contract fails the usability theorem. **Wrong reduction
and wrong packing receive no verdict at the 30-second deadline.** The first
wrong-reduction attempt also timed out at 120 seconds. These are recorded as
timeouts, not caught mutants. Audit attempt 2 exits 2 to keep its incomplete
verdict visible; its restoration control checks successfully.

The project tests also show that the default build checks the proof, an explicit
skip leaves it unverified, and a wrong seed fails before publishing the output.
Both correct checksum spellings retain their native/zlib/guard-page tests.

Earlier test and timing evidence is preserved unchanged in
`2026-11-13/ode-adler32-pilot/`, whose stated absence of a proof describes that
historical source commit.
