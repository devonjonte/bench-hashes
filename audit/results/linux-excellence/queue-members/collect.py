#!/usr/bin/env pypy3
"""Frozen production point ABBA: gathered queue messages and lent controls."""
from pathlib import Path
import hashlib,json,subprocess,sys
root=Path(__file__).resolve().parent
out=root/'runs'; out.mkdir(exist_ok=False)
exe={s:root/'frozen'/s for s in ['old','new']}
points='continuous 64 B,continuous 1 KiB,continuous 16 KiB,continuous 64 KiB,continuous 1 MiB,lent 64 B,lent 1 KiB,lent 16 KiB,lent 64 KiB,lent 1 MiB'
manifest={'plan':'audit/queue-messages-plan.md','old_hashing_runtime':'d0574e7','new_measured':'c2a5f575ec0d6b3ebed16863ed713b4e43f1f8e5','benchmark_runtime':'6047dcd','artifacts':{s:hashlib.sha256(p.read_bytes()).hexdigest() for s,p in exe.items()},'attempts':[]}
def save(): (out/'manifest.json').write_text(json.dumps(manifest,indent=2)+'\n')
def samples(folder):
    paths=list((folder/'benchmark-results').glob('*/bench-hashes.samples.tsv')); assert len(paths)==1
    return paths[0]
def compare(name,a,b):
    with (out/(name+'.txt')).open('wb') as f:subprocess.run([str(exe['old']),'compare']+[str(samples(x)) for x in a]+['--']+[str(samples(x)) for x in b],stdout=f,stderr=subprocess.STDOUT,check=True)
save()
for label,cpus in [('default',None),('p-only','0-15')]:
    sides={'old':[],'new':[]}
    for position,side in enumerate(['old','new','new','old'],1):
        folder=out/('%s-%d-%s'%(label,position,side));folder.mkdir()
        command=(['taskset','-c',cpus] if cpus else [])+[str(exe[side]),'--contenders','sha256,blake3-servil-st,blake3-servil-mt','--points',points,'--rounds','24','--trace-clocks',str(folder/'clocks.csv')]
        row={'placement':label,'side':side,'position':position,'folder':folder.name,'command':command};manifest['attempts'].append(row);save()
        row['exit']=subprocess.run([sys.executable,'/home/agent/bench-hashes-validation/run-bounded.py','180',str(folder/'bounded')]+command,cwd=folder).returncode;save()
        assert row['exit']==0,row
        sides[side].append(folder)
    compare(label+'-effect',sides['old'],sides['new'])
    for side in sides:compare(label+'-'+side+'-repeat',sides[side][:1],sides[side][1:])
    for pair,(a,b) in enumerate(zip(sides['old'],sides['new']),1):compare(label+'-pair%d'%pair,[a],[b])
assert manifest['artifacts']=={s:hashlib.sha256(p.read_bytes()).hexdigest() for s,p in exe.items()}
print('Preserved eight production runs; frozen Rust computed all comparisons')
