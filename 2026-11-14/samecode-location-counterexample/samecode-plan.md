# Bounded same-code shortcut inspection

November14,09:20UTC. Budget15minutes for a fixed-input counterexample, then decide.
No production change or performance collection in this experiment.

Question: samecode.rs recognizes a panic Location by bytes alone: a pointer and
length naming a .rs string, followed by two32-bit words. Could an ordinary
file-limit record have that shape and hide an executable's changed output?

Compile the same two translation units at the same paths, with one constant
changing111→222. A record names input.rs and its maximum byte count. The program
prints that count. Use the unchanged production samecode.rs from bench60e0f720
(identical to81e4b45a8), both with and without location masking. Repeat with
input.bin as the matched negative control. No measurements, hashing or time reads.

Expected counterexample, if present: outputs differ; raw comparison differs;
masking calls the .rs pair Same; masking still calls the .bin pair different.
This would establish a deterministic limitation of the recognizer, not its
frequency in existing BLAKE3 builds. Before any remedy, weigh a conservative
comparison's lost short-circuits against adding binary-analysis machinery.
Preserve sources, flags, outputs and binary fingerprints; publish no binaries.
