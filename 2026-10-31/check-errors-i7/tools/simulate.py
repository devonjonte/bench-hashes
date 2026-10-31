"""check's two stages, resampled from A/A pairs, one cell planted.

Pairs are drawn whole (every cell of one pair together, keeping their
correlation) from the pooled A/A pairs; the planted cell's new side is
multiplied by 1 + effect. Stage 1: 4 pairs, all cells, BH q=0.05, margin
3%; if no cell slower, the suspects (level, ratio > 1.03, at most 8, chosen
by `rank`) are judged on 16 fresh pairs among themselves."""
import sys, random, math, statistics
sys.path.insert(0, sys.path[0]); from cells import *
Q, MARGIN = 0.05, 0.03
TCACHE = {}
def p_of(v):
    n = len(v); mu = sum(v)/n; var = sum((x-mu)**2 for x in v)/(n-1)
    if var == 0: return (1.0 if mu == 0 else 0.0), mu
    t = mu / math.sqrt(var/n)
    key = (round(abs(t), 2), n-1)
    if key not in TCACHE: TCACHE[key] = t_sf2(key[0], n-1)
    return TCACHE[key], mu
def judge(cols):
    tested = [p_of(c) for c in cols]; m = len(tested)
    order = sorted(range(m), key=lambda i: tested[i][0])
    k = max([r for r in range(1, m+1) if tested[order[r-1]][0] <= Q*r/m], default=0)
    out = ['level']*m
    for i in order[:k]:
        mu = tested[i][1]
        if math.exp(mu) > 1+MARGIN: out[i] = 'slower'
        elif math.exp(mu) < 1-MARGIN: out[i] = 'faster'
    return out, tested
def run(pool, keys, plant, effect, rank, rng):
    draw = lambda n: [rng.choice(pool) for _ in range(n)]
    def cols(ps, ks):
        return [[p[k] + (math.log1p(effect) if k == plant else 0) for p in ps] for k in ks]
    v1, t1 = judge(cols(draw(4), keys))
    if 'slower' in v1:
        return 'stage1' if v1[keys.index(plant)] == 'slower' else 'other'
    sus = [i for i in range(len(keys)) if v1[i] == 'level' and math.exp(t1[i][1]) > 1+MARGIN]
    if rank == 'ratio': sus.sort(key=lambda i: -t1[i][1])
    else: sus.sort(key=lambda i: t1[i][0])
    sus = [keys[i] for i in sus[:8]]
    if not sus: return 'missed'
    v2, _ = judge(cols(draw(16), sus))
    if 'slower' in v2:
        return 'stage2' if plant in sus and v2[sus.index(plant)] == 'slower' else 'other'
    return 'missed'
if __name__ == '__main__':
    dirs, plants, effects, rank, trials = sys.argv[1].split(','), sys.argv[2].split(','), [float(e) for e in sys.argv[3].split(',')], sys.argv[4], int(sys.argv[5])
    lr_pairs = []
    for d in dirs:
        for o, n in pairs(d):
            lr_pairs.append({k: math.log(n[k]/o[k]) for k in o if k in n})
    keys = sorted(set.intersection(*[set(p) for p in lr_pairs]))
    rng = random.Random(1)
    for plant in plants:
        for e in effects:
            c = defaultdict(int)
            for _ in range(trials): c[run(lr_pairs, keys, plant, e, rank, rng)] += 1
            print(f'{rank:5s} {plant:45s} +{100*e:4.0f}%: ' + ', '.join(f'{k} {c[k]}' for k in ['stage1','stage2','other','missed']) + f' of {trials}', flush=True)
