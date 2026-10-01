#!/usr/bin/env python3
"""Audit existing clock traces against v4 samples using the shared reader.

Checks recorded dispatch order, complete-cycle balance, exact wall/work
accounting, and sample multiplicity. No timing or speed rule is implemented.
The trace covers sampled dispatches; calibration and individual internal
hash calls are outside its scope. --explicit-rounds distinguishes sampling
modes; the samples metadata alone does not encode that distinction.
"""
import argparse
import csv
import importlib.util
import json
from collections import Counter, defaultdict
from pathlib import Path

CASES = ['OneMessage', 'ManyMessages', 'IdleOneMessage', 'IdleManyMessages',
         'ContinuousMessages', 'ContinuousBatches', 'LentMessages', 'LentPieces', 'LentBatches']
BATCH = {'ManyMessages', 'IdleManyMessages', 'ContinuousBatches', 'LentBatches'}
SHARED = set(CASES[4:])
PHASE = {c: (0 if c in SHARED else 2 if c.startswith('Idle') else 1) for c in CASES}


def payload_bytes(case, label):
    if case in BATCH:
        return int(label) * 64
    amount, unit = label.split()
    return int(amount) * {'B': 1, 'KiB': 1024, 'MiB': 1024 ** 2}[unit]


def participants(roster, case):
    excluded = set()
    if case in BATCH:
        excluded.add('blake3-official-mt')
    if case in {'ContinuousMessages', 'ContinuousBatches'}:
        excluded.add('blake3-servil-st')
    return [a for a in roster if a not in excluded]


def check(run, trace, explicit_rounds=False):
    assert hasattr(run, 'measured'), 'use the shared samples reader with unreduced measured pairs'
    selected = run.meta['contenders']
    if selected.startswith('--contenders '):
        roster = selected.removeprefix('--contenders ').split(',')
    elif selected == 'the default contenders':
        roster = ['blake3-servil-st', 'blake3-servil-mt', 'sha256', 'sha256-ring']
    else:
        assert selected == 'every contender available on this machine but those run on request', selected
        roster = run.order
    rounds = int(run.meta['rounds'])
    label_for = {}
    for a, scenario, case, label in run.cells:
        assert a in roster and case in CASES
        ident = (case, payload_bytes(case, label))
        if ident in label_for:
            assert label_for[ident] == label, 'one label per use case and size'
        label_for[ident] = label
    points = sorted(label_for, key=lambda p: (CASES.index(p[0]), p[1]))
    point_index = {p: i for i, p in enumerate(points)}
    recorded = defaultdict(list)
    visits = defaultdict(list)
    seen_rows = set()
    previous = None
    predecessors = Counter()
    for row in trace:
        assert None not in row, 'trace field count matches its header'
        if row['scenario'] == 'preparation solo':
            continue
        case, size = row['use_case'], int(row['size_bytes'])
        ident = (case, size)
        assert ident in label_for, f'trace point exists in samples: {ident}'
        a = row['contender']
        members = participants(roster, case)
        assert a in members
        n = len(members)
        round_, position = int(row['round']), int(row['position'])
        assert 0 <= round_ < rounds
        point_offset, within = divmod(position, n)
        assert point_offset == (point_index[ident] - round_) % len(points), 'recorded point rotation'
        stamp = (PHASE[case], round_, point_offset, within)
        assert previous is None or stamp > previous[0], 'trace follows recorded dispatch order'
        if previous is not None and PHASE[case] == previous[0][0]:
            predecessors[(previous[1], a)] += 1
        previous = (stamp, a)
        identity = (round_, case, size, a)
        assert identity not in seen_rows, f'one trace row per sampled dispatch: {identity}'
        seen_rows.add(identity)
        visit = visits[ident]
        if not visit or visit[-1][0] != round_:
            visit.append((round_, []))
        assert within == len(visit[-1][1]), 'each recorded visit has contiguous positions'
        visit[-1][1].append(a)
        iterations = int(row['iterations'])
        assert iterations > 0 and (case not in BATCH or size % 64 == 0)
        units = iterations * (size // 64 if case in BATCH else size)
        key = (a, 'solo', case, label_for[ident])
        recorded[key].append((int(row['wall_ns']), units))
        assert run.units[key] == ('msg' if case in BATCH else 'B')
        if case in SHARED:
            assert row['scenario'] == 'solo and shared'
            copies = [int(row[f'copy{i}_ns']) for i in range(2)]
            assert int(row['duo_ns']) == max(copies)
            recorded[(a, 'shared', case, label_for[ident])].extend((ns, units) for ns in copies)
        else:
            assert row['scenario'] == 'solo' and row['duo_ns'] == ''
    assert set(recorded) == set(run.cells), 'every sampled cell appears in the trace exactly'
    for key, values in recorded.items():
        assert values == run.measured[key], f'exact wall ns, work units, sample order and count: {key}'
    balanced, partial = 0, 0
    for (case, size), rows in visits.items():
        members = participants(roster, case)
        n = len(members)
        order_count = 1 if n == 1 else n if n % 2 == 0 else 2 * n
        expected_count = rounds if explicit_rounds else min(rounds, ((12 + order_count - 1) // order_count) * order_count)
        assert len(rows) == expected_count, 'every point has the contracted visit count'
        positions, adjacent = Counter(), Counter()
        for _, row in rows:
            assert len(row) == n and set(row) == set(members), 'every participant at every visit'
            positions.update((a, p) for p, a in enumerate(row))
            adjacent.update(zip(row, row[1:]))
        if len(rows) % order_count:
            partial += 1
            continue
        for a in members:
            for p in range(n):
                assert positions[a, p] == len(rows) // n, 'equal positions in a complete design'
            for b in members:
                if b != a:
                    assert adjacent[a, b] == len(rows) // n, 'equal within-visit ordered adjacencies'
        balanced += 1
    return {'trace_dispatches': len(seen_rows), 'sample_cells': len(recorded),
            'complete_balanced_points': balanced, 'partial_design_points': partial,
            'dispatch_predecessor_counts': {f'{a}->{b}': n for (a, b), n in sorted(predecessors.items())},
            'scope': 'sampled dispatches and recorded accounting; calibration, internal calls and causal performance validity remain open'}


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('samples', type=Path)
    p.add_argument('trace', type=Path)
    p.add_argument('--reader', required=True, type=Path)
    p.add_argument('--explicit-rounds', action='store_true')
    args = p.parse_args()
    spec = importlib.util.spec_from_file_location('shared_samples', args.reader)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    run = module.read(args.samples)
    with args.trace.open(newline='') as f:
        reader = csv.DictReader(f)
        required = {'round', 'position', 'contender', 'size_bytes', 'iterations', 'wall_ns', 'use_case', 'duo_ns', 'copy0_ns', 'copy1_ns', 'scenario'}
        assert required <= set(reader.fieldnames), 'clock trace contains the accounting fields'
        result = check(run, reader, args.explicit_rounds)
    print(json.dumps(result, indent=2))

if __name__ == '__main__':
    main()
