#!/usr/bin/env pypy3
"""Fresh explicit-affinity work calibration; all sample/speed decoding belongs to Rust."""
import argparse
import importlib.util
import json
from pathlib import Path
import shutil
import subprocess
import sys

spec = importlib.util.spec_from_file_location('current_controls', Path(__file__).with_name('run-current-rust-controls.py'))
controls = importlib.util.module_from_spec(spec); spec.loader.exec_module(controls)


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--bench', type=Path, required=True)
    p.add_argument('--probe', type=Path, required=True)
    p.add_argument('--supervisor', type=Path, required=True)
    p.add_argument('--output', type=Path, required=True)
    p.add_argument('--plan', default='audit/six-percent-repair-plan.md')
    p.add_argument('--schedule', type=Path, help='predeclared block list: [cpu or null, extra]')
    a = p.parse_args()
    a.output = a.output.resolve(); a.output.mkdir(exist_ok=False)
    m = {'plan': a.plan, 'bench_sha256': controls.digest(a.bench),
         'probe_sha256': controls.digest(a.probe), 'attempts': []}
    def save():
        (a.output / 'manifest.json').write_text(json.dumps(m,indent=2)+'\n')
    settings = [(None,0),(0,0)]+[(cpu,6) for _ in range(4) for cpu in [None,0]]
    if a.schedule:
        settings = json.loads(a.schedule.read_text())
        assert all(len(s)==2 for s in settings)
        m['schedule_sha256'] = controls.digest(a.schedule)
    save()
    for block, (cpu, extra) in enumerate(settings,1):
        sides = {'old':[], 'new':[]}
        for pos, side in enumerate(['old','new','new','old'],1):
            folder = a.output / ('block-%02d-run-%d'%(block,pos)); folder.mkdir()
            command = (["taskset", "-c", str(cpu)] if cpu is not None else []) + [str(a.probe.resolve()),str(extra if side=='new' else 0),'128','0']
            row = {'block':block,'cpu':cpu,'extra':extra,'side':side,'command':command,'folder':folder.name}
            m['attempts'].append(row); save()
            row['exit'] = subprocess.run([sys.executable,str(a.supervisor.resolve()),'120',str(folder/'bounded')]+command,cwd=folder).returncode
            shutil.copyfile(folder/'bounded.stdout.txt',folder/'samples.tsv')
            if row['exit']==0: controls.accounting(folder)
            sides[side].append(folder); save()
        comparisons = [('effect',sides['old'],sides['new'])]+[(side+'-repeat',sides[side][:1],sides[side][1:]) for side in sides]
        for label, old, new in comparisons:
            command = [str(a.bench.resolve()),'compare']+[str(x/'samples.tsv') for x in old]+['--']+[str(x/'samples.tsv') for x in new]
            with (a.output/('block-%02d-%s.txt'%(block,label))).open('w') as out:
                subprocess.run(command,stdout=out,stderr=subprocess.STDOUT,check=True)
    assert controls.digest(a.bench)==m['bench_sha256'] and controls.digest(a.probe)==m['probe_sha256']
    print('Retained%d fresh affinity-calibration processes' % len(m['attempts']))


if __name__=='__main__':
    main()
