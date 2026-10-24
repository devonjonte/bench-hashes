#!/usr/bin/env python3
"""bench-hashes #69 on the i7-12700K: solo ManyMessages (servil st, 64 and
256 messages) one mean a process, 32 processes per placement, with the
bench's buffers aligned to 64 (Sam Shackleton's diag-align64 build, so
#65's windows are absent): unpinned; one P core; two P cores; one P
core's two hyperthreads; a P core and an E core; one E core."""
import pathlib
import statistics
import subprocess
import sys

sys.path.insert(0, "/home/agent/BLAKE3-offset-check/tools")
from offset_check import parse_report  # noqa: E402

here = pathlib.Path(__file__).resolve().parent
EXE = here.parent / "placement-i7" / "bench-diag-align64"
PLACES = {"unpinned": None, "one P (0)": "0", "two P cores (0,2)": "0,2", "one P's two threads (0,1)": "0,1",
          "P and E (0,16)": "0,16", "one E (16)": "16"}
PROCESSES = 32
for name, cpus in PLACES.items():
    means = {"64": [], "256": []}
    for i in range(PROCESSES):
        out = here / "runs" / name.split(" ")[0].replace("(", "") / f"{cpus or 'all'}-{i}"
        out.mkdir(parents=True, exist_ok=True)
        cmd = [str(EXE), "--contenders", "blake3-servil-st", "--points", "64,256", "--for-regression-check", "--rounds", "24"]
        if cpus:
            cmd = ["taskset", "-c", cpus] + cmd
        subprocess.run(cmd, cwd=out, check=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        report = parse_report(next(out.glob("benchmark-results/*/bench-hashes.result.txt")).read_text())
        for (scenario, _, size), v in report.items():
            if scenario == "solo":
                means[size].append(v)
    for size, vs in means.items():
        vs.sort()
        print(f"{name}\t{size}\tmin {vs[0]:.1f}\tmedian {statistics.median(vs):.1f}\tmax {vs[-1]:.1f}\tmax/min {vs[-1] / vs[0]:.2f}\t{' '.join(f'{v:.1f}' for v in vs)}", flush=True)
