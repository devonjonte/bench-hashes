"""Diagnostic (Python plumbing, no verdict): for mt solo IdleManyMessages,
split each side's samples at twice the pooled 10th percentile into a fast
and a slow state, and print each state's median per message and the slow
state's share. Run in this folder: python3 states.py DIR..."""
import glob, statistics as st, sys


def samples(f, point):
    for l in open(f):
        p = l.rstrip('\n').split('\t')
        if len(p) > 5 and p[0] == 'blake3-servil-mt' and p[1] == 'solo' and p[2] == 'IdleManyMessages' and p[3] == point:
            return [int(a) / int(b) for a, b in (x.split('/') for x in p[5].split(','))]
    return []


for d in sys.argv[1:]:
    print('##', d)
    for pt in ['2', '4', '8', '16', '32']:
        side = {'old': [], 'new': []}
        for f in sorted(glob.glob(f'{d}/run-*.tsv')):
            side['old' if f.endswith('old.tsv') else 'new'] += samples(f, pt)
        pooled = sorted(side['old'] + side['new'])
        cut = 2 * pooled[len(pooled) // 10]
        row = []
        for k in ('old', 'new'):
            v = side[k]
            fast, slow = [x for x in v if x <= cut], [x for x in v if x > cut]
            row.append(f"{k}: fast {st.median(fast):.0f} ns, slow {st.median(slow) if slow else 0:.0f} ns, slow {100 * len(slow) / len(v):.0f}% of {len(v)}")
        print(f'{pt:>3} msgs | ' + ' | '.join(row))
