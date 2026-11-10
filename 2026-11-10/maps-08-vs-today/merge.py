#!/usr/bin/env python3
"""Merge two runs' samples into one file a (scratch) bench-hashes map draws: BLAKE3-Servil 0.8, measured by
the last bench that builds against it, beside today's library, measured by bench-hashes 0.21.
usage: merge.py OLD.tsv[,OLD.tsv...] NOW.tsv[,NOW.tsv...] VIEW OUT.samples.tsv [OTHERS.samples.tsv]
  Several files a side: a check's paired runs, each cell's samples joined. OTHERS: a full run for the other hashes.
  VIEW: core | sync
  core: one thread, the direct and grouped calls (what blake3-servil-core is to hold)
  sync: the multithreaded synchronous calls (stable in 0.9)
Both leave out the streaming usages: continuous, lent, receive."""
import sys
old, now, view, out = sys.argv[1:5]
others = sys.argv[5] if len(sys.argv) > 5 else None
STREAMING = {"ContinuousMessages", "ContinuousBatches", "ContinuousCollection", "LentMessages", "LentBatches", "ReceivingMessage"}
KEEP = {"core": {"now": ["blake3-servil-st", "blake3-official", "sha256", "sha256-ring"], "old": {"blake3-servil-st": "blake3-servil-0.8-st"}},
        "sync": {"now": ["blake3-servil-mt", "blake3-official-mt"], "old": {"blake3-servil-mt": "blake3-servil-0.8-mt"}}}[view]
def read(path):
    head, rows = [], []
    for l in open(path, errors="replace"):
        (head if l.startswith("#") else rows).append(l.rstrip("\n"))
    return head, rows[0], rows[1:]
def read_many(paths):
    """Each cell's samples from every run, joined: the list columns (5 to 9) end to end."""
    head, cols, merged, order = None, None, {}, []
    for path in paths.split(","):
        h, c, rows = read(path)
        head, cols = head or h, cols or c
        for r in rows:
            p = r.split("\t"); k = tuple(p[:4])
            if k not in merged:
                merged[k] = p; order.append(k)
            else:
                per_sample = p[5].count(",") + 1
                for i in range(5, 11):
                    # A column holds a value a sample, or one mark for the cell (kept from the first run).
                    if i < len(p) and p[i] and p[i].count(",") + 1 == per_sample and (per_sample > 1 or i in (5, 6)):
                        merged[k][i] = merged[k][i] + "," + p[i] if merged[k][i] else p[i]
    return head, cols, ["\t".join(merged[k]) for k in order]
oh, _, orows = read_many(old)
nh, cols, nrows = read_many(now)
runs = (len(old.split(",")), len(now.split(",")))
if others:
    xh, _, xrows = read(others)
    nh = [h for h in nh if not h.startswith("# source ")] + [h for h in xh if h.startswith("# source ") and not h.startswith("# source blake3-servil")] + [h for h in nh if h.startswith("# source blake3-servil")]
    nrows = nrows + [r for r in xrows if not r.startswith("blake3-servil")]
order = list(KEEP["old"].values()) + KEEP["now"]
head = []
for h in nh:
    if h.startswith("# contenders:"):
        h = "# contenders: --contenders " + ",".join(order)
    if h.startswith("# source ") and h[len("# source "):].split(":")[0] not in KEEP["now"]:
        continue
    head.append(h)
for k, new in KEEP["old"].items():
    src = next(h for h in oh if h.startswith(f"# source {k}:"))
    load = next(h for h in oh if h.startswith("# load:"))
    head.append(f"# source {new}:" + src.split(":", 1)[1] + f"; measured by an earlier bench-hashes that builds against it, {runs[0]} runs joined (" + load[2:] + ")")
rows = []
for r in orows:
    p = r.split("\t")
    if p[0] in KEEP["old"] and p[2] not in STREAMING:
        p[0] = KEEP["old"][p[0]]; rows.append("\t".join(p))
for r in nrows:
    p = r.split("\t")
    if p[0] in KEEP["now"] and p[2] not in STREAMING:
        rows.append(r)
open(out, "w").write("\n".join(head + [cols] + rows) + "\n")
print(f"{view}: {len(rows)} cells; contenders {order}")
