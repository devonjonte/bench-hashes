import mmap,os,pathlib,re,sys
out=pathlib.Path(os.environ['O'])
snap=pathlib.Path(os.environ['SNAP'])
source=pathlib.Path(os.environ['SOURCE'])/'old-8'
node,cpu,action=int(sys.argv[1]),int(sys.argv[2]),sys.argv[3]
os.sched_setaffinity(0,{cpu})
path=snap/f'node{node}'
if action=='create':
    data=source.read_bytes()
    with path.open('xb') as f:
        f.write(data)
        f.flush()
        os.fsync(f.fileno())
    path.chmod(0o755)
with path.open('rb') as f, mmap.mmap(f.fileno(),0,access=mmap.ACCESS_READ) as pages:
    sum(pages[i] for i in range(0,len(pages),4096))
    lines=[l for l in pathlib.Path('/proc/self/numa_maps').read_text().splitlines() if str(path) in l]
    assert len(lines)==1, lines
    counts={int(n):int(p) for n,p in re.findall(r'\bN(\d+)=(\d+)',lines[0])}
    assert counts.get(node,0)>0 and sum(counts.values())==counts[node], (node,counts)
    print(f'node={node} writer_cpu={cpu} action={action} affinity={os.sched_getaffinity(0)}\t'+lines[0])
