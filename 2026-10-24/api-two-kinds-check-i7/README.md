# The fork's two kinds of call against the line before them, i7-12700K: no cell slower

**Question:** does the API change (outboard and Verifier deleted;
convenience and performance modules; Block and Batch; every performance
input in blocks) slow any cell?

**Commits:** new, devonjonte/BLAKE3 `api/two-kinds` 56d4053 with the bench
devonjonte/bench-hashes `bench/api-two-kinds` 9dddb605; old, `servil`
5e5742a (the branch's base) with the bench at 5be5f236, the same inputs in
blocks on the old API, so the comparison isolates the API.

**Command:** `bench-hashes check --against 5e5742a --old-bench 5be5f236
--keep kept` from the new bench inside the new checkout, under
run-bounded.py (3600 s); load 0.75 before; one pair repeated as busy.

**Verdict:** "regress: no cell slower" in both stages. 304 cells execute a
changed line (servil st and mt at 152 points). The first stage's eight
suspects went to 16 fresh pairs, which judged every one level (one,
servil mt OneMessage 1536 B, stayed a suspect below the margin). Samples in
`kept/`, the output in `check.*.txt`.
