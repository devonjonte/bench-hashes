"""Same-code controls (bench-hashes #81): for each run, the check's verdicts,
the spread of first-stage ratios (after-a-pause cells beside the rest), and
for the bimodal after-a-pause cells the fast state's share, old and new."""
import glob, re, statistics, subprocess, sys, collections
EXE = "/home/agent/BLAKE3-rel08/target/build-against/release/bench-hashes"
BASE = "/home/agent/bench-hashes-validation/aa-idle-i7"
def compare(d):
    o = sorted(glob.glob(f"{d}/run-*-old.tsv")); n = sorted(glob.glob(f"{d}/run-*-new.tsv"))
    out = subprocess.run([EXE, "compare", *o, "--", *n], capture_output=True, text=True).stdout
    r = {}
    for l in out.splitlines():
        m = re.match(r"(blake3-servil-\w+\|\w+\|(\w+)\|[^:]+): \S+ -> \S+ ns/unit  x([0-9.]+) (\w+)", l)
        if m: r[m.group(1)] = (float(m.group(3)), m.group(4), m.group(2).startswith("Idle"))
    return r, len(o)
def shares(d, cells):
    v = collections.defaultdict(lambda: {"old": [], "new": []})
    for f in glob.glob(f"{d}/run-*.tsv"):
        side = "old" if f.endswith("old.tsv") else "new"
        for l in open(f):
            x = l.rstrip("\n").split("\t")
            if len(x) > 5 and "|".join(x[:4]) in cells:
                v["|".join(x[:4])][side] += [int(a) / int(b) for a, b in (s.split("/") for s in x[5].split(","))]
    res = {}
    for c, s in v.items():
        a = sorted(s["old"] + s["new"]); lo, hi = int(len(a) * .1), int(len(a) * .9)
        g = max(range(lo, hi), key=lambda i: a[i + 1] - a[i]); cut = (a[g] + a[g + 1]) / 2
        res[c] = tuple(sum(t < cut for t in s[k]) / len(s[k]) for k in ("old", "new"))
    return res
for run in sorted(glob.glob(f"{BASE}/run[0-9]")):
    verdict = [l.strip() for l in open(f"{BASE}/aa.stdout.txt")] if False else None
    r, pairs = compare(run)
    idle = [x for x, _, i in r.values() if i]; rest = [x for x, _, i in r.values() if not i]
    q = lambda xs, f: sorted(xs)[int(len(xs) * f)]
    print(f"{run.split('/')[-1]}: {pairs} pairs, {len(r)} cells")
    print(f"  after a pause: {len(idle)} cells, ratios p5 {q(idle,.05):.3f} p50 {q(idle,.5):.3f} p95 {q(idle,.95):.3f}, beyond ±5%: {100*sum(abs(x-1)>.05 for x in idle)/len(idle):.0f}%")
    print(f"  the rest:      {len(rest)} cells, ratios p5 {q(rest,.05):.3f} p50 {q(rest,.5):.3f} p95 {q(rest,.95):.3f}, beyond ±5%: {100*sum(abs(x-1)>.05 for x in rest)/len(rest):.0f}%")
    cells = {"blake3-servil-mt|solo|IdleManyMessages|16", "blake3-servil-mt|solo|IdleManyMessages|24", "blake3-servil-st|solo|IdleManyMessages|2", "blake3-servil-mt|solo|IdleOneMessage|1536 B"}
    sh = shares(run + "/second", cells) if glob.glob(run + "/second/run-*.tsv") else shares(run, cells)
    print("  fast-state share old → new:", "; ".join(f"{c.split('|',2)[2]} {a:.0%}→{b:.0%}" for c, (a, b) in sorted(sh.items())))
