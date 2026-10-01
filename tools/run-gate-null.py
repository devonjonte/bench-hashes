#!/usr/bin/env python3
"""Run the actual adaptive regression gate with one artifact on both sides.

External process-group supervision is required. The gate's original run,
parse, pairs, judge and compare execute unchanged. Builds return the selected
artifact; scratch directories remain on disk for examination.
"""
import argparse
import hashlib
import importlib.util
import json
from pathlib import Path
import sys
from unittest.mock import patch


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--gate', type=Path, required=True)
    parser.add_argument('--exe', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=False)
    sys.path.insert(0, str(args.gate.resolve().parent))
    spec = importlib.util.spec_from_file_location('audited_gate', args.gate)
    gate = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(gate)
    artifact = args.exe.resolve()
    manifest = {'artifact': str(artifact), 'artifact_sha256': hashlib.sha256(artifact.read_bytes()).hexdigest(),
                'gate': str(args.gate.resolve()), 'gate_sha256': hashlib.sha256(args.gate.read_bytes()).hexdigest(),
                'rounds': gate.ROUNDS, 'pairs_per_stage': gate.PAIRS,
                'points': gate.points_of(gate.USE_CASES), 'runs': []}
    def save():
        (args.output / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
    save()

    class RetainedDirectory:
        def __enter__(self):
            path = args.output.resolve() / f'run-{len(manifest["runs"]) + 1:02}'
            path.mkdir()
            manifest['runs'].append(str(path))
            save()
            return str(path)

        def __exit__(self, *exception):
            return False

    with patch.object(gate, 'side_bench', return_value=(str(artifact), set())), \
         patch.object(gate.tempfile, 'TemporaryDirectory', RetainedDirectory):
        code = gate.compare('same-artifact-A', 'same-artifact-B')
    manifest['exit'] = code
    assert hashlib.sha256(artifact.read_bytes()).hexdigest() == manifest['artifact_sha256']
    save()
    return code


if __name__ == '__main__':
    sys.exit(main())
