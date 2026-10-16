"""Curated statements; regenerate provenance and .clean files from pinned sources."""
import argparse, json, re, subprocess
from pathlib import Path
ROOT=Path(__file__).parent
p=argparse.ArgumentParser(); p.add_argument('--mathlib',type=Path,default=Path('/work/stewart-lean/.lake/packages/mathlib')); a=p.parse_args()
rev=subprocess.check_output(['git','rev-parse','HEAD'],cwd=a.mathlib,text=True).strip()
items=[]
def add(cat,name,source,decl,lets,assumptions,claim,proof,topic):
    items.append(dict(category=cat,name=name,title=name.replace("_", " "),source_file=source,source_declaration=decl,lets=lets,assumptions=assumptions,claim=claim,proof=proof,topic=topic))
D='Mathlib/LinearAlgebra/Matrix/Determinant/Basic.lean'
T='Mathlib/LinearAlgebra/Matrix/Trace.lean'
M='Mathlib/Data/Matrix/Mul.lean'
B='Mathlib/LinearAlgebra/Matrix/Defs.lean'
L=['n: Natural','A, B, C: Matrix(n,n,Complex)']
def la(name,file,decl,claim,proof,lets=None,assumptions=[]): add('linear_algebra',name,file,decl,lets or L,assumptions,claim,proof,'Finite dimensional matrix algebra')
la('determinant_product',D,'Matrix.det_mul','det(A*B) = det(A)*det(B)','Matrix.det_mul A B')
la('determinant_transpose',D,'Matrix.det_transpose','det(transpose(A)) = det(A)','Matrix.det_transpose A')
la('determinant_product_swap',D,'Matrix.det_mul_comm','det(A*B) = det(B*A)','Matrix.det_mul_comm A B')
la('determinant_left_swap',D,'Matrix.det_mul_left_comm','det(A*(B*C)) = det(B*(A*C))','Matrix.det_mul_left_comm A B C')
la('determinant_right_swap',D,'Matrix.det_mul_right_comm','det(A*B*C) = det(A*C*B)','Matrix.det_mul_right_comm A B C')
la('determinant_power',D,'Matrix.det_pow','det(A^k) = det(A)^k','Matrix.det_pow A k',L+['k: Natural'])
la('trace_sum',T,'Matrix.trace_add','trace(A+B) = trace(A)+trace(B)','Matrix.trace_add A B')
la('trace_difference',T,'Matrix.trace_sub','trace(A-B) = trace(A)-trace(B)','Matrix.trace_sub A B')
la('trace_negative',T,'Matrix.trace_neg','trace(-A) = -trace(A)','Matrix.trace_neg A')
la('trace_transpose',T,'Matrix.trace_transpose','trace(transpose(A)) = trace(A)','Matrix.trace_transpose A')
la('trace_product_swap',T,'Matrix.trace_mul_comm','trace(A*B) = trace(B*A)','Matrix.trace_mul_comm A B')
la('trace_cycle',T,'Matrix.trace_mul_cycle','trace(A*B*C) = trace(C*A*B)','Matrix.trace_mul_cycle A B C')
V=L+['x, y: Vector(n,Complex)']
la('matrix_vector_associativity',M,'Matrix.mulVec_mulVec','A*(B*x) = (A*B)*x','Matrix.mulVec_mulVec x A B',V)
la('matrix_vector_addition',M,'Matrix.mulVec_add','A*(x+y) = A*x+A*y','Matrix.mulVec_add A x y',V)
la('matrix_addition_action',M,'Matrix.add_mulVec','(A+B)*x = A*x+B*x','Matrix.add_mulVec A B x',V)
la('matrix_vector_subtraction',M,'Matrix.mulVec_sub','A*(x-y) = A*x-A*y','Matrix.mulVec_sub A x y',V)
la('matrix_subtraction_action',M,'Matrix.sub_mulVec','(A-B)*x = A*x-B*x','Matrix.sub_mulVec A B x',V)
la('matrix_scalar_action',M,'Matrix.mulVec_smul','A*(c*x) = c*(A*x)','Matrix.mulVec_smul A c x',V+['c: Complex'])
la('transpose_involution',B,'Matrix.transpose_transpose','transpose(transpose(A)) = A','Matrix.transpose_transpose A')
la('transpose_product',M,'Matrix.transpose_mul','transpose(A*B) = transpose(B)*transpose(A)','Matrix.transpose_mul A B')
G='Mathlib/Combinatorics/SimpleGraph/Basic.lean'
C='Mathlib/Combinatorics/SimpleGraph/Connectivity/Connected.lean'
GL=['n: Natural','G, H: Graph(n)','u, v, w: Vertex(n)']
def gr(name,decl,claim,proof,assumptions=[],file=G): add('graph_theory',name,file,'SimpleGraph.'+decl,GL,assumptions,claim,proof,'Simple undirected graphs on finite labelled vertices')
gr('adjacency_symmetry','adj_symm','adjacent(G,v,u)','G.adj_symm edge',[('edge','adjacent(G,u,v)')])
gr('adjacency_commutes','adj_comm','adjacent(G,u,v) ↔ adjacent(G,v,u)','G.adj_comm u v')
gr('no_self_edges','irrefl','not adjacent(G,u,u)','G.irrefl')
gr('adjacent_vertices_distinct','ne_of_adj','u ≠ v','G.ne_of_adj edge',[('edge','adjacent(G,u,v)')])
gr('union_adjacency','sup_adj','adjacent(union(G,H),u,v) ↔ (adjacent(G,u,v) or adjacent(H,u,v))','SimpleGraph.sup_adj G H u v')
gr('intersection_adjacency','inf_adj','adjacent(intersection(G,H),u,v) ↔ (adjacent(G,u,v) and adjacent(H,u,v))','SimpleGraph.inf_adj G H u v')
gr('complement_adjacency','compl_adj','adjacent(complement(G),u,v) ↔ (u ≠ v and not adjacent(G,u,v))','SimpleGraph.compl_adj G u v')
gr('support_monotonicity','support_mono','support(G) ⊆ support(H)','SimpleGraph.support_mono inclusion',[('inclusion','subgraph(G,H)')])
gr('neighbors_in_support','neighborSet_subset_support','neighbors(G,u) ⊆ support(G)','G.neighborSet_subset_support u')
gr('neighbor_membership','mem_neighborSet','v ∈ neighbors(G,u) ↔ adjacent(G,u,v)','G.mem_neighborSet u v')
gr('not_own_neighbor','notMem_neighborSet_self','not (u ∈ neighbors(G,u))','G.notMem_neighborSet_self')
gr('common_neighbors_intersection','commonNeighbors_eq','commonNeighbors(G,u,v) = neighbors(G,u) ∩ neighbors(G,v)','G.commonNeighbors_eq u v')
gr('common_neighbors_membership','mem_commonNeighbors','w ∈ commonNeighbors(G,u,v) ↔ (adjacent(G,u,w) and adjacent(G,v,w))','G.mem_commonNeighbors')
gr('common_neighbors_symmetry','commonNeighbors_symm','commonNeighbors(G,u,v) = commonNeighbors(G,v,u)','G.commonNeighbors_symm u v')
gr('common_neighbors_left','commonNeighbors_subset_neighborSet_left','commonNeighbors(G,u,v) ⊆ neighbors(G,u)','G.commonNeighbors_subset_neighborSet_left u v')
gr('common_neighbors_right','commonNeighbors_subset_neighborSet_right','commonNeighbors(G,u,v) ⊆ neighbors(G,v)','G.commonNeighbors_subset_neighborSet_right u v')
gr('reachability_reflexive','Reachable.refl','reachable(G,u,u)','SimpleGraph.Reachable.refl u',file=C)
gr('reachability_symmetric','Reachable.symm','reachable(G,v,u)','path.symm',[('path','reachable(G,u,v)')],C)
gr('reachability_transitive','Reachable.trans','reachable(G,u,w)','first.trans second',[('first','reachable(G,u,v)'),('second','reachable(G,v,w)')],C)
gr('edge_implies_reachability','Adj.reachable','reachable(G,u,v)','edge.reachable',[('edge','adjacent(G,u,v)')],C)
E='Mathlib/Analysis/Complex/Exponential.lean'
# Exponential elementary facts live in Mathlib/Data/Complex/Exponential in some revisions.
if not (a.mathlib/E).exists(): E='Mathlib/Data/Complex/Exponential.lean'
LOG='Mathlib/Analysis/SpecialFunctions/Log/Basic.lean'; SQ='Mathlib/Data/Real/Sqrt.lean'
TR='Mathlib/Analysis/Complex/Trigonometric.lean'
CONT='Mathlib/Topology/Continuous.lean'
def an(name,file,decl,claim,proof,lets=['x, y: Real'],assumptions=[]): add('analysis',name,file,decl,lets,assumptions,claim,proof,'Real elementary analysis and continuity')
an('exponential_positive',E,'Real.exp_pos','0 < exp(x)','Real.exp_pos x')
an('exponential_nonzero',E,'Real.exp_ne_zero','exp(x) ≠ 0','Real.exp_ne_zero x')
an('exponential_sum',E,'Real.exp_add','exp(x+y) = exp(x)*exp(y)','Real.exp_add x y')
an('exponential_difference',E,'Real.exp_sub','exp(x-y) = exp(x)/exp(y)','Real.exp_sub x y')
an('logarithm_exponential',LOG,'Real.log_exp','log(exp(x)) = x','Real.log_exp x')
an('exponential_logarithm',LOG,'Real.exp_log','exp(log(x)) = x','Real.exp_log positive',assumptions=[('positive','0 < x')])
an('logarithm_product',LOG,'Real.log_mul','log(x*y) = log(x)+log(y)','Real.log_mul nonzero_x nonzero_y',assumptions=[('nonzero_x','x ≠ 0'),('nonzero_y','y ≠ 0')])
an('logarithm_quotient',LOG,'Real.log_div','log(x/y) = log(x)-log(y)','Real.log_div nonzero_x nonzero_y',assumptions=[('nonzero_x','x ≠ 0'),('nonzero_y','y ≠ 0')])
an('square_root_nonnegative',SQ,'Real.sqrt_nonneg','0 ≤ sqrt(x)','Real.sqrt_nonneg x')
an('square_of_square_root',SQ,'Real.sq_sqrt','sqrt(x)^2 = x','Real.sq_sqrt nonnegative',assumptions=[('nonnegative','0 ≤ x')])
an('square_root_of_square',SQ,'Real.sqrt_sq_eq_abs','sqrt(x^2) = abs(x)','Real.sqrt_sq_eq_abs x')
an('square_root_product',SQ,'Real.sqrt_mul','sqrt(x*y) = sqrt(x)*sqrt(y)','Real.sqrt_mul nonnegative y',assumptions=[('nonnegative','0 ≤ x')])
an('trigonometric_identity',TR,'Real.sin_sq_add_cos_sq','sin(x)^2+cos(x)^2 = 1','Real.sin_sq_add_cos_sq x')
an('sine_addition',TR,'Real.sin_add','sin(x+y) = sin(x)*cos(y)+cos(x)*sin(y)','Real.sin_add x y')
an('cosine_addition',TR,'Real.cos_add','cos(x+y) = cos(x)*cos(y)-sin(x)*sin(y)','Real.cos_add x y')
an('sine_odd',TR,'Real.sin_neg','sin(-x) = -sin(x)','Real.sin_neg x')
an('cosine_even',TR,'Real.cos_neg','cos(-x) = cos(x)','Real.cos_neg x')
F=['f, g: Function(Real,Real)']; AH=[('hf','continuous(f)'),('hg','continuous(g)')]
an('continuous_composition',CONT,'Continuous.comp','continuous(compose(f,g))','hf.comp hg',F,AH)
an('continuous_sum','Mathlib/Topology/Algebra/Monoid/Defs.lean','Continuous.add','continuous(f+g)','hf.add hg',F,AH)
an('continuous_product','Mathlib/Topology/Algebra/Monoid/Defs.lean','Continuous.mul','continuous(f*g)','hf.mul hg',F,AH)
SORT='Mathlib/Data/List/Sort.lean'; GCD='Mathlib/Data/Nat/GCD/Basic.lean'
LS=['xs, ys: List(Natural)','a, b: Natural']
def alg(name,decl,claim,proof,assumptions=[],topic='CLR comparison sorting',lets=LS,file=SORT): add('algorithms',name,file,decl,lets,assumptions,claim,proof,topic)
alg('insertion_sort_sorted','List.sorted_insertionSort','sorted(insertionSort(xs))','List.sorted_insertionSort (· ≤ ·) xs')
alg('insertion_sort_permutation','List.perm_insertionSort','permutation(insertionSort(xs),xs)','List.perm_insertionSort (· ≤ ·) xs')
alg('insertion_sort_length','List.length_insertionSort','length(insertionSort(xs)) = length(xs)','List.length_insertionSort (· ≤ ·) xs')
alg('insertion_sort_membership','List.mem_insertionSort','a ∈ insertionSort(xs) ↔ a ∈ xs','List.mem_insertionSort (r := (· ≤ ·))')
alg('sorted_input_unchanged','List.Sorted.insertionSort_eq','insertionSort(xs) = xs','ordered.insertionSort_eq',[('ordered','sorted(xs)')])
alg('ordered_insert_length','List.orderedInsert_length','length(insert(a,xs)) = length(xs)+1','List.orderedInsert_length (· ≤ ·) xs a')
alg('ordered_insert_membership','List.mem_orderedInsert','b ∈ insert(a,xs) ↔ b = a or b ∈ xs','List.mem_orderedInsert (· ≤ ·)')
alg('ordered_insert_permutation','List.perm_orderedInsert','permutation(insert(a,xs),cons(a,xs))','List.perm_orderedInsert (· ≤ ·) a xs')
alg('ordered_insert_preserves_sortedness','List.Sorted.orderedInsert','sorted(insert(a,xs))','ordered.orderedInsert a xs',[('ordered','sorted(xs)')])
alg('merge_sort_sorted','List.sorted_mergeSort\'','sorted(mergeSort(xs))','List.sorted_mergeSort\' (· ≤ ·) xs')
alg('merge_sort_sorted_input','List.mergeSort_eq_self','mergeSort(xs) = xs','List.mergeSort_eq_self (r := (· ≤ ·)) ordered',[('ordered','sorted(xs)')])
alg('sorting_algorithms_agree','List.mergeSort_eq_insertionSort','mergeSort(xs) = insertionSort(xs)','List.mergeSort_eq_insertionSort (r := (· ≤ ·)) xs')
alg('merge_preserves_sortedness','List.Sorted.merge','sorted(merge(xs,ys))','hx.merge hy',[('hx','sorted(xs)'),('hy','sorted(ys)')])
alg('insertion_sort_subsequence','List.sublist_insertionSort','sublist(ys,insertionSort(xs))','List.sublist_insertionSort ordered subsequence',[('ordered','sorted(ys)'),('subsequence','sublist(ys,xs)')])
alg('ordered_insert_contains_input','List.sublist_orderedInsert','sublist(xs,insert(a,xs))','List.sublist_orderedInsert (r := (· ≤ ·)) a xs')
NL=['a, b, k: Natural']
alg('euclidean_coprime_reduction','Nat.coprime_add_mul_right_right','coprime(a,b+k*a) ↔ coprime(a,b)','Nat.coprime_add_mul_right_right a b k',topic='CLR number theoretic algorithms: Euclidean invariants',lets=NL,file=GCD)
alg('euclidean_coprime_subtraction','Nat.coprime_sub_self_left','coprime(b-a,a) ↔ coprime(b,a)','Nat.coprime_sub_self_left ordered',[('ordered','a ≤ b')],topic='CLR number theoretic algorithms: Euclidean invariants',lets=NL,file=GCD)
alg('coprime_lcm_product','Nat.Coprime.lcm_eq_mul','lcm(a,b) = a*b','cop.lcm_eq_mul',[('cop','coprime(a,b)')],topic='CLR number theoretic algorithms: arithmetic supporting lemma',lets=NL,file=GCD)
alg('common_divisor_of_coprimes','Nat.eq_one_of_dvd_coprimes','k = 1','Nat.eq_one_of_dvd_coprimes cop divides_a divides_b',[('cop','coprime(a,b)'),('divides_a','k ∣ a'),('divides_b','k ∣ b')],topic='CLR number theoretic algorithms: arithmetic supporting lemma',lets=NL,file=GCD)
alg('coprime_product_divisibility','Nat.Coprime.dvd_mul_right','k ∣ a*b ↔ k ∣ a','cop.dvd_mul_right',[('cop','coprime(k,b)')],topic='CLR number theoretic algorithms: arithmetic supporting lemma',lets=NL,file=GCD)
# Remove unused parameters while retaining dimensions used by remaining types.
for item in items:
    used=set(re.findall(r"[^\W\d]\w*",item['claim']+' '+' '.join(p for _,p in item['assumptions'])))
    kept=[]
    for declaration in reversed(item['lets']):
        names,typ=declaration.split(':',1)
        selected=[n.strip() for n in names.split(',') if n.strip() in used]
        if selected:
            kept.append(', '.join(selected)+':'+typ)
            used.update(re.findall(r"[^\W\d]\w*",typ))
    item['lets']=list(reversed(kept))

# Locate exact declarations in pinned source; no fabricated upstream references.
# Namespace-qualified declarations can be written under a namespace in the source.
for it in items:
    path=a.mathlib/it['source_file']
    if not path.exists(): raise SystemExit('Missing source file: '+str(path))
    source_text=path.read_text()
    lines=source_text.splitlines(); decl=it['source_declaration']
    it['source_header']=source_text[:source_text.find('-/')+2] if source_text.startswith('/-') else ''
    search_decl = 'Continuous.mul' if decl == 'Continuous.add' else decl
    candidates=[search_decl]+['.'.join(search_decl.split('.')[i:]) for i in range(1,len(search_decl.split('.')))]
    found=[]
    for candidate in candidates:
        pattern=r'\b(?:theorem|lemma)\s+'+re.escape(candidate)+r'(?=\s|\{|\[|\()'
        found=[i for i,line in enumerate(lines) if re.search(pattern,line)]
        if found: break
    if not found: raise SystemExit('Declaration not found: '+decl+' in '+str(path))
    start=found[-1] if decl.startswith('Real.') else found[0]
    end=start+1
    while end<len(lines) and end<start+16 and not any(marker in '\n'.join(lines[start:end]) for marker in (' :=',' :=\n')): end+=1
    it['source_line']=start+1
    it['source_excerpt']='\n'.join(lines[start:end])
    it['source_url']=f'https://github.com/leanprover-community/mathlib4/blob/{rev}/{it["source_file"]}#L{start+1}'
    it['mathlib_revision']=rev
for cat in ['linear_algebra','graph_theory','analysis','algorithms']:
    selected=[i for i in items if i['category']==cat]; assert len(selected)>=20
    out=[]
    determinant_context={'determinant_product','determinant_transpose','determinant_product_swap','determinant_left_swap','determinant_right_swap'}
    if cat=='linear_algebra':
        out+=['Context complex square matrices:','    Let n: Natural','    Let A, B, C: Matrix(n,n,Complex)','']
    for it in selected:
        shared=cat=='linear_algebra' and it['name'] in determinant_context
        prefix='    ' if shared else ''
        out += [prefix+f'Result {it["title"]}:',prefix+f'    Attribution: mathlib; {it["source_declaration"]}; specialized']
        if not shared: out += [prefix+'    Let '+l for l in it['lets']]
        out += [prefix+f'    Assume {n}: {p}' for n,p in it['assumptions']]
        out += [prefix+'    Conclude: '+it['claim'],'']
    (ROOT/'corpus'/f'{cat}.clean').write_text('\n'.join(out))
(ROOT/'corpus'/'catalog.json').write_text(json.dumps(items,indent=2,ensure_ascii=False)+'\n')
refs={x['source_declaration']:{'url':x['source_url'],'file':x['source_file'],'line':x['source_line'],'revision':x['mathlib_revision']} for x in items}
(ROOT/'corpus'/'references.json').write_text(json.dumps(refs,indent=2)+'\n')
print('Collected',len(items),'statements at',rev)
