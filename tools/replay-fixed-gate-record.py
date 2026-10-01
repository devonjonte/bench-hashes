#!/usr/bin/env pypy3
"""Replay a retained fixed-context benchmark comparison through the actual gate.

Only builds and process execution are replaced by recorded sample files. The
current shared reader and actual pair/judgment/coverage policy execute. This
is a decision control, not a new timed measurement or speed interpretation.
"""
import argparse
import importlib.util
import json
from pathlib import Path
import sys
from unittest.mock import patch


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--gate', type=Path, required=True)
    parser.add_argument('--record', type=Path, required=True)
    args = parser.parse_args()
    sys.path.insert(0, str(args.gate.resolve().parent))
    spec = importlib.util.spec_from_file_location('audited_gate', args.gate)
    gate = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(gate)
    manifest = json.loads((args.record / 'manifest.json').read_text())
    files = [args.record / Path(name).name / 'bench-hashes.samples.tsv' for name in manifest['runs']]
    requests = []

    def run(side, points):
        i = len(requests)
        assert i < len(files), 'record contains every requested process'
        expected = 'old' if i % 4 in (0, 3) else 'new'
        assert side == expected, 'same alternating side order as the record'
        assert points == manifest['points'], 'replay retains the declared context'
        requests.append({'side': side, 'points': list(points), 'file': files[i].name})
        return gate.parse(files[i].read_text())

    with patch.object(gate, 'side_bench', side_effect=lambda side, revision: (side, set())), \
         patch.object(gate, 'points_of', return_value=manifest['points']), \
         patch.object(gate, 'run', side_effect=run):
        code = gate.compare('recorded old', 'recorded new')
    print(json.dumps({'exit': code, 'recorded_original_exit': manifest['exit'], 'requests': len(requests)}))
    return code


if __name__ == '__main__':
    sys.exit(main())
