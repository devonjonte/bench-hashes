#!/usr/bin/env python3
"""Descriptive per-cell null envelope through shared readers/speed rules.

All six process-pair comparisons within each retained exact-artifact ABBA
block contribute. This observed envelope is neither a confidence bound nor
an empirical gate verdict. Split identity across processes remains open.
"""
import argparse
from fractions import Fraction
import hashlib
import importlib.util
import itertools
import json
from pathlib import Path
import sys


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('results', type=Path)
    parser.add_argument('--rules', type=Path, required=True, help='fork tools/speeds.py')
    parser.add_argument('--gate', type=Path, required=True, help='historical gate with margins for these workloads')
    parser.add_argument('--artifact', type=Path, help='optionally verify the retained executable')
    args = parser.parse_args()
    sys.path.insert(0, str(args.rules.resolve().parent))
    spec = importlib.util.spec_from_file_location('speed_rule', args.rules)
    speeds = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(speeds)
    import samples
    spec = importlib.util.spec_from_file_location('historical_gate', args.gate)
    gate = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(gate)
    manifest = json.loads((args.results / 'manifest.json').read_text())
    assert all(r['sha256'] == manifest['sha256'] and r['exit'] == 0 for r in manifest['runs'])
    if args.artifact:
        assert hashlib.sha256(args.artifact.read_bytes()).hexdigest() == manifest['sha256']
    envelopes = {}
    coverage = []
    for block, _ in manifest['blocks']:
        runs = [samples.read(args.results / block / name / 'samples.tsv')
                for name in ['old-1', 'new-1', 'new-2', 'old-2']]
        assert all(set(r.cells) == set(runs[0].cells) for r in runs)
        coverage.append({'block': block, 'processes': len(runs), 'busy': sum(r.busy for r in runs),
                         'unobserved': sum(not r.windows for r in runs)})
        for key in runs[0].cells:
            entry = envelopes.setdefault(key, {'fast': Fraction(0), 'slow': Fraction(0),
                                               'slow_comparisons': 0, 'split_mismatches': 0,
                                               'share_range': [1000, 0], 'largest_fast_pair': None})
            for i, j in itertools.combinations(range(4), 2):
                c = speeds.compare(runs[i].cells[key], runs[j].cells[key])
                entry['split_mismatches'] += len(c['old']) != len(c['new'])
                for speed, index in [('fast', 0), ('slow', 1)]:
                    if min(len(c['old']), len(c['new'])) <= index:
                        continue
                    ratio = c['new'][index][0] / c['old'][index][0]
                    assert ratio > 0, 'a multiplicative envelope requires positive medians'
                    deviation = max(ratio, 1 / ratio) - 1
                    if deviation > entry[speed]:
                        entry[speed] = deviation
                        if speed == 'fast':
                            entry['largest_fast_pair'] = [block, i + 1, j + 1]
                    if speed == 'slow':
                        entry['slow_comparisons'] += 1
                for share in [c['old_slow_share_permille'], c['new_slow_share_permille']]:
                    entry['share_range'][0] = min(entry['share_range'][0], share)
                    entry['share_range'][1] = max(entry['share_range'][1], share)
    cells = []
    for key, entry in sorted(envelopes.items()):
        m = gate.margin(key[1], key[2])
        cells.append({'key': list(key), 'gate_numeric_margin': str(m),
                      'observed_fast_envelope': str(entry['fast']),
                      'observed_slow_envelope': str(entry['slow']) if entry['slow_comparisons'] else None,
                      'fast_margin_budgets': str(entry['fast'] / m),
                      'slow_margin_budgets': str(entry['slow'] / m) if entry['slow_comparisons'] else None,
                      'split_mismatches': entry['split_mismatches'],
                      'slow_comparisons': entry['slow_comparisons'],
                      'slow_share_range_permille': entry['share_range'],
                      'largest_fast_pair': entry['largest_fast_pair']})
    print(json.dumps({'artifact_sha256': manifest['sha256'],
                      'margin_source_sha256': hashlib.sha256(args.gate.read_bytes()).hexdigest(), 'coverage': coverage,
                      'scope': 'observed cross-process envelope; no confidence bound or gate verdict',
                      'cells': cells}, indent=2))


if __name__ == '__main__':
    main()
