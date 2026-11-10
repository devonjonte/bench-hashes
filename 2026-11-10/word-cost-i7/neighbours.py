#!/usr/bin/env python3
"""The data symbols on the cache line of lanes::sources::ACTIVE*, and around it. usage: neighbours.py EXE"""
import subprocess, sys, re
out = subprocess.run(["nm", "-n", "-S", "--demangle", sys.argv[1]], capture_output=True, text=True).stdout
rows = []
for l in out.split("\n"):
    m = re.match(r"^([0-9a-f]{16}) (?:([0-9a-f]{16}) )?([bBdD]) (.*)$", l)
    if m: rows.append((int(m.group(1), 16), int(m.group(2) or "0", 16), m.group(3), m.group(4)))
i = next(k for k, r in enumerate(rows) if "sources::ACTIV" in r[3])
a = rows[i][0]; line = a // 64
print("  %s at 0x%x: line 0x%x, offset %d, size %d" % (rows[i][3][-40:], a, line * 64, a % 64, rows[i][1]))
for r in rows[max(0, i - 5):i + 6]:
    same = r[0] // 64 <= line <= (r[0] + max(r[1], 1) - 1) // 64
    print("   0x%x %6d %s %s%s" % (r[0], r[1], r[2], r[3][-72:], "   <== on ACTIVE's line" if same else ""))
