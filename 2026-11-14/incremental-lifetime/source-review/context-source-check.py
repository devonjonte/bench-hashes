#!/usr/bin/env python3
"""Inspect source and run configuration only; never read measurement rows."""
import hashlib
import json
from pathlib import Path
import subprocess
import sys

repo, evidence = map(Path, sys.argv[1:])
old = '8d9eb92ada887ed57b4d2102d3f913344067f84a'
new = '2c8676842feab053fa7855d4cb3393bdea26ed4a'
sources = [subprocess.check_output(['git', 'show', f'{c}:src/main.rs'], cwd=repo, text=True) for c in [old, new]]

def between(text, start, end):
    at = text.index(start)
    return text[at:text.index(end, at)]

def digest(text):
    return {'sha256': hashlib.sha256(text.encode()).hexdigest(),
            'blake3': subprocess.check_output(['b3sum', '--no-names'], input=text, text=True).strip()}

blocks = {}
for start, end in [
    ('impl Roster {', 'fn participating_orders('),
    ('fn participating_orders(', 'enum Selection {'),
    ('fn measure_all(', "struct Progress<'a>"),
    ('enum Placement {', 'struct Cell {'),
    ('struct Topology {', 'struct MachineMetadata {'),
    ('struct Duo {', 'struct Power {'),
    ('fn cell_wants_sample(', 'fn continuous_min_inputs('),
]:
    a, b = [between(s, start, end) for s in sources]
    assert a == b, start
    blocks[start] = {'unchanged_bytes': len(a.encode()), **digest(a)}

for start, end in [('const POINTS:', '\n];'), ('    const ALL: [UseCase;', '\n    ];')]:
    arrays = [between(s, start, end).split('= [', 1)[1].strip() for s in sources]
    assert arrays[1].startswith(arrays[0]), start

keys = ['shared placements', 'contenders', 'rounds', 'nonstop train', 'points', 'rust compiler', 'target features', 'rustflags', 'build target']
configurations = []
for relative in ['pilot/kept-harness', 'shared-followup/kept-samecode-common', 'shared-followup/kept-harness-repeat']:
    folder = evidence / 'x86-epyc-9275f' / relative
    paths = sorted(folder.glob('run-*.tsv'))
    assert len(paths) == 8, (relative, len(paths))
    headers = []
    for p in paths:
        header = {}
        with p.open() as f:
            for line in f:
                if not line.startswith('#'): break
                if line.startswith('# ') and ': ' in line:
                    key, value = line[2:].rstrip('\n').split(': ', 1)
                    header[key] = value
        assert p.stem.endswith(('-old', '-new'))
        expected = new if p.stem.endswith('-new') or 'samecode' in relative else old
        assert header['git commit'] == expected
        for form in ['st', 'mt']:
            assert '; commit f62bc6ac0bc1c86861659d61ffbf4e9546bc8aec; clean' in header[f'source blake3-servil-{form}']
        headers.append(header)
    for a, b in zip(headers[::2], headers[1::2]):
        assert a['measuring thread'] == b['measuring thread']
    for header in headers:
        configurations.append({k: header[k] for k in keys})
    # This is a saved input setting, not a measured sample or statistic.
    settings = (folder/'sizes.tsv').read_text().splitlines()
    assert 'blake3-servil-mt\tcontinuous collection git objects\t1' in settings
assert all(c == configurations[0] for c in configurations)
print(json.dumps({'old': old, 'new': new, 'source_blocks': blocks,
                  'old_point_and_use_case_arrays_are_prefixes': True,
                  'accepted_run_headers_checked': len(configurations),
                  'common_configuration': configurations[0],
                  'git_collection_iterations': 1}, indent=2))
