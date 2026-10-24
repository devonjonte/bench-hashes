#!/usr/bin/env python3
"""Per-pair new/old ratios of each cell at one point, from a kept check's
runs (run-NNN-old.tsv / run-NNN-new.tsv, paired in order):
    python3 pair_ratios.py RUNS_DIR POINT"""
import pathlib
import statistics
import sys


def means(path, point):
    header, out = None, {}
    for line in path.read_text().splitlines():
        if line.startswith("#"):
            continue
        fields = line.split("\t")
        if header is None:
            header = fields
            continue
        row = dict(zip(header, fields))
        if row["point"] != point:
            continue
        pairs = [p.split("/") for p in row["ns/units"].split(",")]
        out[(row["contender"], row["scenario"], row["use_case"])] = sum(int(a) for a, _ in pairs) / sum(int(b) for _, b in pairs)
    return out


root, point = pathlib.Path(sys.argv[1]), sys.argv[2]
old = [means(p, point) for p in sorted(root.glob("run-*-old.tsv"))]
new = [means(p, point) for p in sorted(root.glob("run-*-new.tsv"))]
for cell in sorted(old[0]):
    ratios = [n[cell] / o[cell] for o, n in zip(old, new)]
    gm = statistics.geometric_mean(ratios)
    print(f"{'|'.join(cell)}|{point}: {gm - 1:+.1%} ({' '.join(f'{r - 1:+.1%}' for r in ratios)})")
