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
    (inbox / 'pipeline-pilot-55436819', 'x86-epyc-9275f/pipeline-pilot-55436819', 'kept-samecode', 'samecode.stdout.txt'),
    (inbox / 'pipeline-pilot-55436819', 'x86-epyc-9275f/pipeline-pilot-55436819', 'kept-api-change', 'api-change.stdout.txt'),
    (inbox / 'pipeline-added-work-7090f6b1', 'x86-epyc-9275f/pipeline-added-work-7090f6b1', 'kept', 'check.stdout.txt'),
]
for job in ['3117-probe-pipeline-samecode', '3118-probe-pipeline-calls']:
    found = list((home / 'mac-runner/results').glob(job + '.*'))
    assert len(found) == 1, (job, found)
    cases.append((found[0], 'apple-m6/' + found[0].name, 'samples', 'runner.log'))
for source_root, dest_name in dict.fromkeys((s, d) for s, d, _, _ in cases):
    for source in source_root.rglob('*'):
        if source.is_file() and source.suffix in {'.sh', '.txt', '.tsv', '.json', '.log'}:
            dest = root / dest_name / source.relative_to(source_root)
            dest.parent.mkdir(parents=True, exist_ok=True)
            shutil.copyfile(source, dest)
for _, dest_name, kept, original in cases:
    path = root / dest_name
    # Only the four accepted pairs. Retried attempts remain in their original
    # subdirectory, with their load qualifications, outside this comparison.
    old = sorted((path / kept).glob('run-*-old.tsv'))
    new = sorted((path / kept).glob('run-*-new.tsv'))
    assert len(old) == len(new) == 4
    args = [*[str(p.relative_to(root)) for p in old], '--', *[str(p.relative_to(root)) for p in new]]
    result = subprocess.run([str(reader), 'compare', *args], cwd=root, text=True, capture_output=True, check=True, timeout=30)
    (path / kept / 'replayed.txt').write_text(result.stdout)
    (path / kept / 'replayed.stderr.txt').write_text(result.stderr)
    original_text = (path / original).read_text()
    original_comparison = original_text[original_text.index('compare: old side:'):]
    assert result.stdout == original_comparison, f'{dest_name}/{kept}: replay differs'
    result = subprocess.run([str(reader), 'compare', '--markdown', *args], cwd=root, text=True, capture_output=True, check=True, timeout=30)
    (path / kept / 'comparison.md').write_text(result.stdout)
    print(f'{dest_name}/{kept}: four pairs, original comparison reproduced byte for byte')
