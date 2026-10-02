#!/usr/bin/env pypy3
"""Collect predeclared current Rust controls; Rust alone reads/statistically compares samples."""
import argparse
import csv
import hashlib
import json
import os
from pathlib import Path
import shutil
import signal
import subprocess
import sys


def digest(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def accounting(folder):
    # Separate work/clock trace: exact arithmetic, no samples decoding or statistics.
    with (folder / 'accounting.csv').open() as f:
        accounts = list(csv.DictReader(f))
    with (folder / 'clocks.csv').open() as f:
        traces = list(csv.DictReader(f))
    for a in accounts:
        rows = [r for r in traces if (r['contender'], r['length']) == (a['contender'], a['length'])]
        n, blocks, hashes = (int(a[k]) for k in ['measured_batches', 'blocks_per_batch', 'hashes_per_block'])
        assert len(rows) == n
        assert sorted(int(r['sample']) for r in rows) == list(range(n))
        assert int(a['calls_per_batch']) == blocks * 100
        assert int(a['completed_including_calibration']) == (n + 1) * blocks * hashes
        for r in rows:
            assert int(r['blocks']) == blocks and int(r['calls']) == blocks * 100
            assert int(r['hashes_per_block']) == hashes and int(r['completed_hashes']) == blocks * hashes
            assert int(r['wall_ns']) > 0
    assert len(accounts) == 6 and len(traces) == sum(int(a['measured_batches']) for a in accounts)
    (folder / 'accounting-check.json').write_text(json.dumps({'cells': len(accounts), 'batches': len(traces), 'pass': True}) + '\n')


def wrapper(config_path, side, arguments):
    c = json.loads(Path(config_path).read_text())
    root = Path(c['output'])
    index = len(list(root.glob('run-*'))) + 1
    folder = root / ('run-%02d-%s' % (index, side))
    folder.mkdir()
    request = {'side': side, 'arguments': arguments, 'temporary_cwd': os.getcwd(), 'index': index}
    (folder / 'request.json').write_text(json.dumps(request, indent=2) + '\n')
    if c['production']:
        command = [c['bench']] + arguments
    else:
        command = (["taskset", "-c", str(c['cpu'])] if c['cpu'] is not None else []) + [c['probe'], str(c['extra'] if side == 'new' else 0), str(c['batches']), '0']
    with (folder / 'process.stdout.txt').open('wb') as out, (folder / 'process.stderr.txt').open('wb') as err:
        status = subprocess.run(command, stdout=out, stderr=err).returncode
    request['exit'] = status
    (folder / 'request.json').write_text(json.dumps(request, indent=2) + '\n')
    if c['production']:
        if Path('benchmark-results').exists():
            shutil.copytree('benchmark-results', folder / 'benchmark-results')
    else:
        samples = Path('benchmark-results/control/bench-hashes.samples.tsv')
        samples.parent.mkdir(parents=True)
        shutil.copyfile(folder / 'process.stdout.txt', samples)
        shutil.copyfile(samples, folder / 'samples.tsv')
        for name in ['clocks.csv', 'accounting.csv']:
            if Path(name).exists():
                shutil.copyfile(name, folder / name)
        if status == 0:
            accounting(folder)
    return status


def check(config_path):
    c = json.loads(Path(config_path).read_text())
    root = Path(c['output'])
    workers = []
    try:
        for _ in range(c['workers']):
            workers.append(subprocess.Popen([sys.executable, '-c', 'x=1\nwhile True: x=(x*1664525+1013904223)&0xffffffff']))
        return subprocess.run([c['bench'], 'regress', str(root / 'old'), str(root / 'new')]).returncode
    finally:
        for w in workers:
            w.terminate()
        for w in workers:
            try:
                w.wait(timeout=3)
            except subprocess.TimeoutExpired:
                w.kill(); w.wait()


def samples(folder):
    if (folder / 'samples.tsv').exists():
        return folder / 'samples.tsv'
    found = list((folder / 'benchmark-results').glob('*/bench-hashes.samples.tsv'))
    assert len(found) == 1
    return found[0]


def main():
    if len(sys.argv) > 1 and sys.argv[1] == 'wrapper':
        return wrapper(sys.argv[2], sys.argv[3], sys.argv[4:])
    if len(sys.argv) > 1 and sys.argv[1] == 'check':
        return check(sys.argv[2])
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--stage', choices=['calibration', 'pilot'], required=True)
    p.add_argument('--bench', type=Path, required=True)
    p.add_argument('--probe', type=Path, required=True)
    p.add_argument('--supervisor', type=Path, required=True)
    p.add_argument('--output', type=Path, required=True)
    p.add_argument('--plan', default='audit/current-fast-median-plan.md')
    p.add_argument('--schedule', type=Path, help='predeclared pilot list: [extra,batches,workers,production]')
    p.add_argument('--production-deadline', type=int, default=180)
    p.add_argument('--affinity-cpu', type=int, help='explicit CPU for diagnostic caller children only')
    a = p.parse_args()
    a.output = a.output.resolve(); a.output.mkdir(parents=True, exist_ok=False)
    manifest = {'stage': a.stage, 'plan': a.plan,
                'bench_sha256': digest(a.bench), 'probe_sha256': digest(a.probe), 'attempts': []}
    if a.schedule:
        assert a.stage == 'pilot'
        manifest['schedule_sha256'] = digest(a.schedule)
    def save():
        (a.output / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
    def bounded(folder, command, seconds=120):
        return subprocess.run([sys.executable, str(a.supervisor.resolve()), str(seconds), str(folder / 'bounded')] + command, cwd=folder).returncode
    def compare(name, old, new):
        with (a.output / (name + '.txt')).open('w') as out:
            subprocess.run([str(a.bench.resolve()), 'compare'] + [str(samples(x)) for x in old] + ['--'] + [str(samples(x)) for x in new], stdout=out, stderr=subprocess.STDOUT, check=True)
    save()
    if a.stage == 'calibration':
        for block, extra in enumerate([0, 100] + [3, 6] * 4, 1):
            sides = {'old': [], 'new': []}
            for pos, side in enumerate(['old', 'new', 'new', 'old'], 1):
                folder = a.output / ('block-%02d-run-%d' % (block, pos)); folder.mkdir()
                row = {'block': block, 'extra': extra, 'side': side, 'folder': folder.name}
                manifest['attempts'].append(row); save()
                command = [str(a.probe.resolve()), str(extra if side == 'new' else 0), '128', '0']
                row['exit'] = bounded(folder, command)
                shutil.copyfile(folder / 'bounded.stdout.txt', folder / 'samples.tsv')
                if row['exit'] == 0: accounting(folder)
                sides[side].append(folder); save()
            compare('block-%02d-effect' % block, sides['old'], sides['new'])
            for side in sides:
                compare('block-%02d-%s-repeat' % (block, side), sides[side][:1], sides[side][1:])
    else:
        settings = [(0,128,0,False)]*4 + [(100,128,0,False)] + [(k,128,0,False) for _ in range(8) for k in [3,6]] + [(0,8,0,False),(0,128,2,False)] + [(0,0,0,True)]*2
        if a.schedule:
            settings = json.loads(a.schedule.read_text())
            assert all(len(s) == 4 for s in settings)
        for index, (extra,batches,workers,production) in enumerate(settings, 1):
            folder = a.output / ('check-%02d' % index); folder.mkdir()
            c = {'output': str(folder), 'bench': str(a.bench.resolve()), 'probe': str(a.probe.resolve()),
                 'extra': extra, 'batches': batches, 'workers': workers, 'production': production, 'cpu': a.affinity_cpu}
            config = folder / 'config.json'; config.write_text(json.dumps(c,indent=2)+'\n')
            for side in ['old','new']:
                script = '#!%s\nimport subprocess,sys\nsys.exit(subprocess.call(%r+sys.argv[1:]))\n' % (sys.executable, [sys.executable,str(Path(__file__).resolve()),'wrapper',str(config),side])
                (folder / side).write_text(script); (folder / side).chmod(0o755)
            row = dict(c); manifest['attempts'].append(row); save()
            row['exit'] = bounded(folder,[sys.executable,str(Path(__file__).resolve()),'check',str(config)],a.production_deadline if production else 120)
            save()
            runs = sorted(folder.glob('run-*'))
            for pair in range(len(runs)//2):
                two = runs[pair*2:pair*2+2]
                old = [x for x in two if x.name.endswith('old')]
                new = [x for x in two if x.name.endswith('new')]
                compare('check-%02d-pair-%02d' % (index,pair+1),old,new)
    assert digest(a.bench) == manifest['bench_sha256'] and digest(a.probe) == manifest['probe_sha256']
    print('Retained %d %s attempts' % (len(manifest['attempts']), a.stage))
    return 0


if __name__ == '__main__':
    sys.exit(main())
