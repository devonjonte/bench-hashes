# Ode: a first non-BLAKE3 project and performance observation, November 13, 2026

## Question

Can the current Ode implement an outside project, and can a first observation tool
make a source choice's structure and measured cost visible?

Subject: Adler-32 (RFC 1950 section 8), an integrity checksum used by zlib. The
input bytes and length are public. This is a developer experiment, outside the
BLAKE3 release and its gates.

## Source and tools

- Sam's Ode: `samshackleton-tech/BLAKE3`, branch `experiment/sam-machine-code-lean`,
  **9a1ff09ec5f5f0d75139f02a4f7c1f4c81104666**.
- Observation tool, checksum sources and measured harness:
  `devonjonte/BLAKE3`, branch `experiment/devon-ode-adler`,
  **409c7da24f17987c3770c0addf989675ecea2b12**,
  `tools/verify/machine/observe.py` and `experiments/adler32/` there.
- Follow-up controls and the experiment README: **0c1a7ab8** on the same branch.
- Shared timing, load and comparison: bench-hashes' `clocks` at
  **5f99f456951ab36f7201decd8aa5e0249ec67bd1**, unchanged.

The observations were generated on the development machine. Each report records
Sam's starting commit and fingerprints the actual compiler/tool files, including
the then-new observer. The measured source commit holds those files. The EPYC
build checks its linked function's bytes against the observation before invoking
it. No Lean installation is needed on the measurement machine.

## Result

The checksum works under executable tests. The intended Lean contract definition
and two specification examples check. **The assembled checksum has no correctness
or memory-safety theorem yet.**

Two equivalent spellings of a conditional reduction produce different code:

| | `a >= 65521` | `a > 65520` |
|---|---:|---:|
| Isolated function bytes | 171 | 167 |
| Static instructions | 55 | 53 |
| Saved registers | 5 | 5 |
| Frame reservation besides saved registers | 0 bytes | 0 bytes |

The original spelling lowers to empty true branches; the printer emits a jump
over the nonempty false branch. The compact spelling avoids two such jumps in
the function's loop. Saved-register pushes use 40 bytes below the entry pointer.

EPYC 9275F, one pinned core, warmed back-to-back FFI calls, four old/new pairs,
each with a different explicit link padding; order alternates. Three byte patterns
at eight lengths. The compact spelling read faster in **9 of 24 cells**, with
none slower under clocks' existing comparison rule. Examples (change in the pairs'
geometric mean wall time):

| Public byte pattern | 4 KiB | 64 KiB |
|---|---:|---:|
| All zero | -10.8% | -18.9% |
| All 255 | -19.2% | -22.7% |
| Sequential 0..255, repeated | -21.8% | -20.3% |

Four same-code pairs, with corresponding link paddings and alternating order,
read **every cell level**. This is one exploratory control, not calibration of a
release gate. Individual same-code cells' ratios still vary visibly.

All sixteen runs were quiet under clocks' load readings. **Thread counters were
unavailable in every run.** There is no cycle or speed-state evidence, so the
figures describe wall time alone on this machine. They establish neither other
machines' costs nor a general hardware model of these instructions.

## Reproduce

`x86-epyc-9275f/run.sh` is the complete submitted job, including setup and build
commands. It builds all eight executables before timing. `ODE_PADDING` takes
0, 256, 1024 and 2048 bytes before the checksum; each sample file records its actual
linked function address too. Every pair is pinned to the same CPU, with the old
side first on odd pairs and the new side first on even ones.

The commands used for each measurement and comparison are:

```sh
taskset -c CPU timeout 45 ./runner-SIDE-PADDING --collect > pair-I-SIDE.tsv
./runner-old-0 --compare pair-1-old.tsv pair-1-new.tsv pair-2-old.tsv pair-2-new.tsv pair-3-old.tsv pair-3-new.tsv pair-4-old.tsv pair-4-new.tsv
./runner-old-0 --compare control-1-a.tsv control-1-b.tsv control-2-a.tsv control-2-b.tsv control-3-a.tsv control-3-b.tsv control-4-a.tsv control-4-b.tsv
```

See the experiment's README for generating observations and preparing the Cargo
workspace. The standalone adapter's `--validate` mode and nextest tests read no
clock. The `.tsv` records are read with `bench.rs` at the source commit above (or
its follow-up, which tightens validation without changing the sample contract).

## Records

- `x86-epyc-9275f/`: raw samples, per-run summaries and load, comparison/control
  outputs, build logs, provenance and the submitted job. Binary build products
  were deleted before delivery. Generated assembly, source and reports remain.
- `local-checks/`: executable tests, the intended contract check, benchmark tests,
  and the changed-linked-instruction control. Guard tests include a deliberate
  overread, which must fault. The synthetic comparison control reads unchanged
  pairs level and planted +20% pairs slower.
- `first-attempt/`: the first job stopped at the missing `b3sum` prerequisite before
  building or measuring. Its empty stdout/stderr and submitted command are retained.
  The successful job explicitly installs the pinned prerequisite before building.

## Scope and next move

The structural controls show that an identical isolated function stays byte-for-byte
the same under the tested unrelated source edits. They make no claim about all
edits, future compilers or final linked placement. The timing adapter covers warm,
scalar, one-core checksum calls. It preserves every sample and makes no timing
comparison on busy load.

Next: prove this independent function against its contract while recording the
project scaffolding and lemmas its author must supply. The empty-branch printer
case is a separate compiler improvement to discuss with Sam.

Posted to BLAKE3's Ode tracker, issue 361, with links to the experiment and this record.
