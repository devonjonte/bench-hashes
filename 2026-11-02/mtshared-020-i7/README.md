# bench 0.20 candidate (shared for the multithreaded contenders, each copy's CPU): A/A check (i7-12700K, November 2)

**Question:** does bench #115 (ee4a6b8b) read identical code as level? The fork at 0.8, `check --cells all`. Command: `run.sh`.

**Verdict:** no cell slower, both stages, 2116 s. A first-stage pair takes 158 s (0.19.7: 173 s; the full retirement, #110: 141 s).

**Posted:** bench-hashes #115.
