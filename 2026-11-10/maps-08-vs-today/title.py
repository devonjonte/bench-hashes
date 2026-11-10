#!/usr/bin/env python3
"""Give a merged map its own title and a note of what it compares. usage: title.py VIEW MAP.html MACHINE-NOTE"""
import sys
view, path, note = sys.argv[1:]
T = {"core": ("BLAKE3-Servil on one thread: 0.8 beside today's", "The calls blake3-servil-core is to hold: one thread, a message, a batch, many messages in pieces, a collection, a Merkle tree."),
     "sync": ("BLAKE3-Servil's multithreaded calls: 0.8 beside today's", "The multithreaded calls that return when the work is done, whose API is settled for 0.9.")}[view]
s = open(path).read()
old_t = "How fast BLAKE3-Servil runs, beside other hashes"
assert s.count(old_t) >= 2
s = s.replace(old_t, T[0])
a = '<p class="sub">Each small chart is one measurement'
assert s.count(a) == 1
s = s.replace(a, f'<p class="sub"><b>{T[1]}</b> The streaming usages (continuous, lent, receiving) are left out. '
              f'<b>Where the lines come from:</b> the two versions of BLAKE3-Servil are the release check\'s own paired runs (four a side, fresh link layouts, one after the other, the same sample sizes): 0.8 (dark) built by bench-hashes 3363bee8, the last that builds against it, and today\'s (2037118c, purple) by bench-hashes 0.21. '
              f'The other hashes are from 0.21\'s full run. {note} '
              'That check judged every cell of the two versions: no cell slower.</p>' + a)
open(path, "w").write(s)
