"""wake_probe: median call time (us) by size, pause and api; the mt/st ratio (below 1: waking the pool pays)."""
import statistics as st
from collections import defaultdict
pauses=[0,20,200,1000,5000]
data={}
for p in pauses:
    d=defaultdict(list)
    for l in open(f"pause-{p}.tsv"):
        if l.startswith("#"): continue
        size,api,ns=l.split("\t"); d[(int(size),api)].append(int(ns))
    data[p]=d
sizes=sorted({s for (s,_) in data[0]})
print("size      | " + " | ".join(f"pause {p:>4} us: mt      st    mt/st" for p in pauses))
for s in sizes:
    row=f"{s//1024:>5} KiB | "
    for p in pauses:
        mt=st.median(data[p][(s,"mt")])/1000; stt=st.median(data[p][(s,"st")])/1000
        row+=f"{mt:>18.1f} {stt:>7.1f} {mt/stt:>6.2f} | "
    print(row)
print("\np10/p90 of mt, us:")
for s in sizes:
    row=f"{s//1024:>5} KiB | "
    for p in pauses:
        v=sorted(data[p][(s,"mt")]); row+=f"{v[len(v)//10]/1000:>8.0f}/{v[9*len(v)//10]/1000:<8.0f} | "
    print(row)
