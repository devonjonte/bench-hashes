#!/usr/bin/env python3
"""Assemble data/2026-11-16/topology-one-shot-pattern/: the schedule experiment's
deliveries, the pattern tools and their output over every kept run."""
from pathlib import Path
import shutil, subprocess, sys
INBOX = Path("/home/agent/bench-hashes-validation/inbox")
OUT = Path("/home/agent/bench-hashes-data/2026-11-16/topology-one-shot-pattern")
HERE = Path(__file__).parent
CELLS = ["mt|solo|OneMessage|32 MiB", "mt|solo|OneMessage|64 MiB", "mt|solo|OneMessage|128 MiB", "mt|solo|IdleOneMessage|32 MiB", "mt|solo|IdleOneMessage|128 MiB",
         "mt|solo|BriefIdleOneMessage|32 MiB", "mt|solo|BriefIdleOneMessage|128 MiB", "mt|shared-one-cache|LentMessages|64 MiB"]

def pattern(folder):
    return subprocess.run([sys.executable, str(HERE / "topology_pattern.py"), str(folder), *CELLS], capture_output=True, text=True, check=True).stdout

hosts = [h for h in ("x86-epyc-9275f", "x86-epyc-9255") if (INBOX / h / "topology-history-401/arms.txt").exists()]
OUT.mkdir(parents=True, exist_ok=True)
report = []
for h in ("x86-epyc-9275f", "x86-epyc-9255"):
    report.append(f"== {h}: the release's repeat by name, fourteen points (release-023/{h}/slower-cells-023-v2/kept-topology)\n" + pattern(INBOX / h / "slower-cells-023-v2/kept-topology"))
for h in hosts:
    src = INBOX / h / "topology-history-401"
    for p in src.rglob("*"):
        if p.is_file():
            q = OUT / h / p.relative_to(src); q.parent.mkdir(parents=True, exist_ok=True)
            q.write_bytes(p.read_bytes() if p.suffix == ".tsv" else p.read_bytes().replace(b"/home/devon", b"<worker-home>"))
    for arm in ("alone", "large", "mixed"):
        report.append(f"== {h}: schedule '{arm}' ({(src / 'arms.txt').read_text().splitlines()[['alone', 'large', 'mixed'].index(arm)]})\n" + pattern(src / f"kept-{arm}"))
long = INBOX / "x86-epyc-9275f/topology-long-401"
if long.is_dir():
    for q in long.rglob("*"):
        if q.is_file():
            t = OUT / "x86-epyc-9275f/topology-long-401" / q.relative_to(long); t.parent.mkdir(parents=True, exist_ok=True)
            t.write_bytes(q.read_bytes() if q.suffix == ".tsv" else q.read_bytes().replace(b"/home/devon", b"<worker-home>"))
    lines = ["== x86-epyc-9275f: one plain run per commit, 128 MiB alone, the cell's 24 samples spread over 96 or 960 rounds (topology-long-401)"]
    for name in ("old-96", "new-96", "old-960", "new-960"):
        for line in (long / f"run-{name}.samples.tsv").read_text().splitlines():
            f = line.split("\t")
            if f[:4] == ["blake3-servil-mt", "solo", "OneMessage", "128 MiB"]:
                w = [int(x.split("/")[0]) for x in f[5].split(",")]
                base = sorted(w)[len(w) // 4]
                lines.append(f"{name} rounds: " + "".join("S" if x > 1.3 * base else "." for x in w))
    report.append("\n".join(lines) + "\n")
(OUT / "patterns.txt").write_text("\n".join(report))
for name in ("topology-history.sh", "topology_pattern.py", "topology_caller.py", "topology_publish.py"):
    shutil.copyfile(HERE / name, OUT / name)
print(hosts, len(report))
