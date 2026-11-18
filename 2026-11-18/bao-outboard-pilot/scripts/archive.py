#!/usr/bin/env python3
"""Preserve the pilots of b3sum's end-to-end outboard cells (bench-hashes #237): the two five-round runs
on the EPYC 9275F, the workhorse's test run, the reader and the scripts; text only, home paths redacted,
both manifests."""
import hashlib, re, subprocess
from pathlib import Path

validation = Path(__file__).resolve().parent.parent
archive = Path.home() / "bench-hashes-data/2026-11-18/bao-outboard-pilot"
allowed = {".txt", ".tsv", ".sh", ".py", ".md", ".json", ".log"}
copied = []


def copy_tree(source, target):
    for path in sorted(source.rglob("*")):
        if not path.is_file() or path.suffix not in allowed:
            continue
        raw = path.read_bytes()
        if raw[:4] == b"\x7fELF" or raw[:4] == b"\xcf\xfa\xed\xfe":
            continue
        text = re.sub(r"/(home|Users)/[^/\s\"'<>:;]+", "$HOME", raw.decode("utf-8", "replace"))
        out = target / path.relative_to(source)
        out.parent.mkdir(parents=True, exist_ok=True)
        out.write_text(text)
        copied.append(out)


inbox = validation / "inbox"
for host, run in [("x86-epyc-9275f", "bao-outboard-gate-4b968d88"), ("x86-epyc-9275f", "bao-outboard-pilot-5de0629e"),
                  ("x86-workhorse", "outboard-tests-5de0629e")]:
    copy_tree(inbox / host / run, archive / "runs" / host / run)
for name in ("pilot.sh", "pilot2.sh", "read_pilot.py", "workhorse-tests.sh", "archive.py"):
    out = archive / "scripts" / name
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(re.sub(r"$HOME/\s\"'<>:;]+", "$HOME", (validation / "bao-outboard-gate" / name).read_text()))
    copied.append(out)
files = sorted(p for p in archive.rglob("*") if p.is_file() and p.name not in ("SHA256SUMS", "BLAKE3SUMS"))
(archive / "SHA256SUMS").write_text("".join(f"{hashlib.sha256(p.read_bytes()).hexdigest()}  {p.relative_to(archive)}\n" for p in files))
(archive / "BLAKE3SUMS").write_text(subprocess.check_output(["b3sum"] + [str(p.relative_to(archive)) for p in files], text=True, cwd=archive))
print(f"{len(copied)} files copied; {len(files)} in both manifests; {archive}")
