# candidate/x86-generated on the i7, October 21, 2026

Question (#90): is the generated-assembly partial-chunk pass slower than
the Rust intrinsics it replaces, on the shapes it reaches?

servil 0c52bb5 against candidate/x86-generated 266cedf. bench-hashes
built against each (build-against), contenders blake3-servil-st and
blake3-servil-mt, four alternating pairs (old new new old, twice),
bench-hashes compare.

Verdict: no cell slower, after other work or after a pause, at 2 KiB to
512 KiB. The largest ratios read level: st after a pause at 3839 B
x1.136 (0 of 4 pairs faster) and 4470 B x1.131 (0 of 4), mt after a
pause at 4470 B x1.618 (1 of 4). Their pairs disagree too much for the
rule to call them. The 4-lane kernel at 1089-2047 B (the 2 KiB point is
its edge): st x0.953 after other work, x1.015 after a pause; mt x0.992
and x0.892. compare-full.txt has every cell.
