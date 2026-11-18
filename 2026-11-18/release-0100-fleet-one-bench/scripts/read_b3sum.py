#!/usr/bin/env python3
"""The b3sum suite's judged cells against b3sum 0.9.0 for one run name, per host: the cold thousand-file
cell, every slower mark, and the count of marks. Reads each run's own report through page.py's readers."""
import sys
sys.path.insert(0, str(__import__('pathlib').Path(__file__).parent))
import page
run = sys.argv[1]
for h in page.HOSTS:
    p = page.INBOX / h / run / page.REPORT
    if not p.exists():
        continue
    t = p.read_text()
    m = page.marks(t, 'b3sum-0.10.0')
    _t, names, rows = page.sections(t)[1]
    cold = rows['1000 x 16 KiB'][names.index('b3sum-0.10.0')]
    old = rows['1000 x 16 KiB'][names.index('b3sum-0.9.0')]
    slower = [f"{s} {k}" for (s, k), v in m.items() if v == 'slower']
    print(f"{h:16} load {page.field(t, 'load')[:60]} | cold 1000 x 16 KiB: 0.9.0 {old.split('  ')[0]} -> {cold} | faster {sum(v == 'faster' for v in m.values())}, slower {len(slower)} {slower}")
