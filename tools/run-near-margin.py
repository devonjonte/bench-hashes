#!/usr/bin/env pypy3
"""Execute the predeclared near-margin plan with bounded process supervision.

Collection only: measurements, decoding and decisions remain in clocks/the gate.
Use a new output directory for each stage; every attempt is retained.
"""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess
import sys


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--stage', choices=['calibration', 'pilot'], required=True)
    p.add_argument('--exe', type=Path, required=True)
    p.add_argument('--gate', type=Path, required=True)
    p.add_argument('--supervisor', type=Path, required=True)
    p.add_argument('--output', type=Path, required=True)
    args = p.parse_args()
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    artifact = args.exe.resolve()
    gate = args.gate.resolve()
    supervisor = args.supervisor.resolve()
    manifest = {'stage': args.stage, 'plan': 'audit/near-margin-plan.md',
                'artifact_sha256': hashlib.sha256(artifact.read_bytes()).hexdigest(),
                'gate_sha256': hashlib.sha256(gate.read_bytes()).hexdigest(),
                'deadline_seconds': 120, 'attempts': []}
    def save():
        (args.output / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
    save()
    if args.stage == 'calibration':
        levels = [0, 100] + [3, 6] * 4
        for block, level in enumerate(levels):
            for position, side in enumerate(['old', 'new', 'new', 'old']):
                folder = args.output / f'block-{block+1:02}-run-{position+1}'
                folder.mkdir()
                extra = level if side == 'new' else 0
                row = {'block': block, 'level': level, 'side': side, 'extra': extra, 'folder': folder.name}
                manifest['attempts'].append(row); save()
                cmd = [sys.executable, str(supervisor), '120', str(folder / 'process'), str(artifact), str(extra), '128', '0']
                row['exit'] = subprocess.run(cmd, cwd=folder).returncode
                (folder / 'samples.tsv').write_bytes((folder / 'process.stdout.txt').read_bytes())
                save()
    else:
        settings = [(0, 128, 0)] * 4 + [(100, 128, 0)] + [(n, 128, 0) for _ in range(8) for n in [3, 6]] + [(0, 8, 0), (0, 128, 2)]
        helper = Path(__file__).with_name('run-gate-work-control.py').resolve()
        for i, (level, batches, workers) in enumerate(settings):
            folder = args.output / f'check-{i+1:02}'
            row = {'level': level, 'batches': batches, 'workers': workers, 'folder': folder.name}
            manifest['attempts'].append(row); save()
            cmd = [sys.executable, str(supervisor), '120', str(args.output / f'check-{i+1:02}'),
                   sys.executable, str(helper), '--gate', str(gate), '--exe', str(artifact),
                   '--output', str(folder), '--extra-per100', str(level), '--batches', str(batches), '--busy-workers', str(workers)]
            row['exit'] = subprocess.run(cmd).returncode
            save()
    assert hashlib.sha256(artifact.read_bytes()).hexdigest() == manifest['artifact_sha256']
    print(f"Retained {len(manifest['attempts'])} {args.stage} attempts")


if __name__ == '__main__':
    main()
