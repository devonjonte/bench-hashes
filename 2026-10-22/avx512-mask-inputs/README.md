# AVX-512 proofs with arbitrary incoming masks — October 22, 2026

## Question and verdict

Do the existing finite AVX-512 proof cases still establish the result when
all incoming mask registers are independent symbolic values?

**232 of 232 cases prove.** The source's Setup promises junk registers but
previously left masks at the machine model's zero defaults. The repair
initializes all eight modeled 16-bit masks independently. These are finite
cases, separate from the arbitrary-input-count induction work.

Source: [devonjonte/BLAKE3 candidate/devon-mask-inputs](https://github.com/devonjonte/BLAKE3/tree/candidate/devon-mask-inputs),
`fc8dde577a2c7b872913c0dcd745d3e94d612d21`, based on
`216377a85dba492cbfa60f4d43344c893445cec3`.
Posted at [Prove x86 entry points with arbitrary incoming masks](https://github.com/johnservil/BLAKE3/pull/128).

## Scope and records

The 230 standard AVX-512 cases cover compress, XOF, hash_many on Unix and
Windows, and Unix xof_many counts 1–32. Two additional cases cover fixed
counters with sixteen inputs of sixteen blocks, both ABIs. The incoming
mask change leaves hash assembly and Rust machine code unchanged.

The first 1200-second supervised batch completed 143 cases and reached its
deadline. The second ran only the unfinished 89 cases and completed with
exit status 0. The recorded cases together cover the entire declared set;
proofs still in flight at the first deadline were repeated. Each batch
used two fresh worker processes at once and a 3 GiB virtual-memory cap per
process. Eight helper tests pass through unittest discovery.

Logs preserve both batches, including the first deadline. The driver's
only scheduling mechanism is the repository's existing `workers.each`.
The driver asserts that every recorded completed case returned `proved`.

## Reproduce

From the source checkout, with CPython's Z3 package available on PYTHONPATH:

```sh
python3 -m unittest discover -s tools/verify -p test_helpers.py
EVIDENCE=/absolute/path/to/this/evidence/folder
ulimit -v 3145728
python3 "$EVIDENCE/run-bounded.py" 1200 "$EVIDENCE/repro-first" \
  python3 -u "$EVIDENCE/resume-mask-cases.py" /dev/null
# After its deadline, pass the preceding stdout log to resume:
python3 "$EVIDENCE/run-bounded.py" 1200 "$EVIDENCE/repro-second" \
  python3 -u "$EVIDENCE/resume-mask-cases.py" "$EVIDENCE/repro-first.stdout.txt"
```

The included supervisor terminates its whole process group at the deadline.
The maintained copy is `/home/agent/bench-hashes-validation/run-bounded.py`.

These records establish the specified modeled executions. They supply no
AVX-512 hardware-speed evidence.
