# Known costs and owners (0.10.0)

- **Large one-shot calls on machines with several L3 caches** (John Servil,
  [BLAKE3 #401](https://github.com/servil-software-factory/BLAKE3/issues/401)): the
  every-core form's one message of 32 MiB and more, 64 MiB lent, and the Nix
  collection. These are the cells beyond 5% above, on the two Zen 5 servers and the
  EPYC 7443 pair.
- **A turn of 1024 × 1 KiB messages** (John Servil,
  [BLAKE3 #404](https://github.com/servil-software-factory/BLAKE3/issues/404)): 3% to
  5% slower on both Xeon pairs. An AmpereOne virtual machine reads the same workload
  4% to 5% slower (the release's check there,
  [BLAKE3 #447](https://github.com/servil-software-factory/BLAKE3/issues/447)).
- **b3sum, one cold 16 MiB file on the two-socket machines** bound to one memory
  node: slower than @@BASE@@ there (the table above), faster on the one-socket
  machines. Reported on
  [BLAKE3 #402](https://github.com/servil-software-factory/BLAKE3/issues/402); the
  cause is unexamined.
- **A stream's caller beside a worker on its SMT sibling** (John Servil,
  [BLAKE3 #237](https://github.com/servil-software-factory/BLAKE3/issues/237)): the
  copy into the ring is slower when a busy worker shares the caller's core.
- **Every other slower cell** is listed by name on its machine's page.

- `evidence/<machine>/` holds each run as delivered: the b3sum suites' reports and
  samples, the release check's output and kept runs (`kept-release/`), and each
  `run.sh`. `tools/` holds the scripts that wrote this page. `SHA256SUMS` and
  `BLAKE3SUMS` cover every file.
- **Versions:** BLAKE3-Servil 0.8.0 `b5b988d8982bea9490c38c79ec4b8c5c2428270c`,
  0.9.1 `2c60420c2bccbf6073e35e668691d98520f9b096` (0.9.0 `bf2da8b957f5e0c80babb57952de3e53f95c921a`), 0.10.0 `@@COMMIT@@`; official
  b3sum 1.8.7; bench-hashes 0.23.0 (`cade30fdb71682719f5fa3e586ff96146ae9fc25`) for
  b3sum and 0.22.0 (`97c0fbcbedb8fe8f8395115647684dfde75d67a3`) for the library.
- **How the tables are made:** b3sum cells are copied from each run's report; library
  verdicts are `bench-hashes compare`'s (0.22) over the kept runs, with the second
  stage's verdict for the cells a check measured again. The scripts count and group;
  they judge nothing.
