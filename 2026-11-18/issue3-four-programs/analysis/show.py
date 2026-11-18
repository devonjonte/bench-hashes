#!/usr/bin/env python3
"""Arrange the rows of `issue3-audit --looks` (issue3-arms/looks.tsv) by machine and comparison.
Every verdict and interval is the Rust reader's; this prints them and counts them."""
import collections, re, sys
rows = []
for line in open('$HOME/bench-hashes-validation/issue3-arms/looks.tsv'):
    d, pairs, cell, rule_ratio, rule_verdict, decision, at, need, spread, looks, ins, first4 = line.rstrip('\n').split('\t')
    if 'issue3-arms/combined/' in d:
        host, comparison = d.split('/')[2:4]
        comparison += ' (64)'
    else:
        host, run, kept = d.split('/')[1:4]
        comparison = kept.replace('kept-', '') + ' (16)'
    rows.append(dict(host=host, comparison=comparison, pairs=int(pairs), cell=cell, rule_ratio=int(rule_ratio), rule=rule_verdict,
                     decision=decision, at=int(at), need=need, spread=int(spread), looks=looks, ins=ins, first4=first4))
def short(cell):
    c, _, use, point = cell.split('|')
    return f"{'st' if c.endswith('-st') else 'mt'} {'after a pause' if use.startswith('Idle') else 'after other work'} {point}"
detail = '--cells' in sys.argv
for host in sorted({r['host'] for r in rows}):
    print(f'\n== {host}')
    for comparison in ['null (16)', 'null (64)', 'plant (16)', 'plant (64)', 'release (16)', 'release (64)', 'far (16)', 'bound (16)', 'bound-policy (16)', 'policy-release (16)', 'policy-release (64)']:
        sel = [r for r in rows if r['host'] == host and r['comparison'] == comparison]
        if not sel:
            continue
        rule = collections.Counter(r['rule'] for r in sel)
        new = collections.Counter(r['decision'] for r in sel)
        ats = collections.Counter(r['at'] for r in sel)
        ins = collections.Counter(r['first4'] for r in sel)
        print(f"  {comparison:13} {sel[0]['pairs']:2} pairs, {len(sel):2} cells | today's rule (3%): {dict(rule)} | stopping rule (5%): {dict(new)}, decided at {dict(sorted(ats.items()))} pairs | instructions in the first 4 pairs: {dict(ins)}")
        if detail:
            for r in sel:
                last = r['looks'].split(' ')[-1]
                more = f" (about {r['need']} pairs to decide)" if r['need'] != '-' else ''
                print(f"      {short(r['cell']):34} today x{r['rule_ratio']/1000:.3f} {r['rule']:7} | {r['decision']:11} at {r['at']:2}{more} | last look {last:24} | one pair's spread {r['spread']/10:.1f}% | instructions x{r['ins']} {r['first4']}")
