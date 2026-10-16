import json
from pathlib import Path
D={'types':{},'aliases':{'Matrices':'Matrix','Vectors':'Vector'},'phrases':[],'functions':{}}
def typ(n,args,lean,tex): D['types'][n]={'args':args,'lean':lean,'latex':tex}
def phrase(p,t): D['phrases'].append({'pattern':p,'type':t})
def fn(n,ps,r,l,t): D['functions'][n]={'params':ps.split(';') if ps else [],'returns':r,'lean':l,'latex':t}
for n,l,t in [('Natural','ℕ',r'\mathbb{{N}}'),('Real','ℝ',r'\mathbb{{R}}'),('Complex','ℂ',r'\mathbb{{C}}'),('Proposition','Prop',r'\mathrm{{Prop}}')]:
 typ(n,[],l,t); phrase(n+r'(?: number)?s?',n)
typ('Matrix',['dimension','dimension','type'],'Matrix (Fin {0}) (Fin {1}) {2}',r'{2}^{{{0}\times {1}}}')
typ('Vector',['dimension','type'],'Fin {0} → {1}',r'{1}^{{{0}}}')
typ('Vertex',['dimension'],'Fin {0}',r'\{{0,\ldots,{0}-1\}}')
typ('Graph',['dimension'],'SimpleGraph (Fin {0})',r'\operatorname{{SimpleGraph}}(\{{0,\ldots,{0}-1\}})')
typ('List',['type'],'List ({0})',r'\operatorname{{List}}({0})')
typ('Set',['type'],'Set ({0})',r'\mathcal{{P}}({0})')
typ('Function',['type','type'],'({0}) → ({1})',r'({0}\to {1})')
for word,base in [('complex','Complex'),('real','Real')]:
 phrase(word+r' (?P<m>\w+)\s*[×x]\s*(?P<n>\w+) matrices',f'Matrix({{m}},{{n}},{base})')
 phrase(word+r' (?P<m>\w+)\s*[×x]\s*(?P<n>\w+) matrix',f'Matrix({{m}},{{n}},{base})')
 phrase(word+r' (?P<n>\w+)-vectors?',f'Vector({{n}},{base})')
phrase(r'lists? of natural numbers','List(Natural)')
phrase(r'real functions','Function(Real,Real)')
for n,l,t in [('det','Matrix.det',r'\det'),('trace','Matrix.trace',r'\operatorname{{tr}}')]: fn(n,'Matrix($n,$n,$K)','$K',l+' {0}',t+'({0})')
fn('transpose','Matrix($m,$n,$K)','Matrix($n,$m,$K)','Matrix.transpose {0}',r'{{{0}}}^{{\mathsf T}}')
fn('inverse','Matrix($n,$n,$K)','Matrix($n,$n,$K)','({0})⁻¹',r'{{{0}}}^{{-1}}')
for name in ('exp','log','sqrt','sin','cos'):
 fn(name,'Real','Real','Real.'+name+' {0}', ('\\'+name+'({0})') if name!='sqrt' else r'\sqrt{{{0}}}')
fn('abs','Real','Real','abs {0}',r'\lvert {0}\rvert')
fn('continuous','Function(Real,Real)','Proposition','Continuous {0}',r'\operatorname{{Continuous}}({0})')
fn('differentiable','Function(Real,Real)','Proposition','Differentiable ℝ {0}',r'\operatorname{{Differentiable}}({0})')
fn('compose','Function($B,$C);Function($A,$B)','Function($A,$C)','({0}) ∘ ({1})',r'({0}\circ {1})')
fn('adjacent','Graph($n);Vertex($n);Vertex($n)','Proposition','({0}).Adj {1} {2}',r'{1}\sim_{{{0}}}{2}')
fn('complement','Graph($n)','Graph($n)','({0})ᶜ',r'\overline{{{0}}}')
for name,op,tex in [('union','⊔',r'\cup'),('intersection','⊓',r'\cap')]: fn(name,'Graph($n);Graph($n)','Graph($n)','{0} '+op+' {1}','({0} '+tex+' {1})')
fn('neighbors','Graph($n);Vertex($n)','Set(Vertex($n))','({0}).neighborSet {1}',r'N_{{{0}}}({1})')
fn('support','Graph($n)','Set(Vertex($n))','({0}).support',r'\operatorname{{supp}}({0})')
fn('subgraph','Graph($n);Graph($n)','Proposition','{0} ≤ {1}',r'{0}\subseteq {1}')
fn('reachable','Graph($n);Vertex($n);Vertex($n)','Proposition','({0}).Reachable {1} {2}',r'{1}\leadsto_{{{0}}}{2}')
fn('connected','Graph($n)','Proposition','({0}).Connected',r'\operatorname{{Connected}}({0})')
for name,lean in [('insertionSort','List.insertionSort (· ≤ ·)'),('mergeSort','fun l : List ℕ => l.mergeSort (· ≤ ·)')]:
 fn(name,'List(Natural)','List(Natural)','('+lean+') {0}',r'\operatorname{{'+name+'}}({0})')
fn('sorted','List(Natural)','Proposition','List.Sorted (· ≤ ·) {0}',r'\operatorname{{Sorted}}({0})')
fn('permutation','List($T);List($T)','Proposition','List.Perm {0} {1}',r'{0}\sim_{{\mathrm{{perm}}}}{1}')
fn('length','List($T)','Natural','List.length {0}',r'\lvert {0}\rvert')
fn('insert','Natural;List(Natural)','List(Natural)','List.orderedInsert (· ≤ ·) {0} {1}',r'\operatorname{{insert}}({0},{1})')
fn('cons','Natural;List(Natural)','List(Natural)','{0} :: {1}',r'({0}::{1})')
fn('sublist','List($T);List($T)','Proposition','List.Sublist {0} {1}',r'{0}\preccurlyeq {1}')
fn('count','Natural;List(Natural)','Natural','List.count {0} {1}',r'\operatorname{{count}}({0},{1})')
fn('merge','List(Natural);List(Natural)','List(Natural)','List.merge {0} {1} (· ≤ ·)',r'\operatorname{{merge}}({0},{1})')
fn('coprime','Natural;Natural','Proposition','Nat.Coprime {0} {1}',r'\operatorname{{coprime}}({0},{1})')
fn('gcd','Natural;Natural','Natural','Nat.gcd {0} {1}',r'\gcd({0},{1})')
fn('lcm','Natural;Natural','Natural','Nat.lcm {0} {1}',r'\operatorname{{lcm}}({0},{1})')
fn('commonNeighbors','Graph($n);Vertex($n);Vertex($n)','Set(Vertex($n))','({0}).commonNeighbors {1} {2}',r'N_{{{0}}}({1})\cap N_{{{0}}}({2})')

# English surrounds mathematical expressions in publication output.
prose = {
 'Natural': ('a natural number','natural numbers'),
 'Real': ('a real number','real numbers'),
 'Complex': ('a complex number','complex numbers'),
 'Proposition': ('a proposition','propositions'),
 'Matrix': (r'a matrix of size ${0}\times {1}$ over ${2}$',r'${0}\times {1}$ matrices over ${2}$'),
 'Vector': (r'a vector of length ${0}$ over ${1}$',r'${0}$-vectors over ${1}$'),
 'Vertex': (r'a vertex in $\{{0,\ldots,{0}-1\}}$',r'vertices in $\{{0,\ldots,{0}-1\}}$'),
 'Graph': (r'a simple graph on $\{{0,\ldots,{0}-1\}}$',r'simple graphs on $\{{0,\ldots,{0}-1\}}$'),
 'List': (r'a list with entries in ${0}$',r'lists with entries in ${0}$'),
 'Set': (r'a subset of ${0}$',r'subsets of ${0}$'),
 'Function': (r'a function from ${0}$ to ${1}$',r'functions from ${0}$ to ${1}$')
}
for name,(singular,plural) in prose.items():
 D['types'][name].update(prose=singular,prose_plural=plural)
for name,template in {
 'continuous':r'{0}\text{{ is continuous}}',
 'differentiable':r'{0}\text{{ is differentiable}}',
 'adjacent':r'{1}\text{{ is adjacent to }}{2}\text{{ in }}{0}',
 'subgraph':r'{0}\text{{ is a subgraph of }}{1}',
 'reachable':r'{2}\text{{ is reachable from }}{1}\text{{ in }}{0}',
 'connected':r'{0}\text{{ is connected}}',
 'sorted':r'{0}\text{{ is sorted}}',
 'permutation':r'{0}\text{{ is a permutation of }}{1}',
 'sublist':r'{0}\text{{ is a sublist of }}{1}',
 'coprime':r'{0}\text{{ and }}{1}\text{{ are coprime}}'
}.items(): D['functions'][name]['latex']=template

Path(__file__).with_name('cleanlang').joinpath('registry.json').write_text(json.dumps(D,indent=2,ensure_ascii=False)+'\n')
