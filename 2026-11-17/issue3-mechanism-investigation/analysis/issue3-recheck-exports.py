#!/usr/bin/env python3
"""Exact descriptive displays from the Rust auditor's exports, not samples files.

Run in the directory holding issue3-*-run-totals.tsv and sample-values.tsv.
These are exploratory pooled totals and tails, not statistical verdicts.
"""
import collections
import csv
from decimal import Decimal
from fractions import Fraction
from pathlib import Path
import statistics

KEY = "blake3-servil-st|solo|OneMessage|128 B"


def read(path):
    with Path(path).open() as f:
        return list(csv.DictReader((l for l in f if not l.startswith("#")), delimiter="\t"))


def display(value):
    return str(round(Decimal(value.numerator) / Decimal(value.denominator), 3))


def rate(rows, field):
    return Fraction(sum(int(r[field]) for r in rows), sum(int(r["units"]) for r in rows))


for dataset in ["original", "icache2"]:
    totals = [r for r in read(f"issue3-{dataset}-run-totals.tsv") if r["cell"] == KEY]
    samples = [r for r in read(f"issue3-{dataset}-sample-values.tsv") if r["cell"] == KEY]
    print(f"\n{dataset}: {KEY}")
    for side, seed in [("old", 8), ("new", 24)]:
        runs = sorted((r for r in totals if f"-{side}.tsv" in r["file"]), key=lambda r: r["file"])
        raw = [r for r in samples if f"-{side}.tsv" in r["file"]]
        assert len(runs) == 64 and len(raw) == 1536
        print(side, "runs", len(runs), "wall ns/B", display(rate(runs, "wall_ns")), "cycles/B", display(rate(runs, "P_cycles")), "instructions/B", display(rate(runs, "P_instructions")))
        for socket in [0, 1]:
            # The recorded topology's chosen physical CPUs are 0..23 on
            # socket 0 and 24..47 on socket 1; SMT siblings start at 48.
            assert all(0 <= int(r["cpu"]) < 48 for r in runs)
            group = [r for r in runs if int(r["cpu"]) // 24 == socket]
            assert len(group) == 32
            print(" socket", socket, "wall/cycles/Ptime ns/instructions per B:", *(display(rate(group, f)) for f in ["wall_ns", "P_cycles", "P_time_ns", "P_instructions"]))
        print(" layout seed, sample CPUs, wall ns/B, cycles/B")
        for index in range(16):
            group = runs[index::16]
            assert len(group) == 4
            print(" ", seed + index, ",".join(r["cpu"] for r in group), display(rate(group, "wall_ns")), display(rate(group, "P_cycles")))
        ordered = sorted(raw, key=lambda r: Fraction(int(r["wall_ns"]), int(r["units"])))
        tail = ordered[-((len(ordered) + 99) // 100):]
        median = statistics.median(Fraction(int(r["wall_ns"]), int(r["units"])) for r in raw)
        print(" sample median ns/call", display(median * 128), "top1% share of timed ns (%)", display(Fraction(sum(int(r["wall_ns"]) for r in tail) * 100, sum(int(r["wall_ns"]) for r in raw))))
        print(" largest samples: wall ns/call, Ptime ns/call, user cycles/call, instructions/call, CPU")
        for r in ordered[-3:]:
            print(" ", *(display(Fraction(int(r[f]) * 128, int(r["units"]))) for f in ["wall_ns", "P_time_ns", "P_cycles", "P_instructions"]), r["cpu"])
