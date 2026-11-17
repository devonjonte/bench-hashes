#!/usr/bin/env python3
"""Process plumbing and exact displays for the predeclared executable-NUMA test.

The Rust auditor reads benchmark samples and computes run means. The normal
v10 comparison tool supplies every statistical verdict. Python reads their
exports and the execution schedule, without a second benchmark-samples parser.
"""
import argparse
import collections
import csv
from decimal import Decimal
from fractions import Fraction
from pathlib import Path
import subprocess

p = argparse.ArgumentParser()
p.add_argument("job", type=Path)
p.add_argument("output", type=Path)
p.add_argument("--auditor", type=Path, default=Path.home() / "bench-icache/target/release/bench-hashes")
p.add_argument("--reader", type=Path, default=Path.home() / "bench-pin-move/target/release/bench-hashes")
a = p.parse_args()
a.job, a.output = a.job.resolve(), a.output.resolve()
a.output.mkdir(parents=True, exist_ok=True)


def run_export(args, target):
    with target.open("w") as f:
        subprocess.run([str(a.auditor), "issue3-audit", *args, str(a.job / "kept")], stdout=f, check=True)


run_export([], a.output / "run-totals.tsv")
run_export(["--samples"], a.output / "sample-values.tsv")
with (a.output / "run-totals.tsv").open() as f:
    rows = list(csv.DictReader((l for l in f if not l.startswith("#")), delimiter="\t"))
with (a.job / "schedule.tsv").open() as f:
    schedule = list(csv.DictReader(f, delimiter="\t"))
assert len(schedule) == 32 and all(s["status"] == "0" for s in schedule), "all predeclared runs completed"
by_name = {s["run"] + ".tsv": s for s in schedule}
assert len(by_name) == len(schedule)
assert len(rows) == 320, "32 runs, the same ten cells each"
for r in rows:
    s = by_name[Path(r["file"]).name]
    assert r["cpu"] == s["cpu"], (r["file"], r["cpu"], s["cpu"])
    assert r["load"].startswith("quiet"), (r["file"], r["load"])

# Each count remains integral until its final decimal display. Ratios here
# merely describe totals; compare below owns statistical interpretation.
def decimal(n, d):
    return str(round(Decimal(n) / Decimal(d), 3))


groups = collections.defaultdict(list)
for r in rows:
    s = by_name[Path(r["file"]).name]
    groups[r["cell"], int(s["cpu"]), int(s["executable_node"])].append(r)
with (a.output / "totals-by-placement.tsv").open("w") as f:
    f.write("cell\tcpu\texecutable_node\truns\twall_ns_per_call\tcycles_per_call\tinstructions_per_call\tP_time_ns_per_call\tmedian_run_wall_ns_per_call\n")
    for (key, cpu, node), rs in sorted(groups.items()):
        assert len(rs) == 8
        length = {"64 B": 64, "128 B": 128, "256 B": 256}[key.split("|")[-1]]
        units = sum(int(r["units"]) for r in rs)
        values = [decimal(sum(int(r[k]) for r in rs) * length, units) for k in ("wall_ns", "P_cycles", "P_instructions", "P_time_ns")]
        means = sorted(Fraction(int(r["wall_ns"]) * length, int(r["units"])) for r in rs)
        median = (means[3] + means[4]) / 2
        f.write(f"{key}\t{cpu}\t{node}\t{len(rs)}\t" + "\t".join(values) + "\t" + decimal(median.numerator, median.denominator) + "\n")

# Eight back-to-back pairs per CPU, with local executable pages as old and
# remote as new. Node order alternates in the recorded schedule.
for cpu, local in [(0, 0), (24, 1)]:
    paths = {}
    for s in schedule:
        if int(s["cpu"]) == cpu:
            paths[int(s["repeat"]), int(s["executable_node"])] = str(a.job / "kept" / (s["run"] + ".tsv"))
    old = [paths[r, local] for r in range(8)]
    new = [paths[r, 1 - local] for r in range(8)]
    with (a.output / f"compare-cpu{cpu}-remote-over-local.md").open("w") as f:
        subprocess.run([str(a.reader), "compare", "--markdown", *old, "--", *new], stdout=f, check=True)
with (a.output / "reader-provenance.txt").open("w") as f:
    for executable in (a.auditor, a.reader):
        subprocess.run([str(executable), "provenance"], stdout=f, check=True)
        subprocess.run(["sha256sum", str(executable)], stdout=f, check=True)
        subprocess.run(["b3sum", str(executable)], stdout=f, check=True)
print("Read 32 quiet runs through the Rust reader; wrote two eight-pair comparisons and exact placement totals.")
