#!/usr/bin/env python3
"""A front page for a merged 0.8-against-today view: one row a representative use, a bar a contender.
usage: front.py VIEW PAGES_DIR   (reads PAGES_DIR/benchmark-results/*/bench-hashes.samples.tsv, writes PAGES_DIR/index.html)"""
import sys, os, glob, html
view, pages = sys.argv[1:]
V = {"core": dict(title="BLAKE3-Servil on one thread: 0.8 beside today's",
                  what="The calls blake3-servil-core is to hold, on one thread.",
                  old="blake3-servil-0.8-st", now="blake3-servil-st", other="blake3-official",
                  names=("BLAKE3-Servil 0.8, one thread", "BLAKE3-Servil today, one thread", "BLAKE3 official, one thread"),
                  picks=[("OneMessage", "64 B", "one 64 B message, between other work"), ("OneMessage", "1 KiB", "one 1 KiB message, between other work"),
                         ("OneMessage", "3 KiB", "one 3 KiB message, between other work"), ("OneMessage", "1 MiB", "one 1 MiB message"),
                         ("OneMessage", "128 MiB", "one 128 MiB message"), ("IdleOneMessage", "64 B", "one 64 B message, after a pause"),
                         ("ManyMessages", "4", "4 messages of 64 B in one call"), ("ManyMessages", "1024", "1,024 messages of 64 B in one call"), ("ManyLongMessages", None, "a batch of longer messages"),
                         ("InterleavedTurn", None, "many messages at once, in pieces"), ("Collection", None, "a collection of messages"), ("MerkleTree", None, "a Merkle tree")]),
     "sync": dict(title="BLAKE3-Servil's multithreaded calls: 0.8 beside today's",
                  what="The multithreaded calls that return when the work is done, settled for 0.9.",
                  old="blake3-servil-0.8-mt", now="blake3-servil-mt", other="blake3-official-mt",
                  names=("BLAKE3-Servil 0.8, every core", "BLAKE3-Servil today, every core", "BLAKE3 official, every core"),
                  picks=[("OneMessage", "8 KiB", "one 8 KiB message, between other work"), ("OneMessage", "64 KiB", "one 64 KiB message, between other work"), ("OneMessage", "1 MiB", "one 1 MiB message"),
                         ("OneMessage", "128 MiB", "one 128 MiB message"), ("IdleOneMessage", "1 MiB", "one 1 MiB message, after a pause"),
                         ("ManyMessages", "4", "4 messages of 64 B in one call"), ("ManyMessages", "1024", "1,024 messages of 64 B in one call"), ("ManyMessages", "65536", "65,536 messages of 64 B in one call"),
                         ("ManyLongMessages", None, "a batch of longer messages"), ("InterleavedTurn", None, "many messages at once, in pieces"),
                         ("Collection", None, "a collection of messages"), ("MerkleTree", None, "a Merkle tree")])}[view]
COL = {V["old"]: "#111827", V["now"]: "#7c3aed", V["other"]: "#3b82f6"}
def read(path):
    head, cells = [], {}
    for l in open(path, errors="replace"):
        if l.startswith("#"): head.append(l.rstrip("\n")); continue
        p = l.rstrip("\n").split("\t")
        if len(p) < 6 or p[1] != "solo" or "/" not in p[5]: continue
        ns = sum(int(x.split("/")[0]) for x in p[5].split(",")); units = sum(int(x.split("/")[1]) for x in p[5].split(","))
        cells[(p[0], p[2], p[3])] = (ns / units, p[4])
    return head, cells
out = [f"<!doctype html><meta charset=utf-8><title>{html.escape(V['title'])}</title>",
       "<style>body{font:15px/1.4 system-ui,sans-serif;margin:24px;max-width:1100px;color:#111;background:#fdfdfb}h1{font-size:20px;margin:0}"
       ".sub{color:#555;margin:.3em 0 1em}table{border-collapse:collapse;width:100%}td{padding:6px 8px;border-top:1px solid #e5e5e0;vertical-align:middle}"
       ".use{width:30%;font-weight:600;color:#333}.bar{height:9px;border-radius:2px;margin:2px 0;display:block}.v{color:#666;font-size:12px;white-space:nowrap}"
       ".r{font-weight:700;white-space:nowrap}.fast{color:#15803d}.slow{color:#b91c1c}.lvl{color:#666}.key i{display:inline-block;width:22px;height:9px;border-radius:2px;margin:0 6px 0 14px}"
       "h2{font-size:17px;margin:1.4em 0 .1em}a{color:#5b21b6}</style>",
       f"<h1>{html.escape(V['title'])}</h1>",
       f"<p class=sub><b>{html.escape(V['what'])}</b> The streaming usages are left out. Longer is faster. <b>Where the bars come from:</b> the two versions are the release check's own paired runs (four a side, fresh link layouts, the same sample sizes): 0.8 built by the last bench-hashes that builds against it, "
       "today's (2037118c) by bench-hashes 0.21; official BLAKE3 is from 0.21's full run. Each bar is a mean over those runs; read a gap of a few percent as no difference. Each machine's check judged every cell, and its verdict stands under the machine's name.</p>",
       "<p class=key>" + "".join(f"<i style='background:{COL[k]}'></i>{html.escape(n)}" for k, n in zip((V['old'], V['now'], V['other']), V['names'])) + "</p>"]
for d in sorted(glob.glob(os.path.join(pages, "benchmark-results", "*"))):
    f = os.path.join(d, "bench-hashes.samples.tsv")
    if not os.path.exists(f): continue
    head, cells = read(f)
    get = lambda k: next((h.split(":", 1)[1].strip() for h in head if h.startswith(f"# {k}:")), "")
    out.append(f"<h2><a href='benchmark-results/{os.path.basename(d)}/bench-hashes.map.html'>{html.escape(get('cpu type') or os.path.basename(d))}</a></h2>"
               f"<p class=sub>{html.escape(get('cpu count'))} CPUs, {html.escape(get('os type'))}. Every cell of this machine is on <a href='benchmark-results/{os.path.basename(d)}/bench-hashes.map.html'>its map</a>. <b>Its check:</b> {html.escape(open(os.path.join(d, 'verdict.txt')).read().strip())}</p><table>")
    for use, point, label in V["picks"]:
        if point is None:  # the use case's largest point both versions have
            pts = [p for (c, u, p) in cells if c == V["now"] and u == use and (V["old"], u, p) in cells]
            if not pts: continue
            point = pts[-1]; label = f"{label} ({point})"
        vals = {k: cells.get((k, use, point)) for k in (V["old"], V["now"], V["other"])}
        if not vals[V["old"]] or not vals[V["now"]]: continue
        speed = {k: 1.0 / v[0] for k, v in vals.items() if v}
        top = max(speed.values()); unit = vals[V["now"]][1]
        def shown(k):
            s = speed[k]
            return f"{s:.2f} GB/s" if unit == "B" else f"{s * 1000:.1f} million {unit} a second"
        ratio = vals[V["old"]][0] / vals[V["now"]][0]  # today's speed over 0.8's
        cls, word = ("fast", f"{(ratio - 1) * 100:.0f}% faster") if ratio > 1.03 else (("slow", f"{(1 - ratio) * 100:.0f}% slower") if ratio < 0.97 else ("lvl", "about the same"))
        bars = "".join(f"<span class=bar style='width:{100 * speed[k] / top:.1f}%;background:{COL[k]}' title='{html.escape(shown(k))}'></span>" for k in (V["old"], V["now"], V["other"]) if k in speed)
        out.append(f"<tr><td class=use>{html.escape(label)}</td><td style='width:45%'>{bars}</td><td class=v>{html.escape(shown(V['old']))} → {html.escape(shown(V['now']))}</td><td class='r {cls}'>today: {word}</td></tr>")
    out.append("</table>")
open(os.path.join(pages, "index.html"), "w").write("\n".join(out) + "\n")
print("wrote", os.path.join(pages, "index.html"))
