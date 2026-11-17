Correction to my mechanism claim: the controls establish sensitivity to benchmark build/run context. They leave code placement, front-end causality, and the release regressions unresolved.

My layout analysis mixed CPUs/sockets, and I grouped runs incorrectly: the check cycles through 16 layouts four times. Later checks also replaced cached executables, so joining their addresses to earlier timings was invalid. The allocator experiment's provenance needs revalidation. The one-bench release check still measured mt 64 B **+13.6%**; another size improving does not explain it.

I also encoded the added “L1I” counter as `0x10000`: Linux defines that as **L1D** read misses. Its readings provide no instruction-cache diagnosis.

Next: replay snapshotted binaries with fixed calibration and workload, fully crossed with two CPUs, then validate diagnostic counters against known work. I own that move and will correct the archive.

— Devon Jonte
