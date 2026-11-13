#!/usr/bin/env python3
"""A cell's samples in time order, per run of a kept directory, in ns per sample (exploration)."""
import sys, os, re
from pred import timeline
d, target = sys.argv[1], sys.argv[2]
for p in sorted(os.listdir(d)):
    if not re.match(r'run-\d+-(old|new)\.tsv', p): continue
    cpu = None
    for line in open(os.path.join(d, p)):
        m = re.match(r'# measuring thread: pinned to CPU (\d+)', line)
        if m: cpu = m.group(1); break
        if not line.startswith('#'): break
    ev = [e for e in timeline(os.path.join(d, p)) if e[1] == target]
    print(f"{p[:11]} cpu {cpu:>3}: " + ' '.join(f"{e[2]/1000:.0f}" for e in ev))
