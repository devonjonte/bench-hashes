#!/usr/bin/env python3
"""Per-pair new/old ratios of named cells (contender|scenario|use_case|point)
from a kept regress run directory:  python3 cell_ratios.py DIR CELL..."""
import pathlib
import statistics
import sys


def means(path):
    header, out = None, {}
    for line in path.read_text().splitlines():
        if line.startswith("#"):
            continue
        fields = line.split("\t")
        if header is None:
            header = fields
            continue
        row = dict(zip(header, fields))
        pairs = [p.split("/") for p in row["ns/units"].split(",")]
        key = "|".join((row["contender"], row["scenario"], row["use_case"], row["point"]))
        out[key] = sum(int(a) for a, _ in pairs) / sum(int(b) for _, b in pairs)
    return out


root = pathlib.Path(sys.argv[1])
old = [means(p) for p in sorted(root.glob("run-*-old.tsv"))]
new = [means(p) for p in sorted(root.glob("run-*-new.tsv"))]
for cell in sys.argv[2:]:
    ratios = [n[cell] / o[cell] for o, n in zip(old, new) if cell in o and cell in n]
    if ratios:
        print(f"{cell}: {statistics.geometric_mean(ratios) - 1:+.1%} ({' '.join(f'{r - 1:+.1%}' for r in ratios)})")
    else:
        print(f"{cell}: not measured")
