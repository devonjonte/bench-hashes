# Intel i7-12700K audit run

These are diagnostic results from the benchmark audit, with the remaining
limitations listed in [AUDIT.md](../../AUDIT.md). Download the
[SVG](bench-hashes.graph.svg) and open it in a browser for interaction;
[the HTML guide](bench-hashes.guide.html) is self-contained too.

## Reproduce

Measured benchmark source: `ba4a32712d5e5a4028b5f1146c59583ac2cec427`,
clean at build time. The lock pins BLAKE3 servil and clocks to
`7270b2105f2c19a0a79f02d023a53614843e95cc`. Rust 1.98.1, generic release
build; no CPU affinity or governor changes. Linux 7.0.0-34-generic,
20 logical CPUs. Each measured use case's participating contenders
complete Williams cycles, including long cells.

```sh
git checkout ba4a32712d5e5a4028b5f1146c59583ac2cec427
cargo build --release --locked
```

Run the resulting executable from an isolated directory, under an
external supervisor with a 600-second deadline and process-group cleanup:

```sh
/path/to/bench-hashes --contenders blake3-official,blake3-official-mt,blake3-servil-st,blake3-servil-mt,sha256,sha256-ring,sha1dc,sha3-256 --trace-clocks clocks.csv
```

The run completed in **278.7 seconds**. The shared load detector reported
quiet: **0.13 CPUs average**, **0.21 CPUs in the busiest window**.
The benchmark used its default 96-round schedule with complete sampled
order cycles; an explicit `--rounds` value was not supplied.

## Validation

- All **1,296 report cells** recomputed from raw measured samples agree.
- SVG zoom, toggles, units, hover and layout checks pass.
- HTML guide: **48 decision routes**, **21 clicked endings**, examples,
  hovers, API-preserving pattern chips, defaults, Back and restart pass.
- The benchmark source passes **23 Rust tests**, **4 Python checker
  tests**, synthetic guide-summary checks, and compiles all nine examples.
- A separate clean quick run completed in 56.6 seconds: **720 report
  cells** agree, and SVG and guide checks pass (18 measured endings).

## Interpretation limits

This is one full run, not an optimization A/B or a speedup claim.
Single-threaded x86 hashing uses the inherited upstream kernels;
multithreaded and queue APIs exercise the fork's scheduling.

Shared bootstrap intervals currently treat simultaneous copies as
independent observations and can overstate precision. Queue and
multithreaded incremental kernel descriptions are inferred from
one-shot reports and may omit helper-thread behavior. Consistency checks
are diagnostic relationships, rather than mathematical hash invariants.
Read their findings with the audit's explanations.

The clocks crate provides no per-thread cycle counts on this Linux
machine. Trace zeros mean unavailable counters, not zero work.
No ARM64, SME2, Mac, energy-efficiency, or regression-free claim is made.
Historical native-target SHA-256 anomalies are kept separately; this run
uses the generic target and does not represent them as normal SHA-256
performance. Compare alternating builds and same-build repetitions before
using small timing differences to justify implementation changes.
