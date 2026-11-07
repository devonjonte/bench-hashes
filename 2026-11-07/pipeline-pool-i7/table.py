import glob, os, re, sys, collections
root = sys.argv[1]
rows = collections.defaultdict(list)
for d in sorted(glob.glob(f"{root}/p*-t*")):
    t = int(re.search(r"-t(\d+)$", d).group(1))
    f = glob.glob(f"{d}/benchmark-results/*/bench-hashes.samples.tsv")
    if not f: continue
    for line in open(f[0]):
        p = line.rstrip("\n").split("\t")
        if len(p) < 9 or p[1] != "solo" or p[2] != "ReceivingMessage": continue
        ns = units = cpu = 0
        for s in p[5].split(","):
            a, b = s.split("/"); ns += int(a); units += int(b)
        cpu = sum(int(x) for x in p[7].split(",") if x)
        rows[(p[0], p[3], t)].append((ns / units, cpu / ns if ns else 0))
print(f"{'contender':24} {'arrivals':10} " + " ".join(f"{t:>11}" for t in (2,3,4,6,8,12,16,20)))
for c in ("blake3-servil-pipeline", "blake3-servil-mt"):
    for pt in ("saturated", "2 us"):
        cells = []
        for t in (2,3,4,6,8,12,16,20):
            v = rows.get((c, pt, t), [])
            cells.append(f"{sum(x for x,_ in v)/len(v):.3f}/{sum(y for _,y in v)/len(v):.1f}" if v else "-")
        print(f"{c:24} {pt:10} " + " ".join(f"{x:>11}" for x in cells))
print("cells: ns/B (mean of passes) / CPUs busy (process CPU time over wall)")
