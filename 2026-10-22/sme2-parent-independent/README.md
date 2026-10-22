# SME2 parent induction with independent group bytes

## Question and verdict

Can the parent-kernel induction cover arbitrary joint input across groups,
through the shared invariant mechanism?

**Yes.** Concrete groups 1/2 and the induction over **2–2^40 groups** prove
with independent bytes throughout the input. The former `pair_word + group`
family covered each word's possible values individually, with a fixed
relation between groups. The new array removes that correlation.

The kernel preloads the next group's words into ZA. The invariant states
those reads at group K's addresses; its initial state and successor are
checked. The explicit-expression `Generalized.at()` support serves this
and the x86 counter invariants. Hash assembly stays unchanged.

[Prove SME2 parent groups with independent input bytes](https://github.com/johnservil/BLAKE3/pull/129),
source `af5b8684f648c3b1e524b4185b226345cbfb8313` on
`devonjonte/BLAKE3` branch `candidate/devon-independent-parents`, based on
servil `0dd218e0`. It includes the successor-domain/rank repair from
[Close the induction domain](https://github.com/johnservil/BLAKE3/pull/126).
The exploratory parent source was `e34bdbd239868c62eda3a83a9a32052412c37700`.

## Controls and limits

- Parent groups 1/2, arbitrary parent counts, and XOF arbitrary counts pass.
- **11 helper tests pass.** The array-fingerprint anchor fails before its
  fix: low-byte hashing always collides at offsets 256 bytes apart. High
  bits yield the independently fixed values 0 and 0x23 with the chosen
  multiplier. This is only a filter; equality requires the solver.
- Two modeled wrong kernels reject: input stride 1024→512 and output
  stride 512→256. The existing executor and fresh-process workers run them.

The first independent-array attempt failed until the preloaded ZA input
had an explicit invariant. That failed proof remains beside the successful
ones. This is modeled execution of cross-assembled SME2 on Linux x86-64,
separate from native Arm execution and speed measurements. The assembly
object was rebuilt from source; its bytes are absent from this data folder.

## Reproduce

From the source checkout, with CPython and Z3 installed, set EVIDENCE to this
folder's absolute path and build the object locally:

```sh
EVIDENCE=/absolute/path/to/this/folder
mkdir -p target/verify
OBJ="$PWD/target/verify/repro-sme2.o"
clang --target=aarch64-linux-gnu -march=armv9-a+sme2 \
  -c c/blake3_sme2_aarch64.S -o "$OBJ"
python3 "$EVIDENCE/run-bounded.py" 90 "$EVIDENCE/repro-helpers" \
  python3 -m unittest discover -s tools/verify -p test_helpers.py
python3 "$EVIDENCE/run-bounded.py" 180 "$EVIDENCE/repro-strides" \
  python3 -u "$EVIDENCE/parents-array-mutants.py" "$OBJ"
python3 "$EVIDENCE/run-bounded.py" 180 "$EVIDENCE/repro-parent" \
  python3 -c 'import sys; sys.path.insert(0,"tools/verify"); import prove_sme2 as p; print(p.prove_parents_every(sys.argv[1]))' \
  "$OBJ"
```

We used LLVM 21 for the cross-assembly. Final verification commands returned
0. The deliberate red fingerprint and first array proof failed. Two early
mutant-driver calls also failed during disassembly setup; their logs are
preserved and contribute zero rejected-mutant controls.
