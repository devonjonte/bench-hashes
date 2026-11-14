# Review the remaining ELF-note exclusion

November14,10:15UTC. Budget15 minutes for one fixed-input case and decision.
The location-mask correction retains the old exclusion of every ELF note. Review
that remaining piece before landing: notes can also carry program-readable data.

Compile a small valid allocated note with one named limit,111→222. The program
prints the limit. Use the current proposed comparator efe3dac3 directly. If it
reports Same despite the changed fixed output, narrow the exclusion to the
known compiler build-ID note, rather than inferring that every note is harmless.
Keep declared source-provenance masking. Preserve the initial candidate's scope
and this additional review finding; estimate no historical error frequency.

A permanent fixed ELF-object fixture can distinguish a build-ID note from an
ordinary allocated note without adding an ELF-analysis framework or a runtime
compiler dependency to tests. Check it independently with readelf/nm. No timing.
