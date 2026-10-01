#!/usr/bin/env pypy3
"""Run the actual gate on the output-observing direct work_control caller.

Each block completes 100 base hashes plus a declared number of extra hashes.
This tests selected direct callers; calibration establishes the timing effect
separately from the known hashing-work fraction. Frozen/queued/shared paths
remain separate scope. Accounting/CLI contract v2 requires the matching caller. External process-group
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
    parser.add_argument('--extra-per100', type=int, choices=range(101), required=True)
    parser.add_argument('--batches', type=int, default=128)
    parser.add_argument('--busy-workers', type=int, choices=[0, 2], default=0,
                        help='two external CPU workers for a busy-load rejection control')
    args = parser.parse_args()
    assert args.batches > 0
    args.output.mkdir(parents=True, exist_ok=False)
    sys.path.insert(0, str(args.gate.resolve().parent))
    spec = importlib.util.spec_from_file_location('audited_gate', args.gate)
    gate = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(gate)
    artifact = args.exe.resolve()
    points = ['control 64 B', 'control 2048 B', 'control 102400 B']
    manifest = {'scope': 'direct caller; 100 logical requests plus extra observed hashes per block',
                'work_control_version': 2,
                'artifact_sha256': hashlib.sha256(artifact.read_bytes()).hexdigest(),
                'gate_sha256': hashlib.sha256(args.gate.read_bytes()).hexdigest(),
                'subject_extra_per100': args.extra_per100, 'control_extra_per100': 0, 'batches': args.batches,
                'external_busy_workers': args.busy_workers,
                'points': points, 'runs': [], 'judgments': []}
    def save():
        (args.output / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
    save()

    def run(side, selected):
        # The caller always measures its declared three sizes; only a fixed
        # context gate is appropriate for this direct-caller control.
        assert selected == points, 'the gate retained the declared direct-caller context'
        extra = args.extra_per100 if side == 'new' else 0
        folder = args.output.resolve() / f'run-{len(manifest["runs"]) + 1:02}'
        folder.mkdir()
        manifest['runs'].append({'folder': folder.name, 'side': side, 'subject_extra_per100': extra,
                                 'points': list(selected)})
        save()
        with (folder / 'samples.tsv').open('w') as stdout, (folder / 'stderr.txt').open('w') as stderr:
            subprocess.run([str(artifact), str(extra), str(args.batches), '0'], cwd=folder,
                           stdout=stdout, stderr=stderr, check=True)
        text = (folder / 'samples.tsv').read_text()
        assert gate.samples.read(text).meta['work control version'] == '2', 'matching caller contract required'
        return gate.parse(text)

    original_judge = gate.judge

    def judge(measured, use_cases, contenders):
        result = original_judge(measured, use_cases, contenders)
        manifest['judgments'].append({'contenders': list(contenders), 'pairs': len(measured),
                                      'slower': result[0], 'faster': result[1],
                                      'ratios': {k: str(v) for k, v in result[2].items()},
                                      'q90_ratios': {k: str(v) for k, v in result[3].items()}})
        save()
        return result

    workers = []
    try:
        for _ in range(args.busy_workers):
            # Liveness is bounded by the external process-group supervisor.
            # These untimed workers generate other load; clocks in the caller
            # supply every observation/classification of that load.
            workers.append(subprocess.Popen([sys.executable, '-c', 'while True: pass'],
                                             stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL))
        with patch.object(gate, 'side_bench', side_effect=lambda side, revision: (side, set())), \
             patch.object(gate, 'points_of', return_value=points), \
             patch.object(gate, 'USE_CASES', {'PositiveWorkControl'}), \
             patch.dict(gate.PREFIX, {'PositiveWorkControl': 'control '}), \
             patch.object(gate, 'run', side_effect=run), \
             patch.object(gate, 'judge', side_effect=judge):
            code = gate.compare('100 completed hashes per block', f'{100 + args.extra_per100} completed subject hashes per block')
    finally:
        for worker in workers:
            worker.terminate()
        for worker in workers:
            try:
                worker.wait(timeout=5)
            except subprocess.TimeoutExpired:
                worker.kill()
                worker.wait()
    manifest['exit'] = code
    assert hashlib.sha256(artifact.read_bytes()).hexdigest() == manifest['artifact_sha256']
    save()
    return code


if __name__ == '__main__':
    sys.exit(main())
