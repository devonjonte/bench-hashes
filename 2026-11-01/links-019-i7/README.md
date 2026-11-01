# check's link reuse and evidence ranking, ported onto bench 0.19 (i7-12700K, November 1)

**Question** (John, bench-hashes #98): what does the port cost under 0.19,
and what does it catch? The bench: `candidate/devon-check-links-019` on
0.19's candidate 015a4d3d (8 first-stage pairs from 4 links a side, each
run twice; suspects by evidence; a second stage of 64 pairs from 16 links,
each run 4 times), clocks with `Judgment::rank` (BLAKE3
`candidate/devon-evidence-rank-019`, 080d250f, patched by path).
Known truth: `--fork` at d09708f9 (servil 057d1eec + rank, #210 reverted:
#119's cold cost) `--against 080d250f` (servil + rank). A/A: `--fork` at
080d250f `--against` itself, `--cells all`. Command: `run.sh`.

| run | verdict | time |
|---|---|---|
| known-1 | no cell slower (suspects held mt idle 3839 B and st idle 7935 B; 64 pairs read them x1.03-x1.06, level) | 2973 s (first: coverage and relinks) |
| known-2 | 2 cells slower: mt and st OneMessage 3839 B, +3.8% and +3.7% | 2155 s |
| known-3 | no cell slower (suspects held st idle 3839 B and 2304 B) | 2230 s |
| aa-1, aa-2 | no cell slower | 2732 s, 2542 s |

Unported 0.19 on the same machine (`2026-10-31/review-019-i7`): A/A 1551 s;
#119 known truth 1868 s and 886 s, both missed.

Stage times: first stage 22-28 min (about 12 at 4 pairs), relinks 10 min
once, second stage 5-12 min. Read with the first 4 pairs alone, the three
known checks' suspects held as many slowed cells as with 8 (by evidence
5 against 5; by ratio 5 against 7): the doubled first stage bought nothing
here.

**Posted:** bench-hashes #98.
