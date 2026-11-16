#!/usr/bin/env python3
"""Add the by-name repeats and the dedicated Mac's jobs to data 2026-11-16/release-023/."""
from pathlib import Path
import re
ROOT = Path("/home/agent")
D = ROOT / "bench-hashes-data/2026-11-16/release-023"
INBOX = ROOT / "bench-hashes-validation/inbox"
def copy(src, dst, home):
    for p in src.rglob("*"):
        if p.is_file():
            q = dst / p.relative_to(src); q.parent.mkdir(parents=True, exist_ok=True)
            data = p.read_bytes()
            q.write_bytes(data if p.suffix in {".html", ".svg"} or (p.suffix == ".tsv" and home is None) else re.sub(home or rb"/home/devon", b"<worker-home>" if home is None else b"<runner-home>", data))
added = []
for h in ["x86-icelake", "x86-icelake-2", "x86-9700x", "x86-avx2"]:
    for run in ["slower-cells-023-rest", "slower-cells-023-turn"]:
        if (INBOX / h / run / "verdict.txt").exists():
            copy(INBOX / h / run, D / h / run, None); added.append(f"{h}/{run}")
for src in sorted((ROOT / "mac-runner/results").glob("32[01][0-9]-*-mac-m6-timing")):
    if (src / "complete.json").exists():
        copy(src, D / "mac-m6-timing" / src.name, rb"/Users/[A-Za-z0-9_.-]+"); added.append(src.name)
for name in ["slower-cells-rest.sh.in", "slower-cells-turn.sh", "archive-more.py"]:
    (D / name).write_bytes((ROOT / "bench-hashes-validation/release-023-finish" / name).read_bytes())
print("\n".join(added))
