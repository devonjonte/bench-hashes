#!/usr/bin/env pypy3
"""Check direct work-control counters/trace against the shared raw reader.

This validates recorded work including calibration and actual observer counts;
it supplies neither load nor speed verdicts. Correctness anchors run in the
caller before measurement. Production benchmark timing is unchanged.
"""
import argparse
import csv
import importlib.util
import json
from pathlib import Path


def check(folder, reader):
    spec = importlib.util.spec_from_file_location('shared_samples', reader)
    samples = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(samples)
    run = samples.read(folder / 'samples.tsv')
    with (folder / 'accounting.csv').open() as stream:
        accounting = list(csv.DictReader(stream))
    with (folder / 'clocks.csv').open() as stream:
        trace = list(csv.DictReader(stream))
    expected_keys = {(r['contender'], 'solo', 'PositiveWorkControl', r['length'] + ' B') for r in accounting}
    assert expected_keys == set(run.cells) and len(accounting) == len(expected_keys), 'exactly one accounting row per cell'
    checked = set()
    total = 0
    for row in accounting:
        key = (row['contender'], 'solo', 'PositiveWorkControl', row['length'] + ' B')
        calls, batches, factor, completed = (int(row[k]) for k in
            ['calls_per_batch', 'measured_batches', 'factor', 'completed_including_calibration'])
        assert calls > 0 and batches > 0 and factor in (1, 2)
        assert completed == (batches + 1) * calls * factor, 'all completions including calibration'
        readings = run.measured[key]
        assert len(readings) == batches and run.units[key] == 'call'
        selected = [(i, r) for i, r in enumerate(trace) if r['contender'] == row['contender'] and r['length'] == row['length']]
        assert len(selected) == batches, 'one trace row per batch'
        for sample, ((index, t), (ns, units)) in enumerate(zip(selected, readings)):
            assert index not in checked
            checked.add(index)
            assert int(t['sample']) == sample
            assert int(t['factor']) == factor and int(t['calls']) == calls
            assert int(t['completed_hashes']) == calls * factor, 'observed hashes per logical request'
            assert (int(t['wall_ns']), int(t['calls'])) == (ns, units), 'exact recorded ns/work'
        total += completed
    assert len(checked) == len(trace), 'all trace rows checked'
    return {'cells': len(accounting), 'batches': len(trace), 'completed_including_calibration': total,
            'load_windows': len(run.windows), 'busy': run.busy}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('folder', type=Path)
    parser.add_argument('--reader', type=Path, required=True)
    args = parser.parse_args()
    print(json.dumps(check(args.folder, args.reader), indent=2))


if __name__ == '__main__':
    main()
