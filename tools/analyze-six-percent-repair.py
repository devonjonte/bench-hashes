#!/usr/bin/env pypy3
"""Summarize repair diagnostics from Rust output and exact count-check receipts."""
import argparse
import importlib.util
import json
from pathlib import Path
import re

spec = importlib.util.spec_from_file_location('rust_text',Path(__file__).with_name('analyze-current-rust-controls.py'))
shared = importlib.util.module_from_spec(spec); spec.loader.exec_module(shared)


def analyze(root):
    affinity = []
    for block in range(1,11):
        comparisons = {label: shared.ratios((root/'affinity-calibration'/('block-%02d-%s.txt'%(block,label))).read_text())
                       for label in ['effect','old-repeat','new-repeat']}
        failures=[]
        for label, values in comparisons.items():
            for key, value in values.items():
                # Stability applies to all measured cells, including the unchanged control.
                low,high=(1054,1066) if block>2 and label=='effect' and key.startswith('blake3-servil-st|') else (986,1014)
                if not low<=value<=high:failures.append({'comparison':label,'cell':key,'fast_permille':value,'bounds':[low,high]})
        affinity.append({'block':block,'cpu':0 if block%2==0 else None,'extra':0 if block<=2 else 6,
                         'ratios':comparisons,'failures':failures})
    manifest=json.loads((root/'aggregate-pilot/manifest.json').read_text())
    checks=[]
    for index, attempt in enumerate(manifest['attempts'],1):
        folder=root/'aggregate-pilot'/('check-%02d'%index)
        text=(folder/'bounded.stdout.txt').read_text()
        slower=re.findall(r'^  (blake3-servil-[^\n:]+):',text,re.M)
        faster=re.findall(r'^  faster  (blake3-servil-[^\n:]+):',text,re.M)
        checks.append({'index':index,'extra':attempt['extra'],'production':attempt['production'],
                       'exit':attempt['exit'],'slower':slower,'faster':faster,
                       'pair_fast_permille':[shared.ratios((root/'aggregate-pilot'/('check-%02d-pair-%02d.txt'%(index,p))).read_text()) for p in range(1,9)]})
    detections={level:{size:sum('blake3-servil-st|solo|PositiveWorkControl|%d B'%size in c['slower']
                                  for c in checks if c['extra']==level)
                       for size in [64,2048,102400]} for level in [3,6,12]}
    receipts=list(root.glob('affinity-calibration/*/accounting-check.json'))+list(root.glob('aggregate-pilot/check-*/run-*/accounting-check.json'))
    accounts=[json.loads(p.read_text()) for p in receipts]
    assert all(a['pass'] for a in accounts)
    return {'decision':'NO-GO','candidate':'FAILED: production null false calls and missed/abstaining positives',
            'affinity':affinity,'checks':checks,'detections':detections,
            'work_accounting':{'processes':len(accounts),'cells':sum(a['cells'] for a in accounts),'batches':sum(a['batches'] for a in accounts)}}


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('root',type=Path);a=p.parse_args()
    result=analyze(a.root);(a.root/'summary.json').write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps({k:v for k,v in result.items() if k not in ['affinity','checks']},indent=2))
