#!/usr/bin/env python3
"""Shortcut A/Bs on the i7 (Zooko, October 24; measurements only): each
branch ab/NAME is the line (08ffe77) with one shortcut off, checked
against 08ffe77 with bench-hashes check (two stages), one at a time. The
line's checkout goes back to servil after, stopped or not."""
import pathlib
import re
import signal
import subprocess
import sys

signal.signal(signal.SIGTERM, lambda *_: sys.exit(143))
line = pathlib.Path("/home/agent/BLAKE3-line")
out = pathlib.Path("/home/agent/bench-hashes-validation/ab-sweep")
out.mkdir(exist_ok=True)
try:
    for w in sys.argv[1:]:
        subprocess.run(["git", "checkout", "-q", f"ab/{w}"], cwd=line, check=True)
        done = subprocess.run(["./target/release/bench-hashes", "check", "--against", "08ffe77", "--keep", str(out / f"{w}-runs")],
                              cwd=line / "bench-hashes", capture_output=True, text=True)
        (out / f"{w}.stdout.txt").write_text(done.stdout)
        (out / f"{w}.stderr.txt").write_text(done.stderr)
        slower = re.findall(r"^\s+SLOWER (.+?): (\S+)", done.stdout, re.M)
        faster = re.findall(r"^\s+faster (.+?): (\S+)", done.stdout, re.M)
        print(f"{w}\texit {done.returncode}\tslower: {', '.join(f'{c} {r}' for c, r in slower) or 'none'}\tfaster: {', '.join(f'{c} {r}' for c, r in faster) or 'none'}", flush=True)
finally:
    subprocess.run(["git", "checkout", "-q", "servil"], cwd=line)
