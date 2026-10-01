#!/usr/bin/env pypy3
"""Run the actual gate on the output-observing direct work_control caller.

The control always completes one hash per request; the new subject completes
one or two. This validates a large-effect selected direct caller, not the
frozen harness, queue paths or near-margin sensitivity. External process-group
supervision is required. No timer, sample parser or statistic lives here.
"""
import argparse
import hashlib
import importlib.util
import json
from pathlib import Path
import subprocess
import sys
from unittest.mock import patch


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--gate', type=Path, required=True)
    parser.add_argument('--exe', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--new-factor', type=int, choices=[1, 2], required=True)
    parser.add_argument('--batches', type=int, default=128)
    args = parser.parse_args()
    assert args.batches > 0
    args.output.mkdir(parents=True, exist_ok=False)
    sys.path.insert(0, str(args.gate.resolve().parent))
    spec = importlib.util.spec_from_file_location('audited_gate', args.gate)
    gate = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(gate)
    artifact = args.exe.resolve()
    points = ['control 64 B', 'control 2048 B', 'control 102400 B']
    manifest = {'scope': 'direct caller; one/two actual hashes per logical request',
                'artifact_sha256': hashlib.sha256(artifact.read_bytes()).hexdigest(),
                'gate_sha256': hashlib.sha256(args.gate.read_bytes()).hexdigest(),
                'new_factor': args.new_factor, 'control_factor': 1, 'batches': args.batches,
                'points': points, 'runs': []}
    def save():
        (args.output / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
    save()

    def run(side, selected):
        # The caller always measures its declared three sizes; only a fixed
        # context gate is appropriate for this direct-caller control.
        assert selected == points, 'the gate retained the declared direct-caller context'
        factor = args.new_factor if side == 'new' else 1
        folder = args.output.resolve() / f'run-{len(manifest["runs"]) + 1:02}'
        folder.mkdir()
        manifest['runs'].append({'folder': folder.name, 'side': side, 'subject_factor': factor,
                                 'points': list(selected)})
        save()
        with (folder / 'samples.tsv').open('w') as stdout, (folder / 'stderr.txt').open('w') as stderr:
            subprocess.run([str(artifact), str(factor), str(args.batches), '1'], cwd=folder,
                           stdout=stdout, stderr=stderr, check=True)
        return gate.parse((folder / 'samples.tsv').read_text())

    with patch.object(gate, 'side_bench', side_effect=lambda side, revision: (side, set())), \
         patch.object(gate, 'points_of', return_value=points), \
         patch.object(gate, 'USE_CASES', {'PositiveWorkControl'}), \
         patch.dict(gate.PREFIX, {'PositiveWorkControl': 'control '}), \
         patch.object(gate, 'run', side_effect=run):
        code = gate.compare('one completed hash', f'{args.new_factor} completed subject hashes')
    manifest['exit'] = code
    assert hashlib.sha256(artifact.read_bytes()).hexdigest() == manifest['artifact_sha256']
    save()
    return code


if __name__ == '__main__':
    sys.exit(main())
