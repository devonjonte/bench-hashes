#!/usr/bin/env pypy3
"""Predeclared placement cohorts; process plumbing only."""
from pathlib import Path
import hashlib,json,subprocess,sys
root=Path(__file__).resolve().parent
out=root/'runs'; out.mkdir(exist_ok=False)
exe={s:root/'frozen'/s for s in ['old','new']}
supervisor='/home/agent/bench-hashes-validation/run-bounded.py'
manifest={'plan':'benchmark f95bca8 audit/queue-placement-plan.md','benchmark_runtime':'6047dcd','old':'a1ecc5d','new':'d0574e7','artifacts':{s:hashlib.sha256(p.read_bytes()).hexdigest() for s,p in exe.items()},'attempts':[]}

def save(): (out/'manifest.json').write_text(json.dumps(manifest,indent=2)+'\n')
def samples(folder): return folder/'benchmark-results/batches/bench-hashes.samples.tsv'
def compare(name,a,b):
    with (out/(name+'.txt')).open('wb') as f:
        subprocess.run([str(exe['old']),'compare']+[str(samples(x)) for x in a]+['--']+[str(samples(x)) for x in b],stdout=f,stderr=subprocess.STDOUT,check=True)

save()
for cohort in range(1,4):
    for label,cpus in [('default',None),('p-only','0-15'),('separate-p','0,2'),('smt-siblings','0,1')]:
        sides={'old':[],'new':[]}
        prefix='cohort%d-%s'%(cohort,label)
        for position,side in enumerate(['old','new','new','old'],1):
            folder=out/('%s-%d-%s'%(prefix,position,side)); folder.mkdir()
            command=(['taskset','-c',cpus] if cpus else [])+[str(exe[side]),'batches','--lengths','2048,4096','--counts','8,16,64,129','--rounds','96']
            row={'cohort':cohort,'placement':label,'cpus':cpus,'position':position,'side':side,'folder':folder.name,'command':command}
            manifest['attempts'].append(row); save()
            row['exit']=subprocess.run([sys.executable,supervisor,'180',str(folder/'bounded')]+command,cwd=folder).returncode
            save()
            if row['exit']==0: sides[side].append(folder)
            else: print('Retained failed attempt',folder.name,flush=True)
        if all(len(v)==2 for v in sides.values()):
            compare(prefix+'-effect',sides['old'],sides['new'])
            for side in sides: compare(prefix+'-'+side+'-repeat',sides[side][:1],sides[side][1:])
            for pair,(a,b) in enumerate(zip(sides['old'],sides['new']),1): compare(prefix+'-pair%d'%pair,[a],[b])
assert manifest['artifacts']=={s:hashlib.sha256(p.read_bytes()).hexdigest() for s,p in exe.items()}
print('Preserved',len(manifest['attempts']),'placement attempts; Rust computed every speed/state comparison')
