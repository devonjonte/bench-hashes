#!/usr/bin/env python3
"""Read one host_lab.latency.tsv (BLAKE3 probe/latency-ready, examples/host_lab.rs) and print, for each gap,
the calls' times in microseconds under each setting: the median, with the 99th percentile in brackets where
asked, and each setting's median as a share of today's best call for that size (the faster of one thread and
the pool, as the library ships).

    read-latency.py FILE [--p99] [--mean] [--write]

--mean prints means in place of medians; --write adds the input's write to each call's time.
"""
import sys

def percentile(sorted_values, percent):
    return sorted_values[min(len(sorted_values) * percent // 100, len(sorted_values) - 1)]

def size_name(n):
    return f"{n >> 20} MiB" if n >= 1 << 20 else f"{n >> 10} KiB"

def main():
    path = sys.argv[1]
    flags = set(sys.argv[2:])
    head, cells, settings, gaps = [], {}, [], []
    for line in open(path):
        if line.startswith('#'):
            head.append(line.rstrip('\n'))
            continue
        f = line.rstrip('\n').split('\t')
        if f[0] == 'setting':
            continue
        setting, gap, call, size = f[0], f[4], f[5], int(f[6])
        hash_ns = [int(x) for x in f[7].split(',')]
        write_ns = [int(x) for x in f[8].split(',')]
        values = [h + w for h, w in zip(hash_ns, write_ns)] if '--write' in flags else hash_ns
        p_cycles, p_ns, e_cycles, e_ns = (int(x) for x in f[9:13])
        if setting not in settings:
            settings.append(setting)
        if gap not in gaps:
            gaps.append(gap)
        ordered = sorted(values)
        cells[(setting, gap, call, size)] = {
            'n': len(values), 'mean': sum(values) / len(values), 'p50': percentile(ordered, 50), 'p90': percentile(ordered, 90),
            'p99': percentile(ordered, 99), 'max': ordered[-1],
            'mhz': round((p_cycles + e_cycles) * 1000 / (p_ns + e_ns)) if p_ns + e_ns else None,
            'e': round(e_ns * 100 / (p_ns + e_ns)) if p_ns + e_ns else None,
        }
    print('\n'.join(head))
    middle = 'mean' if '--mean' in flags else 'p50'
    short = {s: ('all up' if s.startswith('all ') else s.replace(', split 32 KiB', '').replace(' awake', ' up')) for s in settings}
    width = max(18 if '--p99' in flags else 10, max(len(v) for v in short.values()) + 2)
    for gap in gaps:
        print(f"\n== {gap}: {'mean' if middle == 'mean' else 'median'} us" + (' [p99]' if '--p99' in flags else '') + (', write and call' if '--write' in flags else ', the call alone'))
        print(f"{'call':<4} {'size':>8} " + ''.join(f"{short[s]:>{width}}" for s in settings) + '   | best today -> best kept awake (setting): share')
        sizes = sorted({k[3] for k in cells})
        for call in ('st', 'mt'):
            for size in sizes:
                if (settings[0], gap, call, size) not in cells:
                    continue
                row = f"{call:<4} {size_name(size):>8} "
                for s in settings:
                    c = cells[(s, gap, call, size)]
                    text = f"{c[middle] / 1000:.2f}"
                    if '--p99' in flags:
                        text += f" [{c['p99'] / 1000:.1f}]"
                    row += f"{text:>{width}}"
                # Today's best call for this size, and the best under a setting that keeps workers awake.
                today = min(cells[(settings[0], gap, k, size)][middle] for k in ('st', 'mt') if (settings[0], gap, k, size) in cells)
                awake = [(cells[(s, gap, call, size)][middle], short[s]) for s in settings if ' awake' in s]
                if call == 'mt' and awake:
                    best, which = min(awake)
                    row += f"   | {today / 1000:.2f} -> {best / 1000:.2f} ({which}): x{best / today:.2f}"
                print(row)
    if any(c['mhz'] for c in cells.values()):
        print("\n== the calling thread's clock over the write and the call, MHz (and its share of time on efficiency cores, %)")
        for gap in gaps:
            print(f"-- {gap}")
            for call, size in (('st', 1024), ('st', 65536), ('st', 1 << 20), ('mt', 1 << 20)):
                if (settings[0], gap, call, size) not in cells:
                    continue
                row = f"{call:<4} {size_name(size):>8} "
                for s in settings:
                    c = cells[(s, gap, call, size)]
                    row += f"{str(c['mhz']) + ' (' + str(c['e']) + ')':>{width if width > 12 else 13}}"
                print(row)

if __name__ == '__main__':
    main()
