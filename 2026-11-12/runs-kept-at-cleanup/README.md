# Run folders kept when the measurement machines were cleared, November 12, 2026

When the rented machines' scratch was cleared (ops, November 12), the
folders of finished runs whose samples were not yet on this branch were
delivered first. A folder a machine, a folder a run, each with its
`run.sh` (the question and the command), `stdout.txt` and kept samples.

| run | what it is | cited in |
|---|---|---|
| `trees-297` | BLAKE3 #297 against its parent, the trees by name | BLAKE3 #372, the 0.9 changelog draft's figures |
| `trees-297-own` (x86-avx2) | the same under the bench with every cell compiled apart | BLAKE3 #372's closing, bench-hashes #199 |
| `own-code`, `own-code-2` | that bench change against the bench before it, one library, every cell (on x86-avx2 `own-code` checked another commit by mistake; `own-code-2` is the run) | bench-hashes #199 |
| `core-gate` | the core's gate against 0.8 before checks across benches were pinned | BLAKE3 #357 (superseded by `../gates-pinned`) |
| `second-compile`, `compile-variants` (x86-avx2) | the removal and the long ring under a second compilation | bench-hashes CONTRIBUTING, "When a check reads a cell slower" |
| others | probes of the same days | |
