"""The overview's seven cells (bench-hashes src/overview.rs PICKS) for each
machine, read from its text report: GB/s for BLAKE3 servil, BLAKE3 official
(single-threaded: the only form every run has) and SHA-256 (the faster of
the sha2 crate and ring). Writes data.json for the mock-ups.

The numbers are for comparing layouts. The i7 and VM come from the 0.8
release runs (934dee89). EPYC 9255 and M4 Max come from their published
runs (October 23-24). The other five come from Sam's rehearsal runs
(October 27), which measured the bench's pin, 49b43b1d."""
import json, re, subprocess

SAM = '1f1ee23cd4ae1098305f1de801e76ed0c081c386'
def sam(machine):
    return subprocess.run(['git', '-C', '/home/agent/BLAKE3-np', 'show', f'{SAM}:rehearsal-08-20261027/{machine}/rehearsal-4fa4d55/full.out'],
                          capture_output=True, text=True, check=True).stdout
R = '/home/agent/bench-hashes-validation/overview-alternatives/results'
def read(p): return open(p).read()

MACHINES = [  # name, family, short, report text, b3sum report text or None, source note
    ('Apple M4 Max', 'Arm', 'M4 Max', read(f'{R}/AppleM4Max.darwin25/bench-hashes.result.txt'), read(f'{R}/AppleM4Max.darwin25/b3sum.result.txt'), 'published run, Oct 24'),
    ('M4 Max VM, Linux', 'Arm', 'M4 VM', read(f'{R}/aarch64.linux618520virt/bench-hashes.result.txt'), read(f'{R}/aarch64.linux618520virt/b3sum.result.txt'), '0.8 release run'),
    ('AMD EPYC 9255 (Zen 5)', 'AMD', 'EPYC 9255', read(f'{R}/AMDEPYC925524CoreProcessor.linux70038generic/bench-hashes.result.txt'), read(f'{R}/AMDEPYC925524CoreProcessor.linux70038generic/b3sum.result.txt'), 'published run, Oct 23'),
    ('AMD Ryzen 7 9700X (Zen 5)', 'AMD', 'Ryzen 9700X', sam('zen5-9700x'), None, 'rehearsal, the pin'),
    ('AMD EPYC 9254 (Zen 4)', 'AMD', 'EPYC 9254', sam('zen4-9254p'), None, 'rehearsal, the pin'),
    ('AMD EPYC 7443P (Zen 3)', 'AMD', 'EPYC 7443P', sam('zen3-7443p'), None, 'rehearsal, the pin'),
    ('Intel i7-12700K (Alder Lake)', 'Intel', 'i7-12700K', read(f'{R}/12thGenIntelRCoreTMi712700K.linux70038generic/bench-hashes.result.txt'), read(f'{R}/12thGenIntelRCoreTMi712700K.linux70038generic/b3sum.result.txt'), '0.8 release run'),
    ('2x Intel Xeon Gold 6330 (Ice Lake)', 'Intel', 'Xeon 6330', sam('icelake-6330-c'), None, 'rehearsal, the pin'),
    ('Intel Xeon E5-1650 v4 (Broadwell)', 'Intel', 'Xeon E5-1650', sam('broadwell-1650v4'), None, 'rehearsal, the pin'),
]

def tables(text):
    """{title: {row label: {column: value}}} for the SOLO section's tables."""
    solo = text.split('SOLO:', 1)[1].split('SHARED:', 1)[0]
    out = {}
    for block in solo.split('\n\n'):
        lines = [l for l in block.splitlines() if l.strip()]
        if len(lines) < 3 or not lines[0].startswith('  ') or '(' not in lines[0]:
            continue
        title = re.sub(r'\s*\([^)]*\)\s*$', '', lines[0].strip())
        head = re.split(r'\s{2,}', lines[1].strip())
        rows = {}
        for l in lines[2:]:
            cells = re.split(r'\s{2,}', l.strip())
            if len(cells) == len(head):
                rows[cells[0]] = dict(zip(head[1:], cells[1:]))
        out[title] = rows
    return out

def num(v):
    try: return float(v)
    except (TypeError, ValueError): return None

PICKS = [  # label, table, row, servil column, unit bytes per value unit
    ('64 B', 'A message in one buffer, after other work', '64 B', 'B3 servil st', 1),
    ('1 KiB', 'A message in one buffer, after other work', '1 KiB', 'B3 servil st', 1),
    ('1 MiB, one thread', 'A message in one buffer, after other work', '1 MiB', 'B3 servil st', 1),
    ('128 MiB, every core', 'A message in one buffer, after other work', '128 MiB', 'B3 servil mt', 1),
    ('64 KiB messages, one after another', 'Messages one after another, buffers owned', '64 KiB', 'B3 servil mt', 1),
    ('1024 messages of 64 B, batched', 'A batch of 64-byte messages, after other work', '1024', 'B3 servil st', 64),
]

def b3sum_cell(text):
    if not text: return None
    sec = text.split('Files read from storage')[0]
    head = None
    for l in sec.splitlines():
        if l.startswith('input '):
            head = re.split(r'\s{2,}', l.strip())
        if head and l.startswith('mixed tree, 1000 files'):
            cells = re.split(r'\s{2,}', l.strip())
            vals = dict(zip(head, cells))
            gb = lambda s: float(re.search(r'([0-9.]+) GB/s', s).group(1)) if s and 'GB/s' in s else None
            return {'servil': gb(vals.get('b3sum')), 'official': gb(vals.get('official')), 'sha256': gb(vals.get('sha256sum'))}
    return None

data = {'picks': [p[0] for p in PICKS] + ['1000 files, b3sum'], 'machines': []}
for name, family, short, text, b3, source in MACHINES:
    t = tables(text)
    cells = []
    for label, table, row, servil, unit in PICKS:
        r = t[table][row]
        g = lambda col: (unit / num(r[col])) if num(r.get(col)) else None
        sha = max(x for x in (g('SHA-256'), g('SHA-256 ring')) if x)
        cells.append({'servil': g(servil), 'official': g('B3 official'), 'sha256': sha})
    cells.append(b3sum_cell(b3))
    data['machines'].append({'name': name, 'family': family, 'short': short, 'source': source, 'cells': cells})
json.dump(data, open('/home/agent/bench-hashes-validation/overview-alternatives/data.json', 'w'), indent=1)
for m in data['machines']:
    print(f"{m['short']:13}", ' '.join(f"{c['servil'] / c['official']:5.2f}x" if c else '   --' for c in m['cells']))
