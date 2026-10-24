#!/usr/bin/env python3
"""BLAKE3 #119 on the i7: the publisher making up to W wakes itself and
owing the rest, each W's branch checked against 08ffe77 (every wake
direct) with bench-hashes check (two stages), one at a time. The line's
checkout goes back to servil after, stopped or not."""
import pathlib
import re
import signal
import subprocess
import sys

signal.signal(signal.SIGTERM, lambda *_: sys.exit(143))
line = pathlib.Path("/home/agent/BLAKE3-line")
out = pathlib.Path("/home/agent/bench-hashes-validation/wakes-sweep")
out.mkdir(exist_ok=True)
try:
    for w in sys.argv[1:]:
        subprocess.run(["git", "checkout", "-q", f"exp/wakes-{w}"], cwd=line, check=True)
        done = subprocess.run(["./target/release/bench-hashes", "check", "--against", "08ffe77", "--keep", str(out / f"w{w}-runs")],
                              cwd=line / "bench-hashes", capture_output=True, text=True)
        (out / f"w{w}.stdout.txt").write_text(done.stdout)
        (out / f"w{w}.stderr.txt").write_text(done.stderr)
        slower = re.findall(r"^\s+SLOWER (.+?): (\S+)", done.stdout, re.M)
        faster = re.findall(r"^\s+faster (.+?): (\S+)", done.stdout, re.M)
        print(f"W={w}\texit {done.returncode}\tslower: {', '.join(f'{c} {r}' for c, r in slower) or 'none'}\tfaster: {', '.join(f'{c} {r}' for c, r in faster) or 'none'}", flush=True)
finally:
    subprocess.run(["git", "checkout", "-q", "servil"], cwd=line)
