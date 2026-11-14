#!/usr/bin/env python3
"""Check stored bytes and rendered bar descriptions; never interpret sample rows."""
from html.parser import HTMLParser
from pathlib import Path
import gzip,hashlib,json,subprocess

root=Path('<development-home>/bench-provenance-door')
out=Path('<development-home>/bench-hashes-validation/provenance-visibility')
base='da6fe3c478e3e25c23ab05514a1723e1e20f5e2f'
class Bars(HTMLParser):
    def __init__(self): super().__init__();self.items=[]
    def handle_starttag(self,tag,attrs):
        attrs=dict(attrs);classes=attrs.get('class','').split()
        if (tag=='i' and 'data-k' in attrs) or 'fam-bar' in classes or ('pick' in classes and 'data-tip' in attrs):
            self.items.append((tag,attrs))

old=subprocess.check_output(['git','show',base+':index.html'],cwd=root)
new=(root/'index.html').read_bytes()
a,b=Bars(),Bars();a.feed(old.decode());b.feed(new.decode())
assert a.items==b.items,'all displayed bar values, labels, notes and plot links stay exact'
receipt=json.loads((out/'style-publication/refresh-receipt.json').read_text())
old_css=(out/'style-publication/record-style-before.css').read_bytes()
new_css=(out/'style-publication/record-style-after.css').read_bytes()
for m in receipt['maps']:
    before=subprocess.check_output(['git','show',base+':'+m['path']],cwd=root)
    after=(root/m['path']).read_bytes()
    assert after.count(new_css)==1
    assert after.replace(new_css,old_css,1)==before
changed=subprocess.check_output(['git','diff','--name-only',base],cwd=root,text=True).splitlines()
for p in changed:
    if p.startswith(('benchmark-results/','beside/')):
        assert p.endswith('.map.html') or Path(p).name in {'SHA256SUMS','BLAKE3SUMS'},p
result={'base':base,'bar_elements_unchanged':len(a.items),'maps_css_only':len(receipt['maps']),
        'index_bytes':{'before':len(old),'after':len(new)},
        'index_gzip_bytes':{'before':len(gzip.compress(old,mtime=0)),'after':len(gzip.compress(new,mtime=0))},
        'index_sha256':hashlib.sha256(new).hexdigest(),
        'index_blake3':subprocess.check_output(['b3sum','--no-names',str(root/'index.html')],text=True).strip()}
(out/'presentation-audit.json').write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps(result,indent=2))
