#!/usr/bin/env python3
"""Verify and summarize the outboard pilot from its delivered files."""
import csv
import sys
from pathlib import Path

root = Path(sys.argv[1])
expected = {
    "warm": ["1 MiB", "mixed tree, 1000 files, 74 MiB", "1 GiB"],
    "cold": ["1 GiB"],
}
required = {"b3sum", "b3sum-1-thread", "b3sum-outboard", "b3sum-outboard-1-thread"}
for cache, labels in expected.items():
    samples = next((root / f"{cache}-results").glob("*/b3sum.samples.tsv"))
    rows = []
    with samples.open() as f:
        for line in f:
            if line.startswith("#") or not line.strip():
                continue
            row = next(csv.reader([line], delimiter="\t"))
            if row[0] == "contender":  # the column header
                continue
            rows.append(row)
    found = []
    for row in rows:
        if row[1] != cache:
            continue
        if row[3] not in found:
            found.append(row[3])
        assert len(row[5].split(",")) == 5, (cache, row[0], row[3], "round count")
    assert found == labels, (cache, found, labels)
    contenders = {row[0] for row in rows if row[1] == cache}
    assert required <= contenders, (cache, sorted(required - contenders))
    assert len(rows) == len(contenders) * len(labels), (cache, len(rows), sorted(contenders), labels)
    print(f"{cache}: {len(rows)} cells ({len(contenders)} contenders by {len(labels)} inputs); inputs {found}; five rounds each; required contenders present")
checks = (root / "outboard-checks.txt").read_text().splitlines()
assert len(checks) == 4, checks
for line in checks:
    assert line.endswith("files=1 bytes=4194240"), line
    print("verified:", line)
print("OUTBOARD PILOT CHECKS PASS")
