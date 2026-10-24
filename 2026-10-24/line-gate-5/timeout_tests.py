#!/usr/bin/env python3
"""For each mutant whose every failing test was stopped by the clock (a
time-out: check.py's rule), the tests nextest stopped and those that
failed outright, from its log:  python3 timeout_tests.py RUN_DIR [SUBSTRING]"""
import json
import pathlib
import re
import sys

root = pathlib.Path(sys.argv[1])
want = sys.argv[2] if len(sys.argv) > 2 else ""
line = re.compile(r"^\s*(PASS|FAIL|TIMEOUT|SIGABRT|SIGSEGV|ABORT)\s+\[\s*([\d.]+)s\]\s+(?:\([^)]*\)\s+)?(\S+)\s+(\S+)", re.M)
for shard in sorted(root.glob("shard*")):
    for o in json.loads((shard / "outcomes.json").read_text())["outcomes"]:
        mutant = o["scenario"].get("Mutant") if isinstance(o["scenario"], dict) else None
        if not mutant or o["summary"] != "CaughtMutant" or want not in mutant["name"]:
            continue
        results = line.findall((shard / o["log_path"]).read_text(errors="replace"))
        bad = [(s, t) for s, _, _, t in results if s != "PASS"]
        if bad and all(s == "TIMEOUT" for s, _ in bad):
            print(f"{mutant['name']}\n    stopped: {', '.join(sorted({t for _, t in bad}))}")
