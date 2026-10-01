#!/usr/bin/env python3
"""Deterministic decision controls using the fork's actual regression gate.

Only builds and process execution are replaced. parse, pairs, judge, compare,
load handling and shared speed rules execute unchanged. These are decision
contract checks, separate from empirical false-verdict calibration.
"""
import argparse
import contextlib
import hashlib
import importlib.util
import io
import json
from pathlib import Path
import sys
from unittest.mock import patch


def exercise(gate, name):
    gate.BUSY_RUNS.clear()
    gate.POWER_SEEN.clear()
    if hasattr(gate, 'UNOBSERVED_RUNS'):
        gate.UNOBSERVED_RUNS.clear()
    continuous = 'ContinuousBatches'
    use_case = 'OneMessage' if name == 'after-gap-slow-only' else continuous
    target = '64 B' if use_case == 'OneMessage' else '16'
    neighbor = 'lent 1 MiB'
    initial = [gate.argument(use_case, target), neighbor]
    calls = []

    def run(side, points):
        confirmation = len(calls) >= 8
        unknown = (name == 'missing-initial' or
                   name == 'missing-confirmation' and confirmation)
        busy = name == 'busy-initial'
        load = 'not measured on this platform' if unknown else 'busy' if busy else 'quiet'
        text = ('# bench-hashes samples v4\n# power: mains power\n'
                f'# load: {load}\n')
        if not unknown:
            text += ('# load windows (start ms-end ms:other milli-CPUs:steal milli-CPUs): '
                     f'0-1000:{1200 if busy else 0}:0\n')
        text += 'contender\tscenario\tuse_case\tpoint\tunit\tns/units\tstart ms\n'
        for point in points:
            case, label = (use_case, target) if point == initial[0] else ('LentMessages', '1 MiB')
            for contender in [gate.CONTROL, gate.SUBJECTS[0]]:
                scenario = 'shared' if name == 'shared-positive' else 'solo'
                value = 100
                if side == 'new':
                    if contender == gate.CONTROL and name == 'control-moved':
                        value = 120
                    if contender != gate.CONTROL:
                        if name in {'positive', 'shared-positive', 'missing-confirmation'}:
                            value = 120
                        if name == 'narrow-confirmation' and point == initial[0] and neighbor in points:
                            value = 120
                        if name == 'narrow-confirmation' and point == neighbor:
                            value = 80  # retains the neighbor through the initial stage
                values = [value] * 24
                if name == 'after-gap-slow-only' and contender != gate.CONTROL and point == initial[0]:
                    values = [100] * 12 + [300 if side == 'new' else 200] * 12
                text += (f'{contender}\t{scenario}\t{case}\t{label}\tB\t' +
                         ','.join(f'{v}/1' for v in values) + '\t' + ','.join(['0'] * 24) + '\n')
        calls.append({'side': side, 'points': list(points), 'load': load})
        return gate.parse(text)

    stdout, stderr = io.StringIO(), io.StringIO()
    with patch.object(gate, 'side_bench', side_effect=lambda side, rev: (side, set())), \
         patch.object(gate, 'points_of', return_value=initial), \
         patch.object(gate, 'run', side_effect=run), \
         contextlib.redirect_stdout(stdout), contextlib.redirect_stderr(stderr):
        code = gate.compare('old-revision', 'new-revision')
    return {'case': name, 'exit': code, 'requests': calls,
            'stdout': stdout.getvalue(), 'stderr': stderr.getvalue()}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--gate', type=Path, required=True)
    args = parser.parse_args()
    sys.path.insert(0, str(args.gate.resolve().parent))
    spec = importlib.util.spec_from_file_location('audited_gate', args.gate)
    gate = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(gate)
    cases = ['null', 'positive', 'shared-positive', 'control-moved', 'busy-initial',
             'missing-initial', 'missing-confirmation', 'narrow-confirmation', 'after-gap-slow-only']
    print(json.dumps({'gate_sha256': hashlib.sha256(args.gate.read_bytes()).hexdigest(),
                      'scope': 'deterministic decision controls; no timed measurements',
                      'results': [exercise(gate, name) for name in cases]}, indent=2))


if __name__ == '__main__':
    main()
