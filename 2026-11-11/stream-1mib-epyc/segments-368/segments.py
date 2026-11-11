#!/usr/bin/env python3
"""BLAKE3 #368, done properly: the stream of 1 MiB messages, segment by segment between 86b11263 and the
pin 2037118c, each segment's two ends under ONE bench (the first of its benches that builds both), 64
pairs, the point "continuous 1 MiB". Writes log.txt; each check's output beside it."""
# First (added 16:45): BLAKE3 #297's trees by name, 16 pairs, before the segments.
import subprocess as _sp, os as _os
_H = _os.path.expanduser("~"); _os.makedirs(_H + "/runs/gate-297", exist_ok=True)
with open(_H + "/runs/gate-297/named.stdout.txt", "w") as _o, open(_H + "/runs/gate-297/named.stderr.txt", "w") as _e:
    _r = _sp.run([_H + "/work/bench-hashes/target/release/bench-hashes", "check", "--fork", _H + "/work/BLAKE3", "--new", "f2902fb2", "--against", "3313686b",
                  "--points", "merkle 1048576 x 32 B,merkle 65536 x 32 B,merkle 1048576 x 16 B,continuous batch 16,continuous batch 1024", "--layouts", "16", "--when-quiet",
                  "--keep", _H + "/runs/gate-297/kept-named"], stdout=_o, stderr=_e, cwd=_H + "/work/bench-hashes")
    _o.write(f"check exit {_r.returncode}\n")
import subprocess, re, os, time
H = os.path.expanduser("~"); O = H + "/runs/segments-368"; M = H + "/work/BLAKE3"; W = H + "/work"
SEGMENTS = [  # (old end, new end, benches to try), the likeliest first
    ("db3cab99", "85bf73a6", ["f24b6f4d", "a3e8ffa3"]),
    ("85bf73a6", "4eda049c", ["a3e8ffa3", "1a7db178"]),
    ("4eda049c", "dcc8ccff", ["1a7db178", "b6f41018"]),
    ("dcc8ccff", "a4095ba6", ["b6f41018", "148827f3"]),
    ("86b11263", "db3cab99", ["415e7df3", "f24b6f4d", "8a153ce2"]),
    ("a4095ba6", "5663b129", ["148827f3", "301afa6a"]),
    ("5663b129", "2037118c", ["301afa6a", "9434d50e"]),
]
def log(m):
    with open(O + "/log.txt", "a") as f: f.write(time.strftime("%H:%M ", time.gmtime()) + m + "\n")
def bench(b):
    d = f"{W}/bench-{b}"
    if not os.path.isdir(d): subprocess.run(["git", "-C", W + "/bench-hashes", "worktree", "add", "-q", "--detach", d, b], check=True)
    subprocess.run(["cargo", "build", "--release"], cwd=d, capture_output=True)
    return d
for old, new, benches in SEGMENTS:
    done = False
    for b in benches:
        d = bench(b); tag = f"{old}-{new}-by-{b}"
        r = subprocess.run([d + "/target/release/bench-hashes", "check", "--fork", M, "--new", new, "--against", old, "--points", "continuous 1 MiB",
                            "--layouts", "64", "--when-quiet", "--keep", f"{O}/kept-{tag}"], capture_output=True, text=True, cwd=d)
        open(f"{O}/{tag}.stdout.txt", "w").write(r.stdout); open(f"{O}/{tag}.stderr.txt", "w").write(r.stderr)
        if r.returncode not in (0, 1):
            log(f"{old} -> {new} under bench {b}: no verdict (exit {r.returncode})"); continue
        cells = re.findall(r"(SLOWER|faster) blake3-servil-mt\|(\S+?)\|ContinuousMessages\|1 MiB: ([+-][0-9.]+)% \(the pairs' geometric mean; (\d+) pairs", r.stdout)
        log(f"{old} -> {new} under bench {b}: " + ("; ".join(f"{s} {w} {p}% ({n} pairs)" for w, s, p, n in cells) or "no cell reported slower or faster"))
        done = True; break
    if not done: log(f"{old} -> {new}: no bench built both ends")
log("DONE")
