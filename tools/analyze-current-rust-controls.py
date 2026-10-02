#!/usr/bin/env pypy3
"""Summarize Rust comparison/verdict text; never decode samples or duplicate speed rules."""
import argparse
import json
from pathlib import Path
import re


def ratios(text):
    return {key: int(whole) * 1000 + int(frac) for key, whole, frac in
            re.findall(r'^([^\n]+?): .*?\[fast x(\d+)\.(\d{3}),', text, re.M)}


def analyze(root):
    calibration = {}
    for level, blocks in [(3, [3, 5, 7, 9]), (6, [4, 6, 8, 10])]:
        calibration[level] = {}
        for size in [64, 2048, 102400]:
            key = 'blake3-servil-st|solo|PositiveWorkControl|%d B' % size
            values = [ratios((root / 'calibration' / ('block-%02d-effect.txt' % b)).read_text())[key] for b in blocks]
            ordered = sorted(values)
            numerator = ordered[1] + ordered[2]
            low, high = (1027, 1033) if level == 3 else (1054, 1066)
            calibration[level][size] = {'block_fast_permille': values,
                'median_permille_numerator': numerator, 'median_permille_denominator': 2,
                'qualified': 2 * low <= numerator <= 2 * high}
    checks = []
    manifest = json.loads((root / 'pilot/manifest.json').read_text())
    for index, attempt in enumerate(manifest['attempts'], 1):
        folder = root / 'pilot' / ('check-%02d' % index)
        verdict = (folder / 'bounded.stdout.txt').read_text()
        runs = sorted(folder.glob('run-*'))
        confirmed = re.findall(r'^  (blake3-servil-st\|solo\|PositiveWorkControl\|\d+ B):', verdict, re.M)
        faster = re.findall(r'^  faster  (\S+):', verdict, re.M)
        pairs = []
        for pair in range(len(runs) // 2):
            text = (root / 'pilot' / ('check-%02d-pair-%02d.txt' % (index, pair + 1))).read_text()
            pairs.append(ratios(text))
        checks.append({'index': index, 'extra': attempt['extra'], 'production': attempt['production'],
            'batches': attempt['batches'], 'workers': attempt['workers'], 'exit': attempt['exit'],
            'processes': len(runs), 'confirmed': confirmed, 'faster': faster, 'pair_fast_permille': pairs})
    detections = {level: {size: sum('blake3-servil-st|solo|PositiveWorkControl|%d B' % size in c['confirmed']
                                 for c in checks if c['extra'] == level)
                          for size in [64, 2048, 102400]} for level in [3, 6, 100]}
    accounts = [json.loads(p.read_text()) for p in root.glob('calibration/*/accounting-check.json')]
    accounts += [json.loads(p.read_text()) for p in root.glob('pilot/check-*/run-*/accounting-check.json')]
    assert all(a['pass'] for a in accounts)
    return {'decision': 'NO-GO', 'calibration': calibration, 'detections': detections, 'checks': checks,
            'work_accounting': {'processes': len(accounts), 'cells': sum(a['cells'] for a in accounts),
                                'measured_batches': sum(a['batches'] for a in accounts)}}


if __name__ == '__main__':
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('root', type=Path)
    a = p.parse_args()
    result = analyze(a.root)
    (a.root / 'summary.json').write_text(json.dumps(result, indent=2) + '\n')
    print(json.dumps({k: v for k, v in result.items() if k != 'checks'}, indent=2))
