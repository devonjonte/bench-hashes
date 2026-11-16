#!/usr/bin/env python3
"""Read the 0.23 fleet deliveries: verdict lines, commit names, load lines.

    python3 collect-023.py            # summary to stdout
    python3 collect-023.py --records DEST   # also copy benchmark-results folders

Reads local inbox deliveries only. The records copy keeps every byte of each
machine's benchmark-results; reports/maps are the run's own files.
"""
from pathlib import Path
import re
import shutil
import sys

INBOX = Path("/home/agent/bench-hashes-validation/inbox")
HOSTS = ["x86-epyc-9275f", "x86-epyc-9255", "x86-9700x", "x86-icelake", "x86-icelake-2", "x86-avx2"]
RUN = "release-023-cade30fd"
VERSION = "0.23.0+ba147639c35454e648847adbb08e2435e450493e"
NEW = "7048303103c69b8609ffe9ca0361197ba318107c"

def head(text, pattern):
    m = re.search(pattern, text, re.M)
    return m.group(0) if m else None

records = Path(sys.argv[sys.argv.index("--records") + 1]) if "--records" in sys.argv else None
for host in HOSTS:
    base = INBOX / host / RUN
    print(f"== {host}")
    if not base.exists():
        print("  awaited")
        continue
    final = (base / "stdout.txt").read_text() if (base / "stdout.txt").exists() else ""
    print(" ", head(final, r"RELEASE_023_EXIT=\S+ UTC=\S+") or "running or lost")
    for name, label in [("release-check", "release"), ("control-check", "control")]:
        p = base / f"{name}.stdout.txt"
        if not p.exists():
            print(f"  {label}: no output yet")
            continue
        text = p.read_text()
        slower = re.findall(r"^\s*slower .*$", text, re.M)
        faster = re.findall(r"^\s*faster .*$", text, re.M)
        print(f"  {label}: {len(faster)} faster, {len(slower)} slower; "
              f"{head(text, r'regress: no cell slower') or 'READ THE SLOWER LINES'}")
        for line in slower:
            print("   ", line.strip())
        moved = head(text, r"^.*instructions moved.*$")
        if label == "control":
            print(f"  control instructions: {moved or 'no line (counts absent?)'}")
        sides = re.findall(r"^(?:regress|compare): (?:old|new) side: .*$", text, re.M)
        for s in sides[:2]:
            print("   ", s)
    for folder in sorted((base / "benchmark-results").iterdir()) if (base / "benchmark-results").exists() else []:
        samples = folder / "bench-hashes.samples.tsv"
        if samples.exists():
            text = samples.read_text()
            for key in ["bench-hashes version", "blake3-servil version", "load", "power"]:
                line = head(text, rf"^# {re.escape(key)}: .*$")
                print("   ", line)
            assert f"# bench-hashes version: {VERSION}" in text, "the report names the meant bench"
            assert NEW in text, "the report names the meant library"
    if records and (base / "benchmark-results").exists():
        for folder in (base / "benchmark-results").iterdir():
            dest = records / folder.name
            assert not dest.exists(), f"{dest} already holds a folder"
            shutil.copytree(folder, dest)
            print(f"  copied {folder.name}")
print("Mac results arrive in /home/agent/mac-runner/results (jobs 3205-3209); pull first.")
