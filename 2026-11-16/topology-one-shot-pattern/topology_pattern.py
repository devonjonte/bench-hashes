#!/usr/bin/env python3
"""Diagnostic for BLAKE3 #401: each run's samples of a cell in the order taken, marked
S where a sample exceeds 1.3 times the run's lower-quartile sample. Shows whether a
slower mean is every call or a few. A reading aid; the verdicts are the check's."""
from pathlib import Path
import sys

def patterns(folder, which, wanted):
    out = {}
    for p in sorted(Path(folder).glob(f"run-*-{which}.tsv")):
        for line in p.read_text().splitlines():
            f = line.split("\t")
            if len(f) < 11 or f[0] == "contender" or f[0].startswith("#"):
                continue
            key = "|".join(f[:4])
            if not any(w in key for w in wanted):
                continue
            w = [int(s.split("/")[0]) for s in f[5].split(",")]
            base = sorted(w)[len(w) // 4]
            slow = [x for x in w if x > 1.3 * base]
            out.setdefault(key, []).append(("".join("S" if x > 1.3 * base else "." for x in w), base, sum(slow) / len(slow) if slow else None))
    return out

if __name__ == "__main__":
    folder, wanted = sys.argv[1], sys.argv[2:]
    for which in ("old", "new"):
        for key, runs in patterns(folder, which, wanted).items():
            ratios = [s / b for _p, b, s in runs if s]
            print(f"{which} {key}: " + " ".join(p for p, _b, _s in runs) + (f"  slow/fast x{min(ratios):.2f}-x{max(ratios):.2f}" if ratios else ""))
