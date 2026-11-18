#!/usr/bin/env python3
"""Preserve the 0.10.0 candidate's one-bench release checks on the x86-64 fleet and its b3sum suite runs
(unbound on six machines, bound to one memory node on the three two-socket machines, and the Mac's):
text only, home paths redacted, both manifests."""
import hashlib, re, subprocess
from pathlib import Path

validation = Path(__file__).resolve().parent.parent
archive = Path.home() / "bench-hashes-data/2026-11-18/release-0100-fleet-one-bench"
allowed = {".txt", ".tsv", ".sh", ".py", ".md", ".json", ".log", ".svg", ".html"}
copied = []


def copy_tree(source, target):
    for path in sorted(source.rglob("*")):
        if not path.is_file() or path.suffix not in allowed:
            continue
        raw = path.read_bytes()
        if raw[:4] in (b"\x7fELF", b"\xcf\xfa\xed\xfe"):
            continue
        text = re.sub(r"/(home|Users)/[^/\s\"'<>:;]+", "$HOME", raw.decode("utf-8", "replace"))
        out = target / path.relative_to(source)
        out.parent.mkdir(parents=True, exist_ok=True)
        out.write_text(text)
        copied.append(out)


inbox = validation / "inbox"
hosts = ["x86-epyc-9275f", "x86-epyc-9255", "x86-9700x", "x86-icelake", "x86-icelake-2", "x86-avx2"]
for host in hosts:
    for run in ("release-0100-onebench", "b3sum-0100-27eacce3", "b3sum-0100-27eacce3-one-node", "release-0100-batch8192"):
        if (inbox / host / run).is_dir():
            copy_tree(inbox / host / run, archive / "runs" / host / run)
for result in sorted((Path.home() / "mac-runner/results").glob("3381-*")):
    copy_tree(result, archive / "runs/mac-m6-timing" / result.name)
for name in ("issue447/batch8192-icelake/looks.tsv", "issue447/batch8192-icelake-2/looks.tsv"):
    if (validation / name).is_file():
        out = archive / "analysis" / name.split("/")[1] / "looks.tsv"
        out.parent.mkdir(parents=True, exist_ok=True)
        out.write_text(re.sub(r"$HOME/\s\"'<>:;]+", "$HOME", (validation / name).read_text()))
        copied.append(out)
for name in ("release-010/onebench-x86.sh", "release-010/b3sum-one-node.sh", "release-010/read_b3sum.py", "release-010/page.py",
             "release-010/archive_onebench.py", "issue447-batch8192-xeon.sh", "issue3-arms-job.sh"):
    out = archive / "scripts" / Path(name).name
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(re.sub(r"$HOME/\s\"'<>:;]+", "$HOME", (validation / name).read_text()))
    copied.append(out)
files = sorted(p for p in archive.rglob("*") if p.is_file() and p.name not in ("SHA256SUMS", "BLAKE3SUMS"))
(archive / "SHA256SUMS").write_text("".join(f"{hashlib.sha256(p.read_bytes()).hexdigest()}  {p.relative_to(archive)}\n" for p in files))
(archive / "BLAKE3SUMS").write_text(subprocess.check_output(["b3sum"] + [str(p.relative_to(archive)) for p in files], text=True, cwd=archive))
print(f"{len(copied)} files copied; {len(files)} in both manifests; {archive}")
