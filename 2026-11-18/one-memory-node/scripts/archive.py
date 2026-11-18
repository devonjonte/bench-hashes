#!/usr/bin/env python3
"""Preserve the evidence for bench-hashes keeping itself to one memory node (November 18, 2026): the two
two-socket machines' runs, the workhorse's test runs, the judged identical-code comparisons and the
scripts; text only, home paths redacted, both manifests."""
import hashlib, re, subprocess
from pathlib import Path

validation = Path(__file__).resolve().parent.parent
archive = Path.home() / "bench-hashes-data/2026-11-18/one-memory-node"
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
for host, run in [("x86-avx2", "one-node-5348e0dd"), ("x86-avx2", "one-node-e25e337f"),
                  ("x86-icelake-2", "one-node-5348e0dd"), ("x86-icelake-2", "one-node-e25e337f"),
                  ("x86-workhorse", "one-node-tests-5348e0dd"), ("x86-workhorse", "one-node-tests-e25e337f")]:
    copy_tree(inbox / host / run, archive / "runs" / host / run)
for name in ("x86-avx2.looks.tsv", "x86-icelake-2.looks.tsv"):
    out = archive / "analysis" / name
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(re.sub(r"$HOME/\s\"'<>:;]+", "$HOME", (validation / "one-node/judged" / name).read_text()))
    copied.append(out)
for name in ("host-test.sh", "workhorse-tests.sh", "archive.py"):
    out = archive / "scripts" / name
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(re.sub(r"$HOME/\s\"'<>:;]+", "$HOME", (validation / "one-node" / name).read_text()))
    copied.append(out)
files = sorted(p for p in archive.rglob("*") if p.is_file() and p.name not in ("SHA256SUMS", "BLAKE3SUMS"))
(archive / "SHA256SUMS").write_text("".join(f"{hashlib.sha256(p.read_bytes()).hexdigest()}  {p.relative_to(archive)}\n" for p in files))
(archive / "BLAKE3SUMS").write_text(subprocess.check_output(["b3sum"] + [str(p.relative_to(archive)) for p in files], text=True, cwd=archive))
print(f"{len(copied)} files copied; {len(files)} in both manifests; {archive}")
