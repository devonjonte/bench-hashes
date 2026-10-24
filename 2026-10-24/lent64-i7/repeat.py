#!/usr/bin/env python3
"""Repeats of the patched offset_check.py: five on the servil 2e892e1 build
the tool makes, three on the 0.17 release build (servil 082afa3). One
line each: build, repeat, exit, the cells judged offset-sensitive."""
import pathlib
import re
import subprocess
import time

here = pathlib.Path(__file__).resolve().parent
tool = pathlib.Path("/home/agent/BLAKE3-offset-check/tools/offset_check.py")
builds = [("2e892e1", "/home/agent/BLAKE3-offset-check/target/build-against/release/bench-hashes", 5),
          ("082afa3", str(here / "bench-hashes-082afa3"), 3)]
for name, exe, count in builds:
    for i in range(1, count + 1):
        keep = here / f"repeat-{name}-{i}"
        start = time.monotonic()
        done = subprocess.run(["python3", str(tool), "--exe", exe, "--keep", str(keep)], capture_output=True, text=True)
        (keep / "stdout.txt").write_text(done.stdout)
        (keep / "stderr.txt").write_text(done.stderr)
        cells = re.findall(r"^offset-sensitive: (\S+) \(slower at (.*)\)$", done.stdout, re.M)
        print(f"{name}\t{i}\texit {done.returncode}\t{time.monotonic() - start:.0f} s\t" + "; ".join(f"{c} at {w}" for c, w in cells), flush=True)
