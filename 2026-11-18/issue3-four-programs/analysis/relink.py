#!/usr/bin/env python3
"""relink.py KEEP ORDER_FILE OUT: the kept link, with another order file and output."""
import json, subprocess, sys
keep, order, out = sys.argv[1:]
args = json.load(open(keep + "/link-args.json"))
i = args.index("-o")
args[i + 1] = out
hits = [k for k, a in enumerate(args) if a.startswith("-Wl,--symbol-ordering-file=")]
assert len(hits) == 1, hits
args[hits[0]] = "-Wl,--symbol-ordering-file=" + order
subprocess.run(["cc"] + args, check=True)
