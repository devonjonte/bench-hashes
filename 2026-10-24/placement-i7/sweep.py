#!/usr/bin/env python3
"""Sam Shackleton's buffer-placement axis (bench-hashes #65) on the
i7-12700K. Each build places the bench's buffers of 64 bytes or more at
one offset into a cache line (her allocator options, alloc-applied.diff:
default glibc, align64, line16/32/48). For each, the duo threads' stack
through one page in 16-byte steps (glibc.rtld.optional_static_tls), lent
64 B and 256 B, solo and shared, P cores; then each cell's ten worst
offsets rescanned twice. An offset is slow when the lowest of its three
readings is 8% or more above the cell's median."""
import pathlib
import statistics
import subprocess
import sys

sys.path.insert(0, "/home/agent/BLAKE3-offset-check/tools")
from offset_check import parse_report  # noqa: E402

here = pathlib.Path(__file__).resolve().parent
BUILDS = sys.argv[1:] or ["default", "diag-align64", "line16", "line32", "line48"]
OFFSETS = range(448, 4545, 16)
SLOW = 1.08


def run(build, tls, label):
    out = here / "runs" / build / label / str(tls)
    out.mkdir(parents=True, exist_ok=True)
    env = {"PATH": "/usr/bin:/bin", "HOME": "/home/agent", "GLIBC_TUNABLES": f"glibc.rtld.optional_static_tls={tls}"}
    subprocess.run(["taskset", "-c", "0-15", str(here / f"bench-{build}"), "--contenders", "blake3-servil-st",
                    "--points", "lent 64 B,lent 256 B", "--for-regression-check", "--rounds", "96"],
                   cwd=out, env=env, check=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    report = next(out.glob("benchmark-results/*/bench-hashes.result.txt"))
    return {f"{k[0]} {k[2]}": v for k, v in parse_report(report.read_text()).items()}


for build in BUILDS:
    scan = {tls: run(build, tls, "scan") for tls in OFFSETS}
    cells = sorted(next(iter(scan.values())))
    for cell in cells:
        reads = {tls: scan[tls][cell] for tls in OFFSETS}
        median = statistics.median(reads.values())
        worst = sorted(reads, key=reads.get, reverse=True)[:10]
        lowest = {}
        for tls in worst:
            again = [run(build, tls, f"rescan{i}")[cell] for i in (1, 2)]
            lowest[tls] = min([reads[tls]] + again)
        slow = sorted(t for t, v in lowest.items() if v >= SLOW * median)
        top = max(lowest, key=lowest.get)
        print(f"{build}\t{cell}\tmedian {median:.3f}\tslow {len(slow)}: {' '.join(map(str, slow)) or '-'}\tworst {lowest[top] / median:.2f}x at {top}", flush=True)
