#!/usr/bin/env python3
"""Compare four samples files old/new/new/old, by each speed and its share.

    pypy3 tools/compare-runs.py OLD NEW NEW OLD [--map OneMessage=LentMessages]

Files can come from git history or new runs. --map explicitly compares
old/new use cases whose workloads deserve comparison; it makes no claim
that they measure the same thing. The fork's tools/speeds.py supplies the
shared rule. --rules can name that file in a separate fork checkout.
"""
import argparse
import importlib.util
from fractions import Fraction
from pathlib import Path


def load(path):
    run = SAMPLES.read(path)
    if run.busy:
        print(f'{path}: other programs kept the machine busy: {run.load}; descriptive values only, no speed evidence')
    elif not run.load_observed:
        print(f'{path}: no load observation; descriptive values only, no speed evidence: {run.load}')
    return {key: (run.units[key], values) for key, values in run.cells.items()}


def decimal(value, places=4):
    """An exact rational rounded once, half up, for a person."""
    scale = 10 ** places
    scaled = (value.numerator * scale * 2 + value.denominator) // (2 * value.denominator)
    return f'{scaled // scale}.{scaled % scale:0{places}d}'


def show_comparison(rule, a, b):
    c = rule.compare(a, b)
    def shown(s):
        total = sum(n for _, n in s)
        return ' | '.join(f'{decimal(m)} ({(n * 1000 + total // 2) // total}/1000)' for m, n in s)
    return (f"{shown(c['old'])} -> {shown(c['new'])}; fast {c['fast_permille']}/1000, "
            f"slow {c['slow_permille']}/1000; slow share "
            f"{c['old_slow_share_permille']}/1000 -> {c['new_slow_share_permille']}/1000")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('files', nargs='+')
    parser.add_argument('--map', action='append', default=[])
    parser.add_argument('--contender', action='append', default=[])
    parser.add_argument('--rules', type=Path, default=Path(__file__).resolve().parents[2] / 'tools/speeds.py')
    args = parser.parse_args()
    assert args.rules.is_file(), 'name the fork\'s tools/speeds.py with --rules'
    spec = importlib.util.spec_from_file_location('speed_rule', args.rules)
    rule = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(rule)
    global SAMPLES
    spec = importlib.util.spec_from_file_location('samples', args.rules.parent / 'samples.py')
    SAMPLES = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(SAMPLES)
    assert len(args.files) in (2, 4), 'supply two files for a historical comparison, or four for old/new/new/old'
    repeated = len(args.files) == 4
    if repeated:
        old1, new1, new2, old2 = (load(p) for p in args.files)
    else:
        old1, new1 = (load(p) for p in args.files)
        old2, new2 = old1, new1
    mapping = dict(x.split('=', 1) for x in args.map)
    compared = 0
    for key, (unit, a1) in old1.items():
        contender, scenario, case, point = key
        if args.contender and contender not in args.contender:
            continue
        if mapping and case not in mapping:
            continue
        target = (contender, scenario, mapping.get(case, case), point)
        if key not in old2 or target not in new1 or target not in new2:
            continue
        assert unit == old2[key][0] == new1[target][0] == new2[target][0], f'comparable units at {key}'
        a2, b1, b2 = old2[key][1], new1[target][1], new2[target][1]
        print(f'{contender} {scenario} {case}->{target[2]} {point} ({unit}):')
        print('  old/new: ' + show_comparison(rule, a1 + a2 if repeated else a1, b1 + b2 if repeated else b1))
        if repeated:
            print('  old/old: ' + show_comparison(rule, a1, a2))
            print('  new/new: ' + show_comparison(rule, b1, b2))
        compared += 1
    assert compared, 'the specified runs share measured cells'
    print(f'{compared} cells compared; ratios are new/old elapsed time, each speed separately.')


if __name__ == '__main__':
    main()
