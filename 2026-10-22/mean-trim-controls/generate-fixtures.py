"""Generate fixed v6 inputs. This neither measures nor reads benchmark samples."""
from pathlib import Path

root = Path(__file__).resolve().parent / 'fixtures'
root.mkdir(exist_ok=True)
header = ('# bench-hashes samples v6\n'
          '# power: synthetic arithmetic fixture; no measurement\n'
          '# load: unmeasured; synthetic arithmetic fixture\n'
          '# fixture: 1000/1060/2000 ns per unit are prescribed inputs\n'
          '# bench-hashes source: 61afea44ac45fc94f0a91d5e150b56689891f074\n'
          'contender\tscenario\tuse_case\tpoint\tunit\tns/units\tstart ms\tcpu ns\tenergy nJ\tcore counts\n')
for pair in range(4):
    for side in ('old', 'new'):
        rows = []
        for budget in (6, 24):
            for phase in range(10):
                for mode in ('Null', 'Uniform', 'Intermittent'):
                    values = []
                    for sample in range(budget):
                        ns = 1000
                        if side == 'new':
                            if mode == 'Uniform':
                                ns = 1060
                            elif mode == 'Intermittent' and (sample + phase) % 10 == 0:
                                ns = 2000
                        values.append(f'{ns}/1')
                    rows.append('\t'.join(('fixture', 'solo', mode,
                                           f'budget{budget} phase{phase}', 'unit',
                                           ','.join(values), ','.join(['0'] * budget),
                                           '-', '-', '-')))
        (root / f'{side}-{pair:02}.tsv').write_text(header + '\n'.join(rows) + '\n')
