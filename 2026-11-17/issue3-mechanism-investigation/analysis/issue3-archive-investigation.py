#!/usr/bin/env python3
"""Preserve completed #3 diagnostic deliveries, text only and home-redacted."""
import hashlib
from pathlib import Path
import re
import subprocess

validation = Path(__file__).resolve().parent
inbox = validation / "inbox"
archive = Path.home() / "bench-hashes-data/2026-11-17/issue3-mechanism-investigation"
archive.mkdir(parents=True, exist_ok=True)
completed = set(re.findall(r" done (\S+) (\S+)\n", (inbox / "DONE.txt").read_text()))
prefixes = ("issue3-frontend", "issue3-probe", "issue3-icache", "issue3-fixed-context", "issue3-executable-numa", "issue3-faithful", "issue3-directcall")
allowed = {".txt", ".tsv", ".sh", ".rs", ".toml", ".lock", ".log", ".json", ".py", ".md", ".csv", ".patch"}
binaries = []
copied = []


def redact(text):
    return re.sub(r"$HOME/\s\"'<>:;]+", "$HOME", text)


def copy_text(source, target, *, immutable=False):
    raw = source.read_bytes()
    if raw[:4] == b"\x7fELF":
        digest = subprocess.check_output(["b3sum", str(source)], text=True).split()[0]
        binaries.append((str(source.relative_to(inbox)), len(raw), hashlib.sha256(raw).hexdigest(), digest))
        return
    if source.suffix not in allowed and source.name != "Cargo.lock":
        return
    text = redact(raw.decode("utf-8"))
    target.parent.mkdir(parents=True, exist_ok=True)
    if immutable and target.exists():
        assert target.read_text() == text, f"a preserved raw delivery changed: {target}"
    else:
        # Analysis code evolves in git; the original measurement records
        # above remain immutable. History preserves each tool version.
        target.write_text(text)
    copied.append(target)


jobs = []
for host, name in sorted(completed):
    if not name.startswith(prefixes):
        continue
    source = inbox / host / name
    assert source.is_dir(), source
    jobs.append((host, name))
    for path in sorted(source.rglob("*")):
        if path.is_file():
            copy_text(path, archive / "runs" / host / name / path.relative_to(source), immutable=True)

(archive / "jobs.tsv").write_text("host\trun\n" + "".join(f"{h}\t{n}\n" for h, n in jobs))
(archive / "excluded-executable-identities.tsv").write_text(
    "inbox_path\tbytes\tSHA-256\tBLAKE3\n" + "".join("\t".join(map(str, row)) + "\n" for row in binaries)
)

local = [
    "issue3-fixed-context.sh", "issue3-executable-numa.sh", "issue3-faithful-job.sh",
    "issue3-faithful-portable-job.sh", "issue3-faithful96-job.sh", "issue3-directcall-job.sh",
    "issue3-hash-files-core.rs", "issue3-faithful96-cpu-control.tsv", "issue3-faithful-short-rejection.txt",
    "issue3-analyse-numa.py", "issue3-recheck-exports.py", "issue3-archive-investigation.py",
    "issue3-offline-recheck.txt", "issue3-socket-and-tail-recheck.txt", "issue3-fixed-context3-summary.txt",
    "issue3-rechecked-exploration.txt",
    "issue3-original-run-totals.tsv", "issue3-original-sample-values.tsv",
    "issue3-icache2-run-totals.tsv", "issue3-icache2-sample-values.tsv",
    "issue3-fixed-context3-run-totals.tsv", "issue3-fixed-context3-sample-values.tsv",
    "issue3-correction-20261117.md", "issue402-correction-20261117.md",
    "issue3-audit-build.stderr.txt", "issue3-audit-build-supervisor.txt",
    "issue3-audit-tests.stderr.txt", "issue3-audit-tests-supervisor.txt",
    "issue3-faithful-build.stderr.txt", "issue3-faithful-build2.stderr.txt",
    "issue3-branch-counter-wip-20261117.patch",
]
for name in local:
    path = validation / name
    assert path.is_file(), path
    copy_text(path, archive / "analysis" / name)
for name in ["Cargo.toml", "Cargo.lock", "src/main.rs"]:
    copy_text(validation / "issue3-faithful-probe" / name, archive / "source" / "faithful-probe" / name)
copy_text(Path.home() / "bench-icache/src/issue3_audit.rs", archive / "source/issue3_audit.rs")
for name in ["Cargo.toml", "Cargo.lock", "src/main.rs", "src/bin/compare.rs"]:
    copy_text(validation / "issue3-directcall/source" / name, archive / "source/directcall-study" / name)
for name in ["patch_calls.py", "local-manifest.json", "local-direct-disassembly.txt"]:
    copy_text(validation / "issue3-directcall" / name, archive / "source/directcall-study" / name)
for name in ["issue3-directcall-reader-tests.stderr.txt", "issue3-directcall-reader-tests-supervisor.txt"]:
    copy_text(validation / name, archive / "analysis" / name)
for name in ["issue3-faithful96-avx2-cpu-control.tsv"]:  # the working notes stay local: they quote private conversation
    copy_text(validation / name, archive / "analysis" / name)
for path in sorted((validation / "issue3-numa-analysis").iterdir()):
    if path.is_file():
        copy_text(path, archive / "analysis/numa-analysis" / path.name)

print(f"Preserved {len(jobs)} completed jobs and {len(copied)} text artifacts; excluded {len(binaries)} executables with both hashes retained.")
print(archive)
