#!/usr/bin/env python3
"""Copy completed local bundles and replay standard comparisons through Rust.
Supply completed Mac job prefixes as arguments. Keep retried attempts intact.
"""
from pathlib import Path
import shutil
import subprocess
import sys

h = Path('/home/agent')
out = h / 'bench-hashes-data/2026-11-14/incremental-lifetime'
evidence = h / 'bench-hashes-validation/incremental-lifetime'
reader = h / 'bench-incremental-lifetime/target/release/bench-hashes'

def copy(source, dest):
    for p in source.rglob('*'):
        if p.is_file() and p.suffix in {'.txt', '.log', '.tsv', '.json', '.sh', '.html', '.svg', '.md'}:
            target = dest / p.relative_to(source)
            target.parent.mkdir(parents=True, exist_ok=True)
            shutil.copyfile(p, target)

pilot = h / 'bench-hashes-validation/inbox/x86-epyc-9275f/incremental-pilot-2c867684'
copy(pilot, out / 'x86-epyc-9275f/pilot')
copy(h / 'bench-hashes-validation/inbox/x86-workhorse/incremental-tests-2c867684', out / 'workhorse')
cases = [(out / 'x86-epyc-9275f/pilot', f'kept-{name}', f'{name}.stdout.txt') for name in ['samecode', 'harness', 'finalize']]
for run, name in [
    ('incremental-snapshot-2c867684', 'snapshot'),
    ('incremental-shared-followup-2c867684', 'shared-followup'),
    ('incremental-callers-2c867684', 'callers'),
]:
    source = h / 'bench-hashes-validation/inbox/x86-epyc-9275f' / run
    assert (source / 'stdout.txt').is_file(), source
    copy(source, out / 'x86-epyc-9275f' / name)
for name in ['samecode-common', 'harness-repeat']:
    cases.append((out / 'x86-epyc-9275f/shared-followup', f'kept-{name}', f'{name}.stdout.txt'))
for prefix in sys.argv[1:]:
    found = list((h / 'mac-runner/results').glob(prefix + '.*'))
    assert len(found) == 1 and (found[0] / 'verdict.json').is_file(), prefix
    dest = out / 'apple-m6' / found[0].name
    copy(found[0], dest)
    cases.append((dest, 'samples', 'runner.log'))
for path, kept, original in cases:
    old = sorted((path / kept).glob('run-*-old.tsv'))
    new = sorted((path / kept).glob('run-*-new.tsv'))
    assert len(old) == len(new) == 4, (path, len(old), len(new))
    args = [*[str(p.relative_to(out)) for p in old], '--', *[str(p.relative_to(out)) for p in new]]
    result = subprocess.run([str(reader), 'compare', *args], cwd=out, capture_output=True, text=True, check=True, timeout=30)
    raw = (path / original).read_text()
    assert result.stdout == raw[raw.index('compare: old side:'):], path
    (path / kept / 'replayed.txt').write_text(result.stdout)
    (path / kept / 'replayed.stderr.txt').write_text(result.stderr)
    result = subprocess.run([str(reader), 'compare', '--markdown', *args], cwd=out, capture_output=True, text=True, check=True, timeout=30)
    (path / kept / 'comparison.md').write_text(result.stdout)
    print(path.relative_to(out), kept, 'replayed byte for byte')
for p in evidence.iterdir():
    if p.is_file() and (p.suffix == '.sh' or p.name in ['plan.md', 'shared-followup-plan.md', 'archive.py']):
        target = out / 'code' / p.name
        target.parent.mkdir(parents=True, exist_ok=True)
        shutil.copyfile(p, target)
    elif p.is_file() and (p.name.endswith('.stdout.txt') or p.name.endswith('.stderr.txt')):
        target = out / 'validation' / p.name
        target.parent.mkdir(parents=True, exist_ok=True)
        shutil.copyfile(p, target)
