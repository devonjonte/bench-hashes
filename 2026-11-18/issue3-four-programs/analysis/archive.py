#!/usr/bin/env python3
"""Preserve the four-program experiment (bench-hashes #3, November 18): the six deliveries as they came
(text only, home paths redacted), the job, the judging tools and their output, and both manifests."""
import hashlib, re, subprocess, sys
from pathlib import Path

validation = Path(__file__).resolve().parent.parent
inbox = validation / "inbox"
archive = Path.home() / "bench-hashes-data/2026-11-18/issue3-four-programs"
allowed = {".txt", ".tsv", ".sh", ".py", ".md", ".diff", ".json"}
excluded, copied = [], []


def redact(text):
    return re.sub(r"$HOME/\s\"'<>:;]+", "$HOME", text)


def copy_text(source, target, immutable=False):
    raw = source.read_bytes()
    if raw[:4] == b"\x7fELF" or source.suffix not in allowed:
        if raw[:4] == b"\x7fELF":
            b3 = subprocess.check_output(["b3sum", str(source)], text=True).split()[0]
            excluded.append((str(source.relative_to(validation)), len(raw), hashlib.sha256(raw).hexdigest(), b3))
        return
    text = redact(raw.decode("utf-8"))
    target.parent.mkdir(parents=True, exist_ok=True)
    if immutable and target.exists():
        assert target.read_text() == text, f"a preserved delivery changed: {target}"
    else:
        target.write_text(text)
    copied.append(target)


runs = []
wanted = ("issue3-arms-", "issue3-plant25", "issue3-control2", "issue3-tailored2", "release-0100-onebench")
for host in ["x86-9700x", "x86-epyc-9255", "x86-avx2", "arm-vm"]:
    for run in sorted(p.name for p in (inbox / host).iterdir() if p.is_dir() and p.name.startswith(wanted)):
        source = inbox / host / run
        if not ((source / "progress.txt").is_file() or (source / "exit.txt").is_file() or (source / "stdout.txt").is_file()):
            continue
        runs.append((host, run))
        for path in sorted(source.rglob("*")):
            if path.is_file() and not path.name.startswith("."):
                copy_text(path, archive / "runs" / host / run / path.relative_to(source), immutable=True)
mac = Path.home() / "mac-runner"
for result in sorted((mac / "results").glob("3370-release-0.10.0-onebench.*")):
    runs.append(("mac-m6-timing", result.name))
    for path in sorted(result.rglob("*")):
        if path.is_file():
            copy_text(path, archive / "runs/mac-m6-timing" / result.name / path.relative_to(result), immutable=True)
    copy_text(mac / "jobs/3370-release-0.10.0-onebench.json", archive / "runs/mac-m6-timing" / result.name / "job.json")
(archive / "runs.tsv").write_text("host\trun\n" + "".join(f"{h}\t{r}\n" for h, r in runs))
for name in ["issue3-arms-job.sh", "issue3-arms/judge.sh", "issue3-arms/show.py", "issue3-arms/archive.py",
             "issue3-arms/looks.tsv", "issue3-arms/judged.tsv", "issue3-arms/kept64-looks.tsv", "issue3-arms/submitted.txt",
             "issue3-arms/shown.txt", "issue3-arms/shown-cells.txt", "issue447-onebench-arm.sh", "issue3-plant-job.sh", "issue3-relink-proof/linkwrap.py", "issue3-relink-proof/relink.py",
             "issue3-relink-proof/proof.sh", "issue3-relink-proof.stdout.txt"]:
    path = validation / name
    if path.is_file():
        copy_text(path, archive / "analysis" / Path(name).name)
    else:
        print("absent:", name, file=sys.stderr)
copy_text(Path.home() / "bench-icache/src/issue3_audit.rs", archive / "analysis/issue3_audit.rs")
(archive / "excluded-executable-identities.tsv").write_text(
    "path\tbytes\tSHA-256\tBLAKE3\n" + "".join("\t".join(map(str, row)) + "\n" for row in excluded))
files = sorted(p for p in archive.rglob("*") if p.is_file() and p.name not in ("SHA256SUMS", "BLAKE3SUMS"))
(archive / "SHA256SUMS").write_text("".join(f"{hashlib.sha256(p.read_bytes()).hexdigest()}  {p.relative_to(archive)}\n" for p in files))
b3 = subprocess.check_output(["b3sum"] + [str(p.relative_to(archive)) for p in files], text=True, cwd=archive)
(archive / "BLAKE3SUMS").write_text(b3)
print(f"preserved {len(runs)} deliveries, {len(copied)} text files, {len(excluded)} executables excluded; {len(files)} files in both manifests")
print(archive)
