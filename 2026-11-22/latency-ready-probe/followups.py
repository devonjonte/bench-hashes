#!/usr/bin/env python3
"""The follow-up probes' tables, in Markdown, from this folder's files (run it here): the calling thread after
a rest (`rest`), narrower kernels for a now-and-then call (`cold`), helpers woken by a warning (`warn`), and what
helpers kept awake cost (`price`), and a hasher made early with nothing kept running (`early`). Times are medians
in microseconds."""
import os, re

def percentile(sorted_values, percent):
    return sorted_values[min(len(sorted_values) * percent // 100, len(sorted_values) - 1)]

def read(path, with_write):
    cells, settings = {}, []
    for line in open(path):
        if line.startswith('#'):
            continue
        f = line.rstrip('\n').split('\t')
        if f[0] == 'setting':
            continue
        calls, writes = [int(x) for x in f[7].split(',')], [int(x) for x in f[8].split(',')]
        values = sorted(c + w for c, w in zip(calls, writes)) if with_write else sorted(calls)
        if f[0] not in settings:
            settings.append(f[0])
        cells[(f[0], f[4], f[5], int(f[6]))] = percentile(values, 50) / 1000
    return cells, settings

def us(x):
    return f"{x:.1f}" if x >= 10 else f"{x:.2f}"

KIB = 1024
print("**The calling thread after 5 ms asleep (`rest`): `convenience::hash` of 1 KiB and of 64 KiB, the write and the call.**\n")
ways = ['as launched', 'QoS user-interactive', 'real-time policy', 'a background spinner', 'one worker awake']
print('| Machine | ' + ' | '.join(ways) + ' |')
print('|---|' + '---|' * len(ways))
for name, path in (('Apple M6', 'mac-m6/3-rest-realtime/host_lab.rest.tsv'), ('Apple M4', 'mac-m4/3-rest-realtime/host_lab.rest.tsv'),
                   ('Ryzen 9700X', 'x86-9700x/rest/host_lab.rest.tsv'), ('EPYC 7443P', 'x86-avx2/rest/host_lab.rest.tsv')):
    cells, settings = read(path, True)
    row = f'| {name} |'
    for way in ways:
        if way in settings and not (way.startswith('QoS') and 'x86' in path):
            row += f" {us(cells[(way, 'idle 5 ms', 'st', KIB)])}, {us(cells[(way, 'idle 5 ms', 'st', 64 * KIB)])} |"
        else:
            row += ' - |'
    print(row)

print("\n**A now-and-then call on narrower kernels (`cold`): the call alone on one thread, back to back → after other work.**\n")
for name, path in (('Xeon Gold 6330', 'x86-icelake/cold/host_lab.cold.tsv'), ('Ryzen 9700X', 'x86-9700x/cold/host_lab.cold.tsv'),
                   ('EPYC 9255', 'x86-epyc-9255/cold/host_lab.cold.tsv'), ('EPYC 7443P', 'x86-avx2/cold/host_lab.cold.tsv')):
    cells, settings = read(path, False)
    kernels = [s for s in settings if s != 'convenience::hash']
    print(f'{name}:\n')
    print('| Length | ' + ' | '.join(kernels) + ' |')
    print('|---|' + '---|' * len(kernels))
    for size, label in ((4 * KIB, '4 KiB'), (16 * KIB, '16 KiB'), (64 * KIB, '64 KiB'), (256 * KIB, '256 KiB')):
        print(f'| {label} | ' + ' | '.join(f"{us(cells[(k, 'nonstop', 'st', size)])} → {us(cells[(k, 'other work', 'st', size)])}" for k in kernels) + ' |')
    print()

print("**Helpers woken by a warning (`warn`), after 5 ms in which everything rests: 256 KiB over the pool (split from 32 KiB, three helpers), then 1 KiB on the calling thread; the write and the call.**\n")
leads = ['no warning', 'warned 0 us', 'warned 50 us', 'warned 200 us', 'warned 1 ms', 'warned 5 ms', 'kept awake']
print('| Machine | ' + ' | '.join(leads) + ' |')
print('|---|' + '---|' * len(leads))
for name, path in (('Apple M6', 'mac-m6/4-warn/host_lab.warn.tsv'), ('Apple M4', 'mac-m4/4-warn/host_lab.warn.tsv'), ('Ryzen 9700X', 'x86-9700x/warn/host_lab.warn.tsv'),
                   ('EPYC 9255', 'x86-epyc-9255/warn/host_lab.warn.tsv'), ('Xeon Gold 6330', 'x86-icelake/warn/host_lab.warn.tsv'), ('EPYC 7443P', 'x86-avx2/warn/host_lab.warn.tsv')):
    cells, settings = read(path, True)
    print(f'| {name} | ' + ' | '.join(f"{us(cells[(w, 'idle 5 ms', 'mt', 256 * KIB)])}, {us(cells[(w, 'idle 5 ms', 'st', KIB)])}" for w in leads) + ' |')

for helpers in (1, 3):
    paths = [(name, f'mac-{m}/5-warn-long-{helpers}/host_lab.warn.tsv') for name, m in (('Apple M6', 'm6'), ('Apple M4', 'm4'))]
    if not all(os.path.exists(p) for _, p in paths):
        continue
    print(f"\n**The Macs with longer leads, {'one helper' if helpers == 1 else 'three helpers'} woken: 1 KiB on the calling thread, then 64 KiB; the write and the call.**\n")
    cells, settings = read(paths[0][1], True)
    print('| Machine | ' + ' | '.join(settings) + ' |')
    print('|---|' + '---|' * len(settings))
    for name, path in paths:
        cells, settings = read(path, True)
        print(f'| {name} | ' + ' | '.join(f"{us(cells[(w, 'idle 5 ms', 'st', KIB)])}, {us(cells[(w, 'idle 5 ms', 'st', 64 * KIB)])}" for w in settings) + ' |')

print("\n**What helpers kept awake cost while no call comes (`price`, 10 s holds, there and back): watts by macOS's own estimate for the process.**\n")
print('| Machine | 1 awake | 3 awake | 7 awake | all awake |')
print('|---|---|---|---|---|')
for name, path in (('Apple M6', 'mac-m6/2-price/runner.log'), ('Apple M4', 'mac-m4/2-price/runner.log')):
    watts = {}
    for line in open(path):
        m = re.match(r'^\d{10}\s+(\d+)\s+[\d.]+\s+[\d.]+\s+([\d.]+)\s+\d+\s*$', line)
        if m:
            watts.setdefault(int(m.group(1)), []).append(float(m.group(2)))
    keys = sorted(k for k in watts if k)
    print(f'| {name} | ' + ' | '.join(f"{min(watts[k]):.1f} to {max(watts[k]):.1f}" if min(watts[k]) != max(watts[k]) else f"{watts[k][0]:.1f}" for k in keys) + ' |')

EARLY = (('Apple M6', 'mac-m6/7-early/host_lab.early.tsv'), ('Apple M4', 'mac-m4/7-early/host_lab.early.tsv'),
         ('Ryzen 9700X', 'x86-9700x/early/host_lab.early.tsv'), ('Xeon Gold 6330', 'x86-icelake/early/host_lab.early.tsv'))
LEADS = ('50 us', '200 us', '1 ms', '5 ms')
print("\n**A hasher made early with nothing kept running (`early`): one thread, the write and the call. With nothing done at the hello → with the kernels run there once over other bytes (share). The bytes come 200 μs or 5 ms after the hello.**\n")
print('| Machine | Message | after other work, 200 μs | after other work, 5 ms | after 5 ms asleep, 200 μs | after 5 ms asleep, 5 ms |')
print('|---|---|---|---|---|---|')
ranges = []
for name, path in EARLY:
    cells, _ = read(path, True)
    share = lambda way, pause, kind, size, lead: cells[(f'{way}, {lead}', pause, kind, size)] / cells[(f'nothing early, {lead}', pause, kind, size)]
    for size, size_name in ((KIB, '1 KiB'), (16 * KIB, '16 KiB'), (64 * KIB, '64 KiB')):
        row = f'| {name} | {size_name} |'
        for pause in ('other work', 'idle 5 ms'):
            for lead in ('200 us', '5 ms'):
                nothing, run = cells[(f'nothing early, {lead}', pause, 'st', size)], cells[(f'kernels run, {lead}', pause, 'st', size)]
                row += f' {us(nothing)} → {us(run)} ({run / nothing:.2f}) |'
        print(row)
    span = lambda shares: f'{min(shares):.2f} to {max(shares):.2f}'
    one_thread = lambda pause, leads, sizes=(KIB, 16 * KIB, 64 * KIB): span([share('kernels run', pause, 'st', size, lead) for size in sizes for lead in leads])
    ranges.append((name, one_thread('other work', LEADS[:2]), one_thread('other work', LEADS[2:]), one_thread('idle 5 ms', LEADS[:2]), one_thread('idle 5 ms', LEADS[2:]),
                   span([share('run and wake', pause, 'mt', 1 << 20, lead) for pause in ('other work', 'idle 5 ms') for lead in LEADS])))
print("\n**The same over every lead (50 μs, 200 μs, 1 ms, 5 ms): the share of the time with nothing done at the hello, lowest to highest. One thread at 1 KiB, 16 KiB and 64 KiB with the kernels run at the hello; then 1 MiB over the pool with the kernels run and three workers woken there.**\n")
print('| Machine | after other work, bytes within 200 μs | after other work, bytes after 1 ms or 5 ms | after 5 ms asleep, within 200 μs | after 5 ms asleep, after 1 ms or 5 ms | 1 MiB over the pool, workers woken |')
print('|---|---|---|---|---|---|')
for row in ranges:
    print('| ' + ' | '.join(row) + ' |')
