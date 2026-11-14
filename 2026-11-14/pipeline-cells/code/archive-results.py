#!/usr/bin/env python3
"""Copy local deliveries and replay their comparisons through the Rust reader."""
from pathlib import Path
import shutil
import subprocess

home = Path('/home/agent')
root = home / 'bench-hashes-data/2026-11-14/pipeline-cells'
inbox = home / 'bench-hashes-validation/inbox/x86-epyc-9275f'
reader = home / 'bench-pipeline/target/release/bench-hashes'
cases = [
    ('pipeline-pilot-55436819', 'kept-samecode', 'samecode.stdout.txt'),
    ('pipeline-pilot-55436819', 'kept-api-change', 'api-change.stdout.txt'),
    ('pipeline-added-work-7090f6b1', 'kept', 'check.stdout.txt'),
]
for run in dict.fromkeys(run for run, _, _ in cases):
    for source in (inbox / run).rglob('*'):
        if source.is_file() and source.suffix in {'.sh', '.txt', '.tsv'}:
            dest = root / 'x86-epyc-9275f' / run / source.relative_to(inbox / run)
            dest.parent.mkdir(parents=True, exist_ok=True)
            shutil.copyfile(source, dest)
for run, kept, original in cases:
    path = root / 'x86-epyc-9275f' / run
    old = sorted((path / kept).glob('run-*-old.tsv'))
    new = sorted((path / kept).glob('run-*-new.tsv'))
    assert len(old) == len(new) == 4
    args = [*[str(p.relative_to(root)) for p in old], '--', *[str(p.relative_to(root)) for p in new]]
    result = subprocess.run([str(reader), 'compare', *args], cwd=root, text=True, capture_output=True, check=True, timeout=30)
    (path / kept / 'replayed.txt').write_text(result.stdout)
    (path / kept / 'replayed.stderr.txt').write_text(result.stderr)
    original_text = (path / original).read_text()
    original_comparison = original_text[original_text.index('compare: old side:'):]
    assert result.stdout == original_comparison, f'{run}/{kept}: replay differs'
    result = subprocess.run([str(reader), 'compare', '--markdown', *args], cwd=root, text=True, capture_output=True, check=True, timeout=30)
    (path / kept / 'comparison.md').write_text(result.stdout)
    print(f'{run}/{kept}: four pairs, original comparison reproduced byte for byte')
