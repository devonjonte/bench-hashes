"""The CHANGELOG's speed table from the overview the bench draws (bench
0.18.1, `bench-hashes overview`), so its figures are the overview's cells:
blake3-servil over official BLAKE3 1.8.7, both from the same run. Rows on
one thread compare one-thread forms; official is called as a program
normally calls it: on one thread (blake3::hash), but for one large message
on its thread pool (update_rayon); b3sum against official's b3sum. A ratio as the overview says it (one decimal below 10)."""
import re, sys, html
page = open(sys.argv[1]).read()
heads = dict(re.findall(r'<th class="col[^"]*" data-m="(\d+)" data-f="[^"]*" data-arch="[^"]*"><a href="[^"]*"><b>([^<]*)</b>', page))
rows = re.findall(r'<tr><td class="situation" title="[^"]*">([^<]*)</td>(.*?)</tr>', page, re.S)
def fig(r): return f"{r:.0f}×" if r >= 10 else f"{r:.1f}×"
want = {'64 B': ('One message of 64 B', 'st'), '1 KiB': ('One message of 1 KiB', 'st'), '1 MiB': ('One message of 1 MiB, one thread', 'st'),
        '128 MiB': ('One message of 128 MiB, every core', 'large'), '64 KiB messages, one after another': ('A stream of 64 KiB messages, every core', 'stream'),
        '1024 messages of 64 B, batched': ('A batch of 1024 messages, 64 B each', 'st'), '1000 files, b3sum': ('b3sum over 1000 files of mixed sizes', 'b3sum')}
order = ['Intel Core i7-12700K', 'AMD EPYC 9255', 'Apple M4 Max', 'aarch64']
names = {'aarch64': 'Linux VM on the M4 Max'}
table = {}
for label, cells in rows:
    label = html.unescape(label)
    if label not in want: continue
    for m, body in re.findall(r'<td class="col[^"]*" data-m="(\d+)"[^>]*>(.*?)</td>', cells, re.S):
        g = {k: float(v) for k, v in re.findall(r'data-k="([^"]+)" data-color="[^"]*" data-g="([0-9.e+-]+)"', body)}
        form = want[label][1]
        if form == 'st': r = g['blake3-servil-st'] / g['blake3-official']
        elif form == 'large': r = g['blake3-servil-mt'] / g['blake3-official-mt']
        elif form == 'stream': r = g['blake3-servil-mt'] / g['blake3-official']
        else: r = g['blake3-servil-mt'] / g['blake3-official-mt']   # b3sum's bars: servil's b3sum, official's b3sum
        table.setdefault(want[label][0], {})[heads[m]] = fig(r)
cols = [c for c in order if any(c in v for v in table.values())]
print('| | ' + ' | '.join(names.get(c, c.replace('Intel Core ', 'Intel ')) for c in cols) + ' |')
print('|---' * (len(cols) + 1) + '|')
for _, (row, _) in want.items():
    print(f'| {row} | ' + ' | '.join(table[row].get(c, '—') for c in cols) + ' |')
