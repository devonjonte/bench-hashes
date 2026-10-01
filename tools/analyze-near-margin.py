#!/usr/bin/env pypy3
"""Audit near-margin records using the actual gate and shared work checker."""
import argparse
from fractions import Fraction
import importlib.util
import json
from pathlib import Path
import sys


def module(name, path):
    spec = importlib.util.spec_from_file_location(name, path)
    value = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(value)
    return value


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--gate', type=Path, required=True)
    p.add_argument('--calibration', type=Path, required=True)
    p.add_argument('--pilot', type=Path)
    args = p.parse_args()
    sys.path.insert(0, str(args.gate.resolve().parent))
    gate = module('actual_gate', args.gate)
    checker = module('work_checker', Path(__file__).with_name('check-work-control.py'))
    reader = args.gate.resolve().with_name('samples.py')
    plan = json.loads((args.calibration / 'manifest.json').read_text())
    by_level = {}
    checks = []
    for i in range(0, len(plan['attempts']), 4):
        block = plan['attempts'][i:i+4]
        assert [r['side'] for r in block] == ['old', 'new', 'new', 'old']
        parsed = []
        for row in block:
            assert row['exit'] == 0, 'retain incomplete attempt; calibration cannot qualify'
            folder = args.calibration / row['folder']
            account = checker.check(folder, reader)
            run = gate.samples.read(folder / 'samples.tsv')
            account.update({'folder': row['folder'], 'starts_observed': run.sample_starts_observed})
            checks.append(account)
            parsed.append(gate.parse((folder / 'samples.tsv').read_text()))
        pairs = [(parsed[0], parsed[1]), (parsed[3], parsed[2])]
        level = block[0]['level']
        cells = by_level.setdefault(level, {})
        for key in parsed[0]:
            cells.setdefault(key, []).extend(gate.ratios_of(pairs, key))
    results = {}
    for level, cells in by_level.items():
        results[level] = {key: {'pair_ratios': [str(v) for v in ratios],
                               'median_ratio': str(gate.statistics.median(ratios))}
                          for key, ratios in cells.items()}
    covered = all(r['starts_observed'] and not r['busy'] for r in checks)
    eligibility = {}
    for level in [3, 6]:
        eligibility[level] = {key: covered and Fraction(level * 9, 1000) <= gate.statistics.median(ratios) - 1 <= Fraction(level * 11, 1000)
                              for key, ratios in by_level[level].items() if key.startswith('blake3-servil-st|')}
    output = {'calibration': results, 'accounting': checks, 'calibration_eligible': eligibility,
              'scope': 'diagnostic direct caller; not acceptance or full interval certification'}
    if args.pilot:
        pilot = json.loads((args.pilot / 'manifest.json').read_text())
        attempts = []
        for row in pilot['attempts']:
            folder = args.pilot / row['folder']
            record = json.loads((folder / 'manifest.json').read_text())
            subject = [j for j in record['judgments'] if 'blake3-servil-st' in j['contenders']]
            detection = sorted(set(subject[0]['slower']) & set(subject[1]['slower'])) if len(subject) == 2 and row['exit'] == 1 else []
            parsed = []
            run_checks = []
            for process in record['runs']:
                run_folder = folder / process['folder']
                account = checker.check(run_folder, reader)
                run = gate.samples.read(run_folder / 'samples.tsv')
                account['starts_observed'] = run.sample_starts_observed
                run_checks.append(account)
                parsed.append(gate.parse((run_folder / 'samples.tsv').read_text()))
            pair_data = []
            for i in range(0, len(parsed), 2):
                # Actual driver uses AB, BA alternation in both stages.
                pair_data.append((parsed[i], parsed[i+1]) if (i // 2) % 2 == 0 else (parsed[i+1], parsed[i]))
            stages = []
            for start in range(0, len(pair_data), gate.PAIRS):
                pairs = pair_data[start:start+gate.PAIRS]
                stages.append({key: [str(v) for v in gate.ratios_of(pairs, key)] for key in pairs[0][0]})
            attempts.append({**row, 'stages': stages, 'run_accounting': run_checks,
                             'initial_slower': subject[0]['slower'] if subject else [],
                             'confirmed': detection,
                             'faster': [k for j in subject for k in j['faster']],
                             'processes': len(record['runs'])})
        output['pilot'] = attempts
        output['detections'] = {level: {key: sum(key in r['confirmed'] for r in attempts if r['level'] == level)
                                        for key in eligibility[level]} for level in [3, 6]}
    print(json.dumps(output, indent=2))


if __name__ == '__main__':
    main()
