#!/usr/bin/env python3
"""The latency probe's cross-machine tables, in Markdown, from each machine's host_lab.latency.tsv.

    table.py NAME=FILE ...

Every time is a median over the cell's visits, in microseconds, of the input's write and the call together
(the bench's definition of a call after a gap). "Today" is the faster of the two calls as the library ships
(convenience::hash; throughput::hash_multithreaded). "Kept awake" is hash_multithreaded under the best of the
settings that keep workers polling and split from 32 KiB; the setting is named.
"""
import sys

def percentile(sorted_values, percent):
    return sorted_values[min(len(sorted_values) * percent // 100, len(sorted_values) - 1)]

def read(path):
    cells, settings = {}, []
    for line in open(path):
        if line.startswith('#'):
            continue
        f = line.rstrip('\n').split('\t')
        if f[0] == 'setting':
            continue
        values = sorted(int(h) + int(w) for h, w in zip(f[7].split(','), f[8].split(',')))
        p_cycles, p_ns, e_cycles, e_ns = (int(x) for x in f[9:13])
        if f[0] not in settings:
            settings.append(f[0])
        cells[(f[0], f[4], f[5], int(f[6]))] = {
            'p50': percentile(values, 50) / 1000, 'p99': percentile(values, 99) / 1000, 'n': len(values),
            'mhz': round((p_cycles + e_cycles) * 1000 / (p_ns + e_ns)) if p_ns + e_ns else None,
        }
    return cells, settings

def short(setting):
    return 'all' if setting.startswith('all ') else setting.split(' ')[0]

def us(x):
    return f"{x:.1f}" if x >= 10 else f"{x:.2f}"

def main():
    machines = [(a.split('=', 1)[0], read(a.split('=', 1)[1])) for a in sys.argv[1:]]
    sizes = [(65536, '64 KiB'), (262144, '256 KiB'), (1 << 20, '1 MiB'), (4 << 20, '4 MiB')]
    for gap, title in (('nonstop', 'back to back'), ('other work', 'after other work'), ('idle 5 ms', 'after 5 ms asleep')):
        print(f"\n**One message {title}: today's best call, then with helpers kept awake (how many), and the share of today's time.**\n")
        print('| Machine | ' + ' | '.join(name for _, name in sizes) + ' |')
        print('|---|' + '---|' * len(sizes))
        for name, (cells, settings) in machines:
            row = f"| {name} |"
            for size, _ in sizes:
                today = min(cells[(settings[0], gap, call, size)]['p50'] for call in ('st', 'mt'))
                best, which = min((cells[(s, gap, 'mt', size)]['p50'], short(s)) for s in settings if ' awake' in s)
                row += f" {us(today)} → {us(best)} ({which}), ×{best / today:.2f} |"
            print(row)
    print("\n**One message on the calling thread (`convenience::hash`) after 5 ms asleep: as it ships, with one helper kept awake, with three; and the calling thread's clock in GHz, as it ships and with three awake.**\n")
    small = [(1024, '1 KiB'), (16384, '16 KiB'), (65536, '64 KiB'), (1 << 20, '1 MiB')]
    print('| Machine | ' + ' | '.join(name for _, name in small) + ' | clock |')
    print('|---|' + '---|' * (len(small) + 1))
    for name, (cells, settings) in machines:
        one = next(s for s in settings if s.startswith('1 awake'))
        three = next(s for s in settings if s.startswith('3 awake'))
        row = f"| {name} |"
        for size, _ in small:
            a, b, c = (cells[(s, 'idle 5 ms', 'st', size)]['p50'] for s in (settings[0], one, three))
            row += f" {us(a)} → {us(b)} → {us(c)} (×{c / a:.2f}) |"
        mhz = [cells[(s, 'idle 5 ms', 'st', 65536)]['mhz'] for s in (settings[0], three)]
        row += f" {mhz[0] / 1000:.1f} → {mhz[1] / 1000:.1f} |" if all(mhz) else ' - |'
        print(row)
    print("\n**256 KiB over the pool, the median and [the 99th percentile]: as it ships, then under the best setting above.**\n")
    print('| Machine | back to back | after other work | after 5 ms asleep |')
    print('|---|---|---|---|')
    for name, (cells, settings) in machines:
        row = f"| {name} |"
        for gap in ('nonstop', 'other work', 'idle 5 ms'):
            ships = cells[(settings[0], gap, 'mt', 262144)]
            best = min((cells[(s, gap, 'mt', 262144)] for s in settings if ' awake' in s), key=lambda c: c['p50'])
            row += f" {us(ships['p50'])} [{us(ships['p99'])}] → {us(best['p50'])} [{us(best['p99'])}] |"
        print(row)

if __name__ == '__main__':
    main()
