#!/usr/bin/env python3
"""Offline Project 3 (bench-hashes #210) evaluation of every kept two-stage `check` run in inbox/."""
import re, subprocess
from pathlib import Path

X = "<agent-home>/bench-pin-move/target/release/bench-hashes"
LINE = re.compile(r"^(?P<key>[^:]+\|[^:]+): (?P<old>[\d.]+) -> (?P<new>[\d.]+) ns/unit\s+x(?P<ratio>[\d.]+) (?P<label>\w+)")

def compare(folder):
    olds = sorted(map(str, folder.glob("run-*-old.tsv")))
    news = sorted(map(str, folder.glob("run-*-new.tsv")))
    if not olds or len(olds) != len(news):
        return None
    out = subprocess.run([X, "compare", *olds, "--", *news], capture_output=True, text=True).stdout
    rows = {m.group("key"): m.groupdict() for m in map(LINE.match, out.splitlines()) if m}
    return len(olds), rows

def find_stdout(kept_dir):
    # Match kept-NAME to NAME.stdout.txt or release-check.stdout.txt
    parent = kept_dir.parent
    stem = kept_dir.name.removeprefix("kept-")
    for cand in [
        parent / f"{stem}.stdout.txt",
        parent / f"{stem}-check.stdout.txt",
        parent / f"check-{stem}.stdout.txt",
        parent / "release-check.stdout.txt",
    ]:
        if cand.is_file():
            return cand
    return None

rows = []
for kept in sorted(Path("inbox").glob("*/*/kept-*")):
    if not (kept / "run-001-old.tsv").is_file():
        continue
    res1 = compare(kept)
    if not res1:
        continue
    p1, r1 = res1
    sec = kept / "second"
    has_sec = sec.is_dir() and (sec / "run-001-old.tsv").is_file()
    p2, r2 = compare(sec) if has_sec else (0, {})

    out_path = find_stdout(kept)
    suspects = set()
    verdict = "?"
    if out_path:
        lines = out_path.read_text(errors="replace").splitlines()
        for l in lines:
            if l.startswith("regress: suspects: "):
                suspects = set(l[len("regress: suspects: "):].split(";"))
                break
        for l in reversed(lines):
            if l.startswith("regress: ") and ("no cell slower" in l or "REGRESSION:" in l):
                verdict = l[len("regress: "):]
                break

    s1_slower = sum(1 for v in r1.values() if v["label"].lower() == "slower")
    s2_susp_slower = sum(1 for k, v in r2.items() if k in suspects and v["label"].lower() == "slower")
    s2_non_susp_slower = sum(1 for k, v in r2.items() if k not in suspects and v["label"].lower() == "slower")
    s2_non_susp_faster = sum(1 for k, v in r2.items() if k not in suspects and v["label"].lower() == "faster")
    host, run = kept.parts[1], kept.parts[2]
    rows.append((host, run, kept.name, p1, len(r1), s1_slower, len(suspects), p2, len(r2), s2_susp_slower, s2_non_susp_slower, s2_non_susp_faster, verdict))

print("host\trun\tkept\tp1\tc1\ts1_slow\tsuspects\tp2\tc2\ts2_susp_slow\ts2_other_slow\ts2_other_fast\tverdict")
for r in rows:
    print("\t".join(map(str, r)))
