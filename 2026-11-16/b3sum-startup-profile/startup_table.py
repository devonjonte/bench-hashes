#!/usr/bin/env python3
"""The startup profile's table: per host and program, perf stat's figures for one run on a
4 KiB file (300 runs each), copied from perf's own output."""
from pathlib import Path
import re, sys
INBOX = Path("/home/agent/bench-hashes-validation/inbox")

def perf(path):
    t = Path(path).read_text()
    def num(name):
        m = re.search(r"([\d,.]+)\s+" + re.escape(name), t)
        return m.group(1).replace(",", "") if m else "?"
    m = re.search(r"([\d.]+) \+- ([\d.]+) seconds time elapsed", t)
    return {"elapsed": float(m.group(1)) * 1e6, "sd": float(m.group(2)) * 1e6, "instructions": int(num("instructions:u")), "faults": int(num("page-faults:u"))}

def loop(host):
    out = {}
    for line in (INBOX / host / "startup-010/loop-us.tsv").read_text().splitlines():
        name, us = line.split("\t")
        out.setdefault(name.rsplit(" round", 1)[0], []).append(int(us))
    return out

for host in sys.argv[1:]:
    d = INBOX / host / "startup-010"
    loops = loop(host)
    true = perf(d / "true.perf.txt")
    print(f"**`{host}`**\n")
    print("| program | time per run (perf stat, 300 runs) | over `/bin/true` | user instructions | page faults | program file | system calls | threads started | per run in a shell loop |\n|---|---:|---:|---:|---:|---:|---:|---:|---:|")
    print(f"| `/bin/true` | {true['elapsed']:.0f} ± {true['sd']:.0f} μs | | {true['instructions']:,} | {true['faults']} | | | | {loops['true'][0]} μs |")
    for v in ["0.8.0", "0.9.0", "0.10-candidate", "official"]:
        p = perf(d / v / "perf-4k.txt")
        size = re.search(r"bytes (\d+)", (d / v / "elf.txt").read_text()).group(1)
        counts = (d / v / "strace-counts-4k.txt").read_text()
        calls = next(l.split()[3] for l in counts.splitlines() if l.strip().endswith("total"))
        threads = next((l.split()[3] for l in counts.splitlines() if l.split()[-1:] == ["clone3"]), "0")
        name = "official b3sum 1.8.7" if v == "official" else f"b3sum {v}"
        print(f"| {name} | {p['elapsed']:.0f} ± {p['sd']:.0f} μs | +{p['elapsed'] - true['elapsed']:.0f} μs | {p['instructions']:,} | {p['faults']} | {int(size)/1e6:.2f} MB | {calls} | {threads} | {' and '.join(map(str, loops[v + ' 4k']))} μs |")
    one = perf(d / "official/perf-4k-one-thread.txt")
    print(f"| official b3sum 1.8.7, `--num-threads 1` | {one['elapsed']:.0f} ± {one['sd']:.0f} μs | +{one['elapsed'] - true['elapsed']:.0f} μs | {one['instructions']:,} | {one['faults']} | | | | {' and '.join(map(str, loops['official 4k one-thread']))} μs |")
    print()
