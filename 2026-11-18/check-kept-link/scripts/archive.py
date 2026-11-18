#!/usr/bin/env python3
"""Preserve the evidence for `check` linking its layouts from one kept link (November 18, 2026): the local
smoke, the host probes, the workhorse's test runs, the Mac's jobs, and the scripts; text only, home paths
redacted, both manifests."""
import hashlib, re, subprocess
from pathlib import Path

validation = Path(__file__).resolve().parent.parent
archive = Path.home() / "bench-hashes-data/2026-11-18/check-kept-link"
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
for host, run in [("x86-9700x", "relink-probe-bfa51544"), ("arm-vm", "relink-probe-bfa51544"), ("x86-9700x", "check-next-plant8"),
                  ("x86-workhorse", "relink-tests-61ad1c8a"), ("x86-workhorse", "relink-tests-e04c950e"),
                  ("x86-workhorse", "relink-tests-bfa51544"), ("x86-workhorse", "relink-tests-41e00496"),
                  ("x86-workhorse", "relink-tests-8e11ced7")]:
    copy_tree(inbox / host / run, archive / "runs" / host / run)
mac = Path.home() / "mac-runner"
for number in ("3376", "3377", "3378", "3379"):
    for result in sorted((mac / "results").glob(f"{number}-*")):
        copy_tree(result, archive / "runs/mac-m6-timing" / result.name)
    for job in sorted((mac / "jobs").glob(f"{number}-*.json")):
        copy_tree(job.parent, archive / "runs/mac-m6-timing/jobs") if False else None
        out = archive / "runs/mac-m6-timing/jobs" / job.name
        out.parent.mkdir(parents=True, exist_ok=True)
        out.write_text(job.read_text())
        copied.append(out)
copy_tree(validation / "relink-in-check/out", archive / "local-smoke")
for name in ("smoke.sh", "host-probe.sh", "workhorse-tests.sh", "full-check-plant.sh", "archive.py"):
    out = archive / "scripts" / name
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(re.sub(r"$HOME/\s\"'<>:;]+", "$HOME", (validation / "relink-in-check" / name).read_text()))
    copied.append(out)
files = sorted(p for p in archive.rglob("*") if p.is_file() and p.name not in ("SHA256SUMS", "BLAKE3SUMS"))
(archive / "SHA256SUMS").write_text("".join(f"{hashlib.sha256(p.read_bytes()).hexdigest()}  {p.relative_to(archive)}\n" for p in files))
(archive / "BLAKE3SUMS").write_text(subprocess.check_output(["b3sum"] + [str(p.relative_to(archive)) for p in files], text=True, cwd=archive))
print(f"{len(copied)} files copied; {len(files)} in both manifests; {archive}")
