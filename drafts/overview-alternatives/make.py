"""Six mock-ups of the overview for nine machines, from data.json
(extract.py), and an index that sets them side by side. Each page holds
one alternative; the numbers are for comparing layouts (see the note on
every page)."""
import json, os
D = os.path.dirname(os.path.abspath(__file__))
data = json.load(open(os.path.join(D, 'data.json')))
OUT = os.path.join(D, 'site')
os.makedirs(OUT, exist_ok=True)

ALTERNATIVES = [
    ('a-all-nine', 'A. Today\'s grid, all nine columns',
     'The current design, one column per machine. Every number is visible, but on a laptop screen the page scrolls sideways, and each bar is too narrow to read.'),
    ('b-four-chosen', 'B. Today\'s grid, four chosen machines',
     'Four columns that we choose (one Mac, one AMD server, one Intel desktop, one Intel server), the other five listed beneath with links. No new design, but which machines get columns is our choice, and a reader with a Zen 3 server finds it only by reading the list.'),
    ('c-number-lines', 'C. One number line per row',
     'Each machine is one dot, placed by how many times faster BLAKE3 servil is than official BLAKE3 there, and shaped by family. The spread across machines shows at a glance, and a dot left of 1x (a cost) cannot hide. Absolute GB/s and SHA-256 move to the tooltip and the machine\'s own map.'),
    ('d-families', 'D. A column per family',
     'Three columns, Arm, AMD and Intel. Each cell shows the family\'s range of GB/s for servil and for official, one tick per machine. It is compact and keeps GB/s, but which tick is which machine needs a hover.'),
    ('e-heatmap', 'E. A table of ratios',
     'Nine narrow columns of numbers, each cell "x faster than official" on a color from red (slower) to green (faster), GB/s in small type beneath. It fits a laptop screen and keeps every machine named, but it shows no SHA-256, and the reader reads numbers rather than shapes.'),
    ('f-pick', 'F. Today\'s grid, machines the reader picks',
     'Today\'s design with three columns, each a menu over all nine machines (default: M4 Max, EPYC 9255, i7-12700K). Any comparison is two clicks away, but the page shows three machines at a time, and the default choice is ours.'),
]

NOTE = ('Mock-up for choosing a design. Numbers: the i7-12700K and the M4 Max VM from the 0.8 release runs; '
        'the EPYC 9255 and the M4 Max from their published runs (October 23-24); the other five from rehearsal runs that measured an earlier commit. '
        '"x official" is against official BLAKE3 1.8.7 on one thread, the form every run measured. b3sum: four machines have a run.')

STYLE = '''
body{font:15px/1.4 system-ui,-apple-system,Segoe UI,sans-serif;margin:24px;color:#222;max-width:1400px}
h1{font-size:22px;margin:0 0 4px} p.lede{margin:4px 0 14px;max-width:62em;color:#333}
p.note{font-size:12px;color:#666;max-width:70em;border-left:3px solid #ddd;padding-left:8px}
table{border-collapse:collapse} th,td{padding:6px 8px;vertical-align:top;text-align:left}
th{font-weight:600;font-size:13px} td.sit{font-weight:600}
tr{border-top:1px solid #eee}
.bar{height:9px;margin:2px 0;border-radius:2px} .gb{font-size:11px;color:#555}
.s{background:#7c3aed} .o{background:#3b82f6} .h{background:#e07a45}
.legend span{display:inline-block;margin-right:14px;font-size:13px} .legend i{display:inline-block;width:12px;height:9px;margin-right:4px;border-radius:2px}
a{color:#4338ca}
'''

def page(slug, title, lede, body):
    nav = ' · '.join(f'<a href="{s}.html">{t.split(".")[0]}</a>' if s != slug else f'<b>{t.split(".")[0]}</b>' for s, t, _ in ALTERNATIVES)
    return f'''<!doctype html><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>{title}</title><style>{STYLE}</style>
<script>const DATA={json.dumps(data)};</script>
<p style="font-size:13px"><a href="index.html">All alternatives</a> · {nav}</p>
<h1>{title}</h1><p class="lede">{lede}</p>
{body}
<p class="note">{NOTE}</p>'''

def legend():
    return '<p class="legend"><span><i class="s"></i>BLAKE3 servil</span><span><i class="o"></i>BLAKE3 official</span><span><i class="h"></i>SHA-256</span></p>'

def grid_js(columns_expr):
    return '''<div id="g"></div><script>
function grid(cols){
 const rows=DATA.picks.map((p,i)=>{
  const vals=cols.map(m=>m.cells[i]);
  const max=Math.max(...vals.filter(Boolean).map(c=>Math.max(c.servil,c.official||0,c.sha256||0)));
  const tds=vals.map(c=>c?`<td>${['servil','official','sha256'].map((k,j)=>c[k]?`<div class="bar ${'soh'[j]}" style="width:${(c[k]/max*100).toFixed(1)}%"></div>`:'').join('')}<span class="gb">${c.servil.toPrecision(2)} GB/s · ${(c.servil/c.official).toFixed(1)}x</span></td>`:'<td class="gb">no run</td>').join('');
  return `<tr><td class="sit">${p}</td>${tds}</tr>`}).join('');
 return `<table style="width:100%;table-layout:fixed"><tr><th style="width:150px"></th>${cols.map(m=>`<th>${m.name}</th>`).join('')}</tr>${rows}</table>`}
''' + columns_expr + '</script>'

bodies = {}
bodies['a-all-nine'] = legend() + '<div style="overflow-x:auto"><div style="min-width:1500px">' + grid_js("document.getElementById('g').innerHTML=grid(DATA.machines);") + '</div></div>'
FOUR = ['M4 Max', 'EPYC 9255', 'i7-12700K', 'Xeon 6330']
bodies['b-four-chosen'] = legend() + grid_js(
    f"const four={json.dumps(FOUR)};document.getElementById('g').innerHTML=grid(four.map(s=>DATA.machines.find(m=>m.short==s)))"
    "+'<p><b>Other machines</b> (each links to its own map): '+DATA.machines.filter(m=>!four.includes(m.short)).map(m=>`<a href=\"#\">${m.name}</a>`).join(' · ')+'</p>';")
bodies['c-number-lines'] = '''<p class="legend"><span style="color:#15803d">▲ Arm</span><span style="color:#c2410c">● AMD</span><span style="color:#1d4ed8">■ Intel</span><span style="color:#666">(hover a mark: machine, GB/s)</span></p><svg id="c" width="1100" height="420"></svg><script>
const W=1100,L=260,R=1070,lo=Math.log(0.5),hi=Math.log(32),x=v=>L+(Math.log(v)-lo)/(hi-lo)*(R-L);
const color={AMD:'#c2410c',Intel:'#1d4ed8',Arm:'#15803d'};
const mark=(f,cx,cy,t)=>`<g fill="${color[f]}"><title>${t}</title>${f=='AMD'?`<circle cx="${cx}" cy="${cy}" r="5.5"/>`:f=='Intel'?`<rect x="${cx-5}" y="${cy-5}" width="10" height="10"/>`:`<path d="M${cx} ${cy-6.5} L${cx+6} ${cy+4.5} L${cx-6} ${cy+4.5} Z"/>`}</g>`;
let s='';[0.5,1,2,4,8,16,32].forEach(t=>{s+=`<line x1="${x(t)}" x2="${x(t)}" y1="30" y2="400" stroke="${t==1?'#999':'#eee'}" stroke-width="${t==1?2:1}"/><text x="${x(t)}" y="22" font-size="12" text-anchor="middle" fill="#555">${t}x</text>`});
s+=`<text x="${x(1)-6}" y="414" font-size="12" text-anchor="end" fill="#b91c1c">slower</text><text x="${x(1)+6}" y="414" font-size="12" fill="#15803d">faster than official BLAKE3</text>`;
DATA.picks.forEach((p,i)=>{const y=60+i*50;s+=`<text x="10" y="${y+5}" font-size="14" font-weight="600">${p}</text><line x1="${L}" x2="${R}" y1="${y}" y2="${y}" stroke="#ddd"/>`;
 const fam=['Arm','AMD','Intel'];DATA.machines.forEach(m=>{const c=m.cells[i];if(!c)return;const r=c.servil/c.official,dy=(fam.indexOf(m.family)-1)*9;
 s+=mark(m.family,x(r),y+dy,`${m.name}: ${r.toFixed(2)}x (servil ${c.servil.toPrecision(3)} GB/s, official ${c.official.toPrecision(3)} GB/s)`)})});
document.getElementById('c').innerHTML=s;</script>'''
bodies['d-families'] = '<p class="legend"><span><i class="s"></i>BLAKE3 servil, range over the family</span><span><i class="o"></i>BLAKE3 official</span><span style="color:#666">one tick per machine; hover a tick for its name</span></p><div id="d"></div><script>' + r'''
const fams=['Arm','AMD','Intel'];let h='<table style="width:100%;table-layout:fixed"><tr><th style="width:190px"></th>'+fams.map(f=>`<th>${f} (${DATA.machines.filter(m=>m.family==f).length} machines)</th>`).join('')+'</tr>';
DATA.picks.forEach((p,i)=>{const all=DATA.machines.map(m=>m.cells[i]).filter(Boolean),max=Math.max(...all.map(c=>Math.max(c.servil,c.official)));
 h+=`<tr><td class="sit">${p}</td>`+fams.map(f=>{const ms=DATA.machines.filter(m=>m.family==f&&m.cells[i]);if(!ms.length)return '<td class="gb">no run</td>';
  const one=k=>{const v=ms.map(m=>m.cells[i][k]),a=Math.min(...v),b=Math.max(...v);return `<div style="position:relative;height:14px;margin:3px 0"><div class="bar ${k=='servil'?'s':'o'}" style="position:absolute;left:${a/max*100}%;width:${Math.max((b-a)/max*100,0.6)}%;opacity:.35;top:2px"></div>`+ms.map(m=>`<div title="${m.name}: ${m.cells[i][k].toPrecision(3)} GB/s" style="position:absolute;left:${m.cells[i][k]/max*100}%;width:2px;height:14px;background:${k=='servil'?'#7c3aed':'#3b82f6'}"></div>`).join('')+'</div>'};
  const v=ms.map(m=>m.cells[i].servil);return `<td>${one('servil')}${one('official')}<span class="gb">servil ${Math.min(...v).toPrecision(2)}–${Math.max(...v).toPrecision(2)} GB/s</span></td>`}).join('')+'</tr>'});
document.getElementById('d').innerHTML=h+'</table>';</script>'''
bodies['e-heatmap'] = '<p class="legend"><span>each cell: times faster than official BLAKE3, and servil\'s GB/s</span></p><div id="e"></div><script>' + r'''
const col=r=>{if(Math.abs(Math.log(r))<0.03)return '#f7f7f7';const t=Math.max(-1,Math.min(1,Math.log2(r)/3));return t<0?`rgba(220,38,38,${-t*0.7+0.1})`:`rgba(22,163,74,${t*0.6+0.05})`};
let h='<table><tr><th></th>'+DATA.machines.map(m=>`<th style="font-size:12px;width:92px">${m.short}<br><span style="font-weight:400;color:#777">${m.family}</span></th>`).join('')+'</tr>';
DATA.picks.forEach((p,i)=>{h+=`<tr><td class="sit">${p}</td>`+DATA.machines.map(m=>{const c=m.cells[i];if(!c)return '<td class="gb" style="text-align:center">—</td>';const r=c.servil/c.official;
 return `<td style="background:${col(r)};text-align:center" title="${m.name}"><b>${r.toFixed(r<10?2:1)}x</b><br><span class="gb">${c.servil.toPrecision(2)} GB/s</span></td>`}).join('')+'</tr>'});
document.getElementById('e').innerHTML=h+'</table>';</script>'''
bodies['f-pick'] = legend() + '<p id="pick"></p>' + grid_js(r'''
const def=['M4 Max','EPYC 9255','i7-12700K'];
function draw(){const sel=[...document.querySelectorAll('#pick select')].map(s=>DATA.machines[s.value]);document.getElementById('g').innerHTML=grid(sel)}
document.getElementById('pick').innerHTML='Compare: '+def.map(d=>`<select>${DATA.machines.map((m,i)=>`<option value="${i}" ${m.short==d?'selected':''}>${m.name}</option>`).join('')}</select>`).join(' ');
document.querySelectorAll('#pick select').forEach(s=>s.onchange=draw);draw();''')

for slug, title, lede in ALTERNATIVES:
    open(os.path.join(OUT, f'{slug}.html'), 'w').write(page(slug, title, lede, bodies[slug]))

cards = ''.join(f'<div style="margin:0 0 28px"><h2 style="font-size:18px;margin:0"><a href="{s}.html">{t}</a></h2><p style="margin:4px 0 8px;max-width:62em">{l}</p><a href="{s}.html"><img src="{s}.png" style="max-width:100%;border:1px solid #ddd" alt="{t}"></a></div>' for s, t, l in ALTERNATIVES)
open(os.path.join(OUT, 'index.html'), 'w').write(f'''<!doctype html><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Nine machines on one overview: six designs</title><style>{STYLE}</style>
<h1>Nine machines on one overview: six designs</h1>
<p class="lede">The overview has one column per machine, and it is full at four. Nine machines now have runs. Each design below shows the same seven cells for all nine. Click one to open it full size (C and F respond to the mouse).</p>
<p class="note">{NOTE}</p>{cards}''')
print('wrote', len(ALTERNATIVES) + 1, 'pages in', OUT)
