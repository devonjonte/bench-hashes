# #92's over-read fix on x86 hardware (BLAKE3 #92, #95)

`old-asm.*`: the fix's guard-page tests over the old assembly, SIGSEGV.
`matrix.stdout.txt`: the fix through every suite. `perf.stdout.txt`,
`perf-samples/`: `perf_regress compare a2126af dc0239a`, no cell slower;
batch cells median x1.005. `ge-*`: the collection guard-page test (#95)
on each x86 path, and faulting over the old assembly.
