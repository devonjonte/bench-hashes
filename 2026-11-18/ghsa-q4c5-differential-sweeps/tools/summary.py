#!/usr/bin/env python3
"""Every length-sweep delivery in the inbox: per run, pool sizes run, checks made, and wrong hashes."""
import re
from pathlib import Path
INBOX = Path('<home>/bench-hashes-validation/inbox')
total = [0, 0]
for d in sorted(INBOX.glob('*/length-sweep*')):
    out = (d / 'stdout.txt').read_text() if (d / 'stdout.txt').exists() else ''
    if 'SWEEP_EXIT' not in out:
        print(f'{d.parent.name:15} {d.name:26} not delivered'); continue
    exit_ = re.search(r'SWEEP_EXIT=(\d+)', out).group(1)
    sizes = checks = wrong = 0
    for f in d.glob('sweep-*.txt'):
        sizes += 1
        for m in re.finditer(r': (\d+) lengths, (\d+) wrong', f.read_text()):
            checks += int(m.group(1)); wrong += int(m.group(2))
    total[0] += checks; total[1] += wrong
    print(f'{d.parent.name:15} {d.name:26} exit {exit_}  pool sizes {sizes:2}  checks {checks:>10,}  wrong {wrong}')
print(f'in all: {total[0]:,} checks, {total[1]} wrong')
