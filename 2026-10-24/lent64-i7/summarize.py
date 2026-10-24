#!/usr/bin/env python3
"""Summaries of the i7 sweeps for bench-hashes #65 (cores-or-repeat, offset,
solo ns/B, shared ns/B per line)."""
import statistics
import sys


def rows(path):
    with open(path) as f:
        return [line.rstrip("\n").split("\t") for line in f if line.strip()]


def describe(path, column):
    values = [float(r[column]) for r in rows(path)]
    return f"n {len(values)}, min {min(values):.3f}, median {statistics.median(values):.3f}, max {max(values):.3f}"


def window(path, lo, hi, column=3):
    return [float(r[column]) for r in rows(path) if lo <= int(r[1]) <= hi]


for name in ("sweep16.tsv", "sweep16-tip.tsv"):
    print(f"{name}: shared {describe(name, 3)}; solo {describe(name, 2)}")
    inside = window(name, 3984, 4032)
    print(f"  shared at 3984-4032: {', '.join(f'{v:.3f}' for v in inside)}")
inside, quiet = window("confirm.tsv", 3984, 4032), window("confirm.tsv", 1008, 1136)
print(f"confirm.tsv: shared at 3984-4032 mean {statistics.mean(inside):.3f} (n {len(inside)}), at 1008-1136 mean {statistics.mean(quiet):.3f} (n {len(quiet)}): {statistics.mean(inside) / statistics.mean(quiet) - 1:+.1%}")
