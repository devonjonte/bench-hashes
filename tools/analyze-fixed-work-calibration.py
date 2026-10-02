#!/usr/bin/env pypy3
"""Apply the declared calibration criteria to Rust comparison text only."""
import argparse
import importlib.util
import json
from pathlib import Path

spec=importlib.util.spec_from_file_location('rust_text',Path(__file__).with_name('analyze-current-rust-controls.py'))
shared=importlib.util.module_from_spec(spec);spec.loader.exec_module(shared)


def analyze(root):
    manifest=json.loads((root/'calibration/manifest.json').read_text())
    blocks=[]
    for block in sorted({a['block'] for a in manifest['attempts']}):
        attempts=[a for a in manifest['attempts'] if a['block']==block]
        assert len(attempts)==4 and all(a['exit']==0 for a in attempts)
        extra,cpu=attempts[0]['extra'],attempts[0]['cpu']
        failures=[];comparisons={}
        for label in ['effect','old-repeat','new-repeat']:
            values=shared.ratios((root/'calibration'/('block-%02d-%s.txt'%(block,label))).read_text())
            comparisons[label]=values
            for key,value in values.items():
                low,high=(1000+9*extra,1000+11*extra) if extra and label=='effect' and key.startswith('blake3-servil-st|') else (971,1029)
                if not low<=value<=high:failures.append({'comparison':label,'cell':key,'fast_permille':value,'bounds':[low,high]})
        blocks.append({'block':block,'extra':extra,'cpu':cpu,'comparisons':comparisons,'failures':failures})
    qualified={str(cpu):not any(b['failures'] for b in blocks if b['cpu']==cpu) for cpu in [None,0]}
    receipts=[json.loads(p.read_text()) for p in root.glob('calibration/*/accounting-check.json')]
    assert len(receipts)==56 and all(a['pass'] for a in receipts)
    return {'decision':'NO-GO','qualified':qualified,'conditional_pilot':'eligible for separately recorded collection' if any(qualified.values()) else 'unstarted: neither configuration qualifies',
            'blocks':blocks,'work_accounting':{'processes':56,'cells':sum(a['cells'] for a in receipts),'batches':sum(a['batches'] for a in receipts)}}


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('root',type=Path);a=p.parse_args()
    result=analyze(a.root);(a.root/'calibration-decision.json').write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps({k:v for k,v in result.items() if k!='blocks'},indent=2))
