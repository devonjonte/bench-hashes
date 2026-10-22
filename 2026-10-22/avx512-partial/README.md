# AVX-512 partial-chunk kernel: correctness and static costs

Can the generated partial-chunk family use AVX-512's 32 vector registers
to keep its state and message words in registers, with the same output
and parameter-block contract?

**Correctness checks pass. Hardware speed remains open.** Production
selection still uses the existing kernels. This candidate targets 8–15
whole chunks followed by a partial chunk; it carries no speed verdict.

## Code and machine

- Base: johnservil/BLAKE3 `7e508243248ea42eac7e9511f3f851e4062ad271`
  (`candidate/x86-generated`).
- Kernel: devonjonte/BLAKE3 `09374b2`.
- Kernel plus prepared instruction checker:
  [`35db939f00fbdbce18ef22d7bfac9e57352d5cb0`](https://github.com/devonjonte/BLAKE3/commit/35db939f00fbdbce18ef22d7bfac9e57352d5cb0).
- Host: Intel i7-12700K, Linux x86-64, without AVX-512.
- Intel SDE 10.13.1, Skylake Server (`-skx`) emulation.
  [Intel download](https://downloadmirror.intel.com/924984/sde-external-10.13.1-2026-07-28-lin.tar.xz),
  SHA-256 `94e97d623fec54385686e1e7ba65ebc9941748c05ee451423948334892bf2b50`.

## Results

| check | result | records |
|---|---|---|
| Assembled symbolic proofs | 32/32: every snapshot block, Unix and Windows | `avx512-proofs-{0-7,8-15}.stdout.txt` |
| Instruction-model check under SDE | 265 register-only forms, 200 reproducible states each, all agree | `sde-model3.stdout.txt` |
| Native instruction-model check | 116 forms agree; 149 forms skipped | `native-model2.stdout.txt` |
| Native release suite | 92 tests pass | `native-suite.stderr.txt` |
| Release suite under SDE | 92 tests pass | `sde-suite.stderr.txt` |
| Build matrix | passes, including no-default-features, pure, warnings-as-errors, C API, generated-file checks | `check-builds.*.txt` |
| Prepared execution on the native i7 | stops with the required AVX-512F/VL precondition | `prepared-native.stderr.txt` |

Each symbolic case covers all sixteen lanes' independent inputs, starting
chaining values, counter halves, per-block lengths and flags. It checks
both final and snapshot outputs, memory bounds and calling conventions.
The 32 cases cover all sixteen possible snapshot blocks on both ABIs.

The partial-kernel test under SDE compares against portable code for
1–15 whole chunks, 31 partial lengths, and counters 0 and 2^32−2: 930
AVX-512 shapes. The full SDE suite also executes the existing AVX-512
implementation through normal feature selection.

SDE checks instruction behavior through emulation. Native AVX-512 CPU
validation remains useful independent evidence. QEMU 10.2's TCG here
lacks AVX-512; the QEMU partial tests exercised SSE4.1/AVX2 alone.

## Reproduction

Run from a checkout at the candidate commit. Install Z3's Python bindings
and LLVM tools. This host uses CPython with Debian's Z3 bindings supplied
through `PYTHONPATH`.

```sh
# Two workers; each batch was supervised with an 850-second deadline.
python3 /path/to/these/records/prove-partials.py 0 8
python3 /path/to/these/records/prove-partials.py 8 16

# Prepare outside SDE; execute the same instruction checker inside it.
python3 tools/verify/cross_check_x86.py --prepare /path/to/prepared
/path/to/sde64 -skx -no-follow-child -- \
  python3 tools/verify/cross_check_x86.py --prepared /path/to/prepared

# A capable CPU, or SDE, exercises the new width through the existing test.
CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_RUNNER='/path/to/sde64 -skx --' \
  cargo nextest run --release --lib --tests

cargo nextest run --release --lib --tests
CARGO_TARGET_DIR="$PWD/target/check-builds" sh tools/check-builds.sh
```

Initial attempts to run the checker wholly inside SDE failed when it
followed compiler subprocesses. Native preparation removes those
subprocesses from emulated execution. Their logs are retained as
`sde-model{,2}.*.txt`.

## Static costs

`rounds-{avx2,avx512}.s` contain the seven compression rounds emitted by
the generator. AVX2 uses 1064 instructions with 196 memory operands;
AVX-512 uses 784 instructions with zero memory operands.

The `mca-*.txt` files come from LLVM MCA 21:

```sh
llvm-mca-21 -mcpu=skylake-avx512 -iterations=100 rounds-avx512.s
llvm-mca-21 -mcpu=skylake-avx512 -iterations=100 rounds-avx2.s
llvm-mca-21 -mcpu=znver4 -iterations=100 rounds-avx512.s
llvm-mca-21 -mcpu=znver4 -iterations=100 rounds-avx2.s
```

These models compare the two generator designs. They exclude parameter
preparation, message transposition, CPU frequency changes and caller
costs. The actual dispatched baseline includes upstream's AVX-512
kernels. Only a hardware comparison against that baseline can establish
a useful speed gain. These records contain no wall-time/cycle benchmark.

Posted on [BLAKE3: generated, proved x86 kernels](https://github.com/johnservil/BLAKE3/issues/90#issuecomment-6331699452).
