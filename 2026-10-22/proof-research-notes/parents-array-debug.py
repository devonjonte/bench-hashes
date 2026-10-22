import sys
sys.path.insert(0, 'tools/verify')
import prove_sme2 as p
import induction as ind
original = ind.Generalized.__init__
def inspect(self, a, b, k):
    original(self, a, b, k)
    unknown = lambda v: isinstance(v, tuple) and v[0] == 'unknown'
    print('head scalar unknown', [r for r,v in self.x.items() if unknown(v)], flush=True)
    vec = [(r,i) for r,vs in self.v.items() for i,v in enumerate(vs) if unknown(v)]
    za = [(t,r,i) for t,rows in enumerate(self.za or []) for r,vs in enumerate(rows) for i,v in enumerate(vs) if unknown(v)]
    print('vector unknown',len(vec),'ZA unknown',len(za), flush=True)
    for r,i in vec[:2]:
        print('vector first/second',r,i,str(a.v[r][i])[:700],str(b.v[r][i])[:700], flush=True)
    for t,r,i in za[:2]:
        print('ZA first/second',t,r,i,str(a.za[t][r][i])[:700],str(b.za[t][r][i])[:700], flush=True)
ind.Generalized.__init__ = inspect
print(p.prove_parents_every(sys.argv[1]))
