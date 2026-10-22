# Induction back edges must stay inside the successor domain

The shared loop checker previously verified the state at K+1 without proving
that the next iteration's preconditions hold there. An isolated AVX2 mutant
keeps the remaining input count unchanged while advancing its pointers. The
previous checker accepts it with **one back-edge path and zero return paths**.
After the last valid group, its next iteration falls outside the proof's
assumed K < groups domain.

The fix requires every back edge to imply the assumptions at K+1, with the
unsigned iteration rank advancing without wrap. It also requires a symbolic
64-bit iteration variable. Kernel assembly stays unchanged.

The SME2 callers supplied groups <= 2^40 but capped K <= 2^39. That extra cap
leaves their domain open at its upper edge. Removing it lets K < groups
supply the declared bound and makes the successor check hold.

## Source and scope

- [Minimal fix](https://github.com/devonjonte/BLAKE3/tree/candidate/devon-induction-domain):
  `ce839d685ba302e5d4c6109e7d231f897679e9e0`, based on upstream
  `216377a85dba492cbfa60f4d43344c893445cec3`.
- [X86 all-count pilot](https://github.com/devonjonte/BLAKE3/tree/candidate/devon-x86-counts):
  `333f4cfc9ab7cce0b5b3706a747da23523c239d8` contains the stronger walker, independent input regions and the
  standalone prover used by the mutation experiment. Its bounded-case list
  also adds the six fixed-counter sixteen-block cases.
- Prior walker loaded by the mutation experiment:
  `fbde8a2dd8d84409e8e0a2f84323bfe22416c7a4`, before the
  successor-domain fix. The archived script loads that helper alone while
  keeping the same prover and instruction model for the comparison.

The minimal fix passes **9/9 helper tests**. SME2 `parents_every` and
`xof_every` both pass with the closed declared group-count domain. Their input
encoding stays as it was. These assembled symbolic proofs run on an x86
host, with SME2 model vector length 512 bits. Native Arm execution remains
a separate validation step.

The x86 pilot rejects six isolated mutations:

| Mutation | Detection |
| --- | --- |
| Wrong input-table stride | Output differs |
| Wrong output stride | Output incomplete |
| Counter increments in the wrong direction | Required counter invariant becomes unavailable |
| Wrong remainder output stride | Tail output differs |
| Remaining count stays unchanged | Successor domain fails; the prior walker accepts it |
| Extra read after an individual input's end | Read outside that input's region |

The last check matters because independently bounded input buffers cover
noncontiguous callers too. One large contiguous input region would allow an
unused read across an individual buffer's end. The pilot instead represents
each pointer with its own region and arbitrary independent array words.

The six missing bounded cases (fixed counter, sixteen blocks, full width,
three x86 ISAs and both ABIs) also pass. Broader all-count ISA/ABI results
are being collected separately; this record establishes the helper fix and
the named controls.

## Reproduce

Use the minimal-fix checkout, Z3 bindings, and LLVM tools supporting SME2:

```sh
python3 -m unittest discover -s tools/verify -p test_helpers.py
clang-21 --target=aarch64-linux-gnu -march=armv9-a+sme2 \
  -c c/blake3_sme2_aarch64.S -o sme2.o
PYTHONPATH=tools/verify python3 - <<'PY'
import prove_sme2 as p
print(p.prove_parents_every('sme2.o'))
print(p.prove_xof_every('sme2.o'))
PY
```

The original helper job had a 60-second complete-process-group deadline;
the two SME2 inductions shared 180 seconds. They completed successfully.
Tests ran under CPython 3.14 with Z3 4.13.3 and LLVM 21 available.

From the x86 pilot checkout, run the archived `count-mutants.py` under a
300-second owned-process-group deadline. It assembles each isolated mutant,
runs the one-block AVX2 all-count proof, and repeats the count-preserving
mutant under the previous walker. It uses the existing `workers.each` with
two fresh processes. The six `.S` files and full logs accompany this record;
compiled objects and libraries are omitted.

Discussion and review: [proof work](https://github.com/johnservil/BLAKE3/issues/120).
