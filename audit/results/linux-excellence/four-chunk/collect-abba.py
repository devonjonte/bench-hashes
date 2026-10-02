#!/usr/bin/env pypy3
"""Process plumbing only; frozen Rust instrument reads and compares samples."""
import hashlib
import json
from pathlib import Path
import subprocess
import sys

root = Path(__file__).resolve().parent
artifacts = root / 'frozen'
output = root / 'abba'
output.mkdir(exist_ok=False)
supervisor = Path('/home/agent/bench-hashes-validation/run-bounded.py')
bench = artifacts / 'bench-old'
points = 'continuous 64 B,continuous 1 KiB,continuous 16 KiB,continuous 64 KiB,continuous 1 MiB,continuous batch 16,continuous batch 256,continuous batch 4096,lent 64 B,lent 64 KiB,lent 1 MiB,lent pieces 64 MiB,lent batch 16,lent batch 4096'
manifest = {'plan': 'benchmark runtime6047dcd; plan d52902b audit/four-chunk-plan.md', 'artifacts': {p.name: hashlib.sha256(p.read_bytes()).hexdigest() for p in artifacts.iterdir() if p.is_file()}, 'attempts': []}

def save():
    (output / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')

def sample(folder):
    if (folder / 'samples.tsv').exists(): return folder / 'samples.tsv'
    paths = list((folder / 'benchmark-results').glob('*/bench-hashes.samples.tsv'))
    assert len(paths) == 1
    return paths[0]

def compare(name, old, new):
    with (output / (name + '.txt')).open('wb') as out:
        subprocess.run([str(bench), 'compare'] + [str(sample(p)) for p in old] + ['--'] + [str(sample(p)) for p in new], stdout=out, stderr=subprocess.STDOUT, check=True)

save()
for kind, cpu in [('probe', 0), ('probe', 16), ('bench', None)]:
    label = kind + ('-cpu%d' % cpu if cpu is not None else '-default')
    sides = {'old': [], 'new': []}
    for position, side in enumerate(['old', 'new', 'new', 'old'], 1):
        folder = output / ('%s-%d-%s' % (label, position, side))
        folder.mkdir()
        command = (['taskset', '-c', str(cpu)] if cpu is not None else []) + [str(artifacts / (kind + '-' + side))]
        if kind == 'probe':
            command += ['7c18ec1' if side == 'old' else 'fea805e']
        else:
            # Entire frozen point roster, including after-gap and shared cells.
            command += ['batches', '--rounds', '24']
        row = {'kind': kind, 'cpu': cpu, 'position': position, 'side': side, 'command': command, 'folder': folder.name}
        manifest['attempts'].append(row); save()
        row['exit'] = subprocess.run([sys.executable, str(supervisor), '180', str(folder / 'bounded')] + command, cwd=folder).returncode
        save()
        assert row['exit'] == 0, row
        if kind == 'probe':
            (folder / 'samples.tsv').write_bytes((folder / 'bounded.stdout.txt').read_bytes())
        sides[side].append(folder)
    compare(label + '-effect', sides['old'], sides['new'])
    for side in sides:
        compare(label + '-' + side + '-repeat', sides[side][:1], sides[side][1:])
    for pair, (a, b) in enumerate(zip(sides['old'], sides['new']), 1):
        compare(label + '-pair%d' % pair, [a], [b])
assert manifest['artifacts'] == {p.name: hashlib.sha256(p.read_bytes()).hexdigest() for p in artifacts.iterdir() if p.is_file()}
print('Retained 12 fresh runs; Rust computed every comparison.')
