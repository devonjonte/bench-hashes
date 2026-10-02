#!/usr/bin/env pypy3
"""Fixed raw fixtures exercise Rust reader/mean/interval/whole-gate policy.
Expected outcomes are independent of the implementation. No sample analysis.
"""
import subprocess,sys
from pathlib import Path
root=Path(__file__).resolve().parent/'fixtures';root.mkdir(exist_ok=True)
exe=sys.argv[1]
cases=[('null',1000,1000,'quiet: fixture',0),('six',1000,1060,'quiet: fixture',1),('twelve',1000,1120,'quiet: fixture',1),('double',1000,2000,'quiet: fixture',1),('boundary',1000,1030,'quiet: fixture',2),('busy',1000,1060,'busy: fixture',2),('unknown',1000,1060,'not measured: fixture',2),('variable',1000,None,'quiet: fixture',2),('control-shift',1000,1060,'quiet: fixture',2)]
for name,old,new,load,expected in cases:
 folder=root/name;folder.mkdir(exist_ok=True);manifest=['side\tsamples']
 for block in range(16):
  for slot,side in enumerate(['old','new','new','old']):
   n=old if side=='old' else (new if new is not None else (800 if block%2==0 else 1300))
   control=1100 if name=='control-shift' and side=='new' else 1000
   path=folder/('%02d-%d.tsv'%(block,slot))
   header='# bench-hashes samples v4\n# load: %s\n# power: fixture\ncontender\tscenario\tuse_case\tpoint\tunit\tns/units\tstart ms\n'%load
   rows='sha256\tsolo\tLentMessages\t64 B\tB\t%d/1000\t0\nblake3-servil-st\tsolo\tLentMessages\t64 B\tB\t%d/1000\t0\n'%(control,n)
   path.write_text(header+rows);manifest.append(side+'\t'+path.name)
 (folder/'manifest.tsv').write_text('\n'.join(manifest)+'\n')
 with (folder/'stdout.txt').open('w') as out,(folder/'stderr.txt').open('w') as err:
  r=subprocess.run([exe,'regress','--records',str(folder/'manifest.tsv')],cwd=folder,stdout=out,stderr=err)
 assert r.returncode==expected,(name,r.returncode,expected)
 print(name,'exit',r.returncode)
print('Nine deterministic gate fixtures pass')
