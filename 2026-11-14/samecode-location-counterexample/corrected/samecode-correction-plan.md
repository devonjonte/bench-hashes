# Keep ordinary data in the same-code comparison

November14,09:33UTC. Issue219. Local implementation/check budget through10:30.
The fixed-input counterexample is published at data3e83ac4a7. Kept-record PR218
still awaits its last CI job; this work starts from its reviewed60e0f720 tree.

Decision: remove the panic-location recognizer. A FileLimit and a Location can
have the same bytes/shape, so more pattern matching cannot establish their use.
Keep the existing comparison of allocated sections, declared provenance masks
and ELF-note exclusion. Leave the sampled statistical rule and timed calls alone.

Explicit cost: source edits that only move panic-location line/column values may
now proceed to measurement. Identical code/data can still exit early. This gives
up an unsafe shortcut in exchange for one simpler comparison mechanism.

Add a permanent Rust fixture: a repr(C) file-limit record naming input.rs, with
111→222 in a copied image. Its symbol fixes the record's location independently
of the discarded recognizer. The test must fail against the existing comparator.
Then remove location masking, its flag, relocation-only state/parser and obsolete
positive test. Reuse the existing symbol lookup in tests. Update all callers/docs.
Run full nextest/fmt and replay the C counterexample with the corrected module.
Verify Same for unchanged programs, Differs for both changed-data pairs, and
existing declared-provenance masking. Keep negative controls and outputs.

No performance collection: this changes the early equality decision, with a
stated extra-measurement cost; it changes no measured workload or hashing code.
CI and final review precede landing. No new binary-analysis framework or dependency.
