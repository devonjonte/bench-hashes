# bench-hashes 0.21, rehearsal 6 on the i7-12700K (November 10, 2026)

**Question.** After rehearsal 5's findings were repaired (BLAKE3 #349,
bench-hashes #165 and #167): do the release runs pass at the new pin,
bench `next` 9647c998, BLAKE3-Servil 2037118c?

**Command.** `rehearse-6.sh` (`rehearse-6.stdout.txt`: every step exit 0).

**Result: clean; 0.21 was tagged on it.** The full run (load quiet),
b3sum, crowd; both release checks against 0.8 (every cell, and the long
stream cells named) with no cell slower; the same-library check with no
cell slower and no instruction count moved.

Its release check's paired samples (`check/`) also draw the i7's side of
`../maps-08-vs-today/`.
