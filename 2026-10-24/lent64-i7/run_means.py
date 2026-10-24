#!/usr/bin/env python3
"""Each kept regress run's mean (total ns over total units) for one cell:
    python3 run_means.py SAMPLES_DIR SCENARIO USE_CASE POINT"""
import pathlib
import sys

root, scenario, use_case, point = sys.argv[1:5]
for path in sorted(pathlib.Path(root).glob("run-*.tsv")):
    header = None
    for line in path.read_text().splitlines():
        if line.startswith("#"):
            continue
        fields = line.split("\t")
        if header is None:
            header = fields
            continue
        row = dict(zip(header, fields))
        if (row["contender"], row["scenario"], row["use_case"], row["point"]) == ("blake3-servil-st", scenario, use_case, point):
            pairs = [p.split("/") for p in row["ns/units"].split(",")]
            ns, units = sum(int(a) for a, _ in pairs), sum(int(b) for _, b in pairs)
            print(f"{path.name}\t{ns / units:.3f} ns/B\t({len(pairs)} samples)")
