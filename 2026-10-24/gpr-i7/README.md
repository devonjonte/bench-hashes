# Sam Shackleton's GPR single-chunk kernel (BLAKE3 #150) on the i7-12700K

**Question:** is the GPR kernel, which is 36-53% faster than the SIMD
single-chunk kernel on the EPYC 9255 (Zen 5) for warm and idle single
messages, also faster on Intel, and is code size the cause of its costs?
Asked by Sam (P and E cores apart) and by Zooko (code size).

**Commits:** samshackleton-tech/BLAKE3 `candidate/sam-gpr-chunk-root-review`
87d837a (archived as tag `archive/gpr-chunk-root-87d837a` on
devonjonte/BLAKE3), against itself with the opt-in on (a local commit, its
build script's `BLAKE3_DIAGNOSTIC_GPR` test made `true`); her bench
`experiment/sam-direct-cold` b7ebfa2, with `diag-direct-cold` on by default
(local) and a local `check --points` (cells named, no coverage run). John
Servil's proof: tag `archive/gpr-proof-ce874a5`.

## 1. The bench's cells, P cores (`check-p-cores/`)

`taskset -c 0-15 bench-hashes check --against 87d837a --points "64 B,256 B,
1 KiB,idle 64 B,idle 256 B,idle 1 KiB,lent 64 B,lent 256 B,lent 1 KiB,64,
lent batch 64"` (p-cores-all; p-cores, the after-work cells alone). GPR
against SIMD, servil st, first stage (4 pairs) and second (16):

| cell | GPR's change in time |
|---|---|
| lent 64 B / 256 B / 1 KiB (warm, Sam's direct producer) | +25.0% / +20.5% / +20.2%, 4/4 pairs each |
| idle 64 B / 256 B / 1 KiB | +30.2% / +45.1% / +21.6% |
| after other work 64 B / 256 B / 1 KiB | +23.5% / +15.2% / +17.3% (16 pairs); +9.8% / +7.3% / +10.2% (first run's 4) |
| batches (controls) | level |

servil mt's single-message cells are slower alike (lent +21% to +38%). The
samples' header says "requested kernel: SIMD default" on the GPR side too:
it reads the environment variable at the bench's build, which the local
commit bypasses; the kernel run was GPR's (its test, 111 against 110).
The E cores were not measured.

## 2. Front-end counters, one P core (`frontend/`)

`main.rs` calls `hash_with(Mode::Hash)` on one aligned message, warm (2
million calls) or each after clocks' busy gap (3000), on CPU 2 under
`perf stat`; `drive.py` runs the grid three rounds; `grid.tsv` raw. Three
kernels: SIMD, GPR, and SIMD with 1972 bytes of executed no-ops at its
entry (`sled-control.patch`), its code the GPR kernel's 2996 bytes.

| warm, per call | ns | instructions | decoded-uop-cache uops | legacy-decoder uops | L1i misses |
|---|---|---|---|---|---|
| 64 B SIMD / GPR / no-ops | 41.4 / 56.8 / 41.5 | 541 / 961 / 543 | 532 / 443 / 533 | 2 / 513 / 2 | 0 |
| 1 KiB SIMD / GPR / no-ops | 714 / 855 / 716 | 7585 / 14111 / 7586 | 7451 / 7975 / 7455 | 23 / 6103 / 20 | 0.1 |

| after other work, call ns | 64 B | 256 B | 1 KiB |
|---|---|---|---|
| SIMD | 223 | 466 | 1162 |
| GPR | 242 | 504 | 1208 |
| SIMD + 2 KB no-ops | 246 | 504 | 1085 |

**Reading:** after other work, code size alone (the no-op control) costs
what GPR costs at 64 B and 256 B: fetching the extra 2 KB. Warm, size costs
nothing (the control equals SIMD, no instruction-cache misses); GPR
executes 1.8 times the instructions, most of their micro-ops from the
legacy decoders instead of the decoded-uop cache: decode-bound on this
core. The cold runs' counters, after subtracting a gap-only run, were too
noisy to read; the cold reading rests on the call times.

**Decision** (Zooko, October 24): this release ships the SIMD kernel alone;
the GPR kernel is kept for study (BLAKE3 #150, docs/experiments in the
fork).
