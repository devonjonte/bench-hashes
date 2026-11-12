#!/usr/bin/env python3
"""On the EPYC 9275F: do the single-threaded one-message cells after other work give the same verdict when
the SAME comparison across two benches is run again? Today's bench (cb9dc384) as the new side, an older bench
as the old side (check --old-bench: both sides unpinned), ONE library (2037118c). Three sessions each of:
the 0.21 tag's bench (9434d50e) and its next commit (4bef90cc: one changed line, in code no cell runs).
Each line: the cells' medians of each side (ns/B) and the check's verdict."""
import subprocess, re, os, time, glob, statistics
H = os.path.expanduser("~"); O = H + "/runs/sessions"; M = H + "/work/BLAKE3"; PIN = "2037118ca1da85710aef55d7f13b3abd9095b485"
POINTS = "2304 B,4 KiB,16 KiB"; today = H + "/work/bench-hashes"
def log(m):
    with open(O + "/log.txt", "a") as f: f.write(time.strftime("%H:%M ", time.gmtime()) + m + "\n")
def med(d, side, point):
    v = []
    for f in sorted(glob.glob(f"{d}/run-*-{side}.tsv")):
        for l in open(f):
            p = l.rstrip("\n").split("\t")
            if len(p) > 6 and p[0] == "blake3-servil-st" and p[2] == "OneMessage" and p[3] == point:
                t = w = 0
                for s in p[5].split(","):
                    a, b = s.split("/"); t += int(a); w += int(b)
                v.append(t / w)
    return statistics.median(v) if v else float("nan")
for session in range(3):
    for old in ("9434d50e", "4bef90cc"):
        tag = f"s{session}-{old}"
        r = subprocess.run([today + "/target/release/bench-hashes", "check", "--fork", M, "--new", PIN, "--against", PIN, "--old-bench", old,
                            "--contenders", "blake3-servil-st", "--points", POINTS, "--when-quiet", "--keep", f"{O}/kept-{tag}"],
                           capture_output=True, text=True, cwd=today)
        open(f"{O}/{tag}.stdout.txt", "w").write(r.stdout); open(f"{O}/{tag}.stderr.txt", "w").write(r.stderr)
        cells = re.findall(r"(SLOWER|faster) blake3-servil-st\|solo\|OneMessage\|([^:]+): ([+-][0-9.]+)%", r.stdout)
        ms = "; ".join(f"{p} old {med(f'{O}/kept-{tag}', 'old', p):.4f} new {med(f'{O}/kept-{tag}', 'new', p):.4f}" for p in ("2304 B", "4 KiB", "16 KiB"))
        log(f"session {session}, today against {old}: exit {r.returncode}; {ms}; verdict: " + ("; ".join(f"{w} {p} {x}%" for w, p, x in cells) or "no cell slower or faster"))
log("DONE")
